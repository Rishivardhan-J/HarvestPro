import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/repositories_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/recommendation.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared_widgets/action_card.dart';
import '../../../shared_widgets/error_state.dart';
import '../../../shared_widgets/offline_banner.dart';
import '../widgets/celebration_overlay.dart';
import '../widgets/swipeable_card.dart';

final recommendationsProvider = FutureProvider.autoDispose<List<Recommendation>>((ref) async {
  final profileAsync = ref.watch(activeFarmerProfileProvider);
  final profile = profileAsync.valueOrNull;
  if (profile == null) {
    return [];
  }
  
  final repo = ref.watch(recommendationRepositoryProvider);
  return repo.getActiveRecommendations(profile.id);
});

final completedCountProvider = StateProvider.autoDispose<int>((ref) => 0);

class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  ConsumerState<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  bool _showCelebration = false;
  Recommendation? _lastCompleted;

  Future<void> _handleSwipe(Recommendation rec, SwipeDirection direction) async {
    final repo = ref.read(recommendationRepositoryProvider);
    if (direction == SwipeDirection.right) {
      // Done
      await repo.updateRecommendationStatus(rec.id, RecommendationStatus.done);
      ref.read(completedCountProvider.notifier).state++;
      setState(() {
        _lastCompleted = rec;
        _showCelebration = true;
      });
    } else {
      // Remind Later
      final startOfNextDay = DateTime.now().add(const Duration(days: 1));
      final nextDay = DateTime(startOfNextDay.year, startOfNextDay.month, startOfNextDay.day);
      await repo.updateRecommendationStatus(rec.id, RecommendationStatus.remindLater, scheduledFor: nextDay);
    }
    ref.invalidate(recommendationsProvider);
  }

  void _onCelebrationComplete() {
    if (mounted) {
      setState(() {
        _showCelebration = false;
        _lastCompleted = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recommendationsAsync = ref.watch(recommendationsProvider);
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(activeFarmerProfileProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recommendations_title),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: recommendationsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => ErrorState(
                message: 'Failed to load recommendations.',
                onRetry: () => ref.invalidate(recommendationsProvider),
              ),
              data: (recs) {
                if (recs.isEmpty) {
                  final count = ref.watch(completedCountProvider);
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.eco, size: 80, color: HarvestColors.statusGood),
                        const SizedBox(height: HarvestSpacing.lg),
                        Text(l10n.recommendations_emptyTitle, style: context.textTheme.headlineMedium),
                        if (count > 0) ...[
                          const SizedBox(height: HarvestSpacing.sm),
                          Text(l10n.recommendations_emptySubtitle(count), style: context.textTheme.bodyLarge),
                        ]
                      ],
                    ),
                  );
                }

                // Build stack
                final stackItems = <Widget>[];
                // Show up to 3 cards (top + 2 peeked). Reversing so top is last in stack.
                final displayCount = recs.length > 3 ? 3 : recs.length;
                for (int i = displayCount - 1; i >= 0; i--) {
                  final rec = recs[i];
                  final isTop = (i == 0);
                  
                  final scale = 1.0 - (i * 0.04);
                  final offset = i * -8.0;

                  Widget card = Transform.translate(
                    offset: Offset(0, offset),
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.bottomCenter,
                      child: _buildCardContent(rec, profile?.landSizeAcres ?? 0, l10n),
                    ),
                  );

                  if (isTop) {
                    card = RecommendationSwipeCard(
                      recommendation: rec,
                      onSwiped: (dir) => _handleSwipe(rec, dir),
                      onNonGestureTapLeft: () => _handleSwipe(rec, SwipeDirection.left),
                      onNonGestureTapRight: () => _handleSwipe(rec, SwipeDirection.right),
                      child: card,
                    );
                  }
                  
                  stackItems.add(card);
                }

                return Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.lg),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: stackItems,
                        ),
                      ),
                    ),
                    if (_showCelebration && _lastCompleted != null)
                      Positioned.fill(
                        child: CelebrationOverlay(onComplete: _onCelebrationComplete),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(Recommendation rec, double landSize, AppLocalizations l10n) {
    IconData categoryIcon = Icons.eco;
    if (rec.category == RecommendationCategory.fertilizer) {
      categoryIcon = Icons.science;
    }
    if (rec.category == RecommendationCategory.pest) {
      categoryIcon = Icons.pest_control;
    }
    if (rec.category == RecommendationCategory.irrigation) {
      categoryIcon = Icons.water_drop;
    }

    // Formatting personalized copy
    String body = l10n.recommendations_valueTotal(rec.estimatedValueRupees.toStringAsFixed(0));
    if (rec.estimatedValueUnit == EstimatedValueUnit.perAcre && landSize > 0) {
      final totalValue = rec.estimatedValueRupees * landSize;
      body = l10n.recommendations_valuePerAcre(totalValue.toStringAsFixed(0), landSize.toStringAsFixed(1));
    }

    final title = _resolveRecKey(rec.titleKey, l10n);
    final desc = _resolveRecKey(rec.descriptionKey, l10n);

    return ActionCard(
      icon: categoryIcon,
      headline: title,
      body: '$desc\n$body',
      topRightWidget: Chip(
        label: Text(rec.category.name.toUpperCase()),
        backgroundColor: HarvestColors.inkLight.withValues(alpha: 0.1),
        labelStyle: context.textTheme.labelSmall,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  String _resolveRecKey(String key, AppLocalizations l10n) {
    switch (key) {
      case 'recommendations_fertilizer_urea':
        return l10n.recommendations_fertilizer_urea;
      case 'recommendations_fertilizer_urea_desc':
        return l10n.recommendations_fertilizer_urea_desc;
      case 'recommendations_pest_stem_borer':
        return l10n.recommendations_pest_stem_borer;
      case 'recommendations_pest_stem_borer_desc':
        return l10n.recommendations_pest_stem_borer_desc;
      default:
        return key;
    }
  }
}
