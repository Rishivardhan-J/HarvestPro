import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/sync_provider.dart';
import '../../../core/theme/design_tokens.dart';

class GlobalSyncListener extends ConsumerWidget {
  final Widget child;

  const GlobalSyncListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<DateTime?>(syncConfirmationProvider, (previous, next) {
      if (next != null && next != previous) {
        const msg = 'Background sync completed successfully';
        
        SemanticsService.sendAnnouncement(View.of(context), msg, Directionality.of(context));
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.cloud_done, color: HarvestColors.statusGood),
                SizedBox(width: HarvestSpacing.sm),
                Text(msg, style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: HarvestColors.inkDark,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });

    return child;
  }
}
