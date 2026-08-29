import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../l10n/app_localizations.dart';

final streakProvider = FutureProvider.autoDispose<int>((ref) async {
  final profileAsync = ref.watch(activeFarmerProfileProvider);
  final profile = profileAsync.valueOrNull;
  if (profile == null) {
    return 0;
  }
  
  final captureRepo = ref.watch(captureRepositoryProvider);
  final recRepo = ref.watch(recommendationRepositoryProvider);
  
  final checkIns = await captureRepo.getAllDailyCheckIns(profile.id);
  final recs = await recRepo.getCompletedRecommendations(profile.id);
  
  final activeDates = <DateTime>{};
  
  for (final c in checkIns) {
    activeDates.add(DateTime(c.date.year, c.date.month, c.date.day));
  }
  for (final r in recs) {
    activeDates.add(DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day));
  }
  
  if (activeDates.isEmpty) {
    return 0;
  }
  
  final sortedDates = activeDates.toList()..sort((a, b) => b.compareTo(a));
  
  int streak = 0;
  DateTime currentDay = DateTime.now();
  currentDay = DateTime(currentDay.year, currentDay.month, currentDay.day);
  
  // Check if today is active
  if (sortedDates.contains(currentDay)) {
    streak = 1;
    currentDay = currentDay.subtract(const Duration(days: 1));
  } else if (sortedDates.contains(currentDay.subtract(const Duration(days: 1)))) {
    // Yesterday was active, streak is still alive
    streak = 1;
    currentDay = currentDay.subtract(const Duration(days: 2));
  } else {
    // Streak broken
    return 0;
  }
  
  // Count backwards
  for (int i = 0; i < sortedDates.length; i++) {
    if (sortedDates.contains(currentDay)) {
      streak++;
      currentDay = currentDay.subtract(const Duration(days: 1));
    }
  }
  
  return streak;
});

class StreakVisual extends ConsumerWidget {
  const StreakVisual({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakProvider);
    final l10n = AppLocalizations.of(context)!;

    return streakAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (streak) {
        if (streak == 0) {
          return const SizedBox.shrink();
        }

        // Growth stages: seed (0-1), sprout (2-3), small plant (4-6), mature (7+)
        IconData icon = Icons.grass;
        const Color color = HarvestColors.statusGood;
        double size = 48.0;

        if (streak <= 1) {
          icon = Icons.grain; // seed
          size = 32.0;
        } else if (streak <= 3) {
          icon = Icons.eco_outlined; // sprout
          size = 40.0;
        } else if (streak <= 6) {
          icon = Icons.eco; // small plant
        } else {
          icon = Icons.park; // mature
          size = 56.0;
        }

        final content = Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                if (MediaQuery.of(context).disableAnimations) {
                  value = 1.0;
                }
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Icon(icon, color: color, size: size),
            ),
            const SizedBox(width: HarvestSpacing.md),
            Expanded(
              child: Text(
                l10n.community_streakTitle(streak),
                style: context.textTheme.titleMedium?.copyWith(
                  color: HarvestColors.statusGood,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: HarvestSpacing.md, vertical: HarvestSpacing.sm),
          padding: const EdgeInsets.all(HarvestSpacing.md),
          decoration: BoxDecoration(
            color: HarvestColors.statusGood.withValues(alpha: 0.1),
            borderRadius: HarvestRadius.md,
            border: Border.all(color: HarvestColors.statusGood.withValues(alpha: 0.3)),
          ),
          child: content,
        );
      },
    );
  }
}
