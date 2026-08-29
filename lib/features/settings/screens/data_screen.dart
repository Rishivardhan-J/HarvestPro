import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class DataScreen extends ConsumerWidget {
  const DataScreen({super.key});

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile?'),
        content: const Text(
            'Are you sure you want to delete your active profile and all its data? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: HarvestColors.statusCritical,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) {
      return;
    }

    final profile = ref.read(activeFarmerProfileProvider).valueOrNull;
    if (profile == null) {
      return;
    }

    try {
      final repo = ref.read(farmerProfileRepositoryProvider);
      await repo.deleteProfile(profile.id);

      // Refresh the profiles to see what's left
      final profiles = await repo.getAllProfiles();
      
      if (profiles.isEmpty) {
        // Full reset
        await ref.read(onboardingStateProvider.notifier).resetOnboarding();
        // activeFarmerProfileProvider will reload and yield null
        await ref.read(activeFarmerProfileProvider.notifier).setActiveProfile('');
      } else {
        // Switch to the first remaining profile
        await ref.read(activeFarmerProfileProvider.notifier).setActiveProfile(profiles.first.id);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data & Privacy')),
      body: ListView(
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Text(
            'Your Data, Your Control',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: HarvestSpacing.md),
          Text(
            'HarvestPro uses your data to provide personalized weather and crop advisories. We do not sell your data. You can delete your profile at any time.',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: HarvestSpacing.xxl),
          const Divider(),
          const SizedBox(height: HarvestSpacing.lg),
          Text(
            'Danger Zone',
            style: context.textTheme.titleMedium?.copyWith(color: HarvestColors.statusCritical),
          ),
          const SizedBox(height: HarvestSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => _handleDelete(context, ref),
            icon: const Icon(Icons.delete_forever, color: HarvestColors.statusCritical),
            label: const Text('Delete My Data', style: TextStyle(color: HarvestColors.statusCritical)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: HarvestColors.statusCritical),
              padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}
