import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/app_theme.dart';
import '../theme/design_tokens.dart';

class JitPermissionFlow {
  /// Requests a permission using the "ask before you ask" pattern.
  /// 
  /// 1. Shows a custom, localized bottom sheet explaining *why* the permission is needed.
  /// 2. If the user taps "Allow", requests the actual OS permission.
  /// 3. If the user taps "Not now", returns [PermissionStatus.denied] without asking the OS.
  /// 4. Handles permanently denied states.
  static Future<PermissionStatus> requestWithRationale(
    BuildContext context, 
    Permission permission, {
    required String rationaleMessage,
    required IconData icon,
  }) async {
    // Check current status first
    var status = await permission.status;
    if (status.isGranted) {
      return status;
    }
    if (status.isPermanentlyDenied) {
      return status;
    }

    // Show rationale bottom sheet
    if (!context.mounted) {
      return PermissionStatus.denied;
    }
    
    final wantsToAllow = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(HarvestSpacing.xl)),
      ),
      builder: (context) => _PermissionRationaleSheet(
        rationaleMessage: rationaleMessage,
        icon: icon,
      ),
    );

    if (wantsToAllow == true) {
      // Trigger OS dialog
      status = await permission.request();
      
      // We return the actual status from the OS.
      // If it's permanently denied, the caller should handle showing a dialog to go to settings.
      return status;
    }

    return PermissionStatus.denied; // They tapped "Not now" or dismissed
  }

  /// Helper to show a dialog directing the user to OS settings if permanently denied.
  static Future<void> showSettingsDialog(BuildContext context, {required String message}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HarvestColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}

class _PermissionRationaleSheet extends StatelessWidget {
  final String rationaleMessage;
  final IconData icon;

  const _PermissionRationaleSheet({
    required this.rationaleMessage,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(HarvestSpacing.lg),
              decoration: BoxDecoration(
                color: HarvestColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: HarvestColors.accent),
            ),
            const SizedBox(height: HarvestSpacing.lg),
            Text(
              rationaleMessage,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: HarvestSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                      foregroundColor: Colors.grey.shade800,
                      side: BorderSide(color: Colors.grey.shade400, width: 2.0),
                    ),
                    child: const Text('Not now', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: HarvestSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                      backgroundColor: HarvestColors.accent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Allow', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
