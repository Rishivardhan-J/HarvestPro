import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/farmer_profile.dart';

final allProfilesProvider = FutureProvider.autoDispose<List<FarmerProfile>>((ref) async {
  final repo = ref.watch(farmerProfileRepositoryProvider);
  return repo.getAllProfiles();
});

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  Future<void> _switchProfile(BuildContext context, WidgetRef ref, String id) async {
    await ref.read(activeFarmerProfileProvider.notifier).setActiveProfile(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Switched active profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(allProfilesProvider);
    final activeProfile = ref.watch(activeFarmerProfileProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Profiles')),
      body: profilesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load profiles: $e')),
        data: (profiles) {
          return ListView(
            padding: const EdgeInsets.all(HarvestSpacing.lg),
            children: [
              Text(
                'Switch Profile',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: HarvestSpacing.md),
              ...profiles.map((p) {
                final isActive = p.id == activeProfile?.id;
                return Card(
                  margin: const EdgeInsets.only(bottom: HarvestSpacing.sm),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isActive ? HarvestColors.accent : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: HarvestRadius.md,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isActive ? HarvestColors.accent : HarvestColors.inkLight,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${p.village}, ${p.district}'),
                    trailing: isActive
                        ? const Icon(Icons.check_circle, color: HarvestColors.accent)
                        : null,
                    onTap: isActive ? null : () => _switchProfile(context, ref, p.id),
                  ),
                );
              }),
              const SizedBox(height: HarvestSpacing.lg),
              OutlinedButton.icon(
                onPressed: () {
                  // This simulates "Add Profile". We just go to onboarding language.
                  // Since they already have a profile, we don't want to clear it, 
                  // but we want to put them in the identity choice flow.
                  ref.read(onboardingStateProvider.notifier).advanceToIdentityChoice().then((_) {
                    if (context.mounted) {
                      context.go('/onboarding/identity-choice');
                    }
                  });
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Add Another Profile'),
              ),
              if (activeProfile?.canLinkKisanId == true) ...[
                const SizedBox(height: HarvestSpacing.md),
                ElevatedButton.icon(
                  onPressed: () {
                    // Re-enters Phase 4 Part B flow
                    ref.read(onboardingStateProvider.notifier).advanceToIdentityVerifying().then((_) {
                      if (context.mounted) {
                        context.go('/onboarding/identity-verifying');
                      }
                    });
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('Link your Kisan ID'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HarvestColors.accent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
