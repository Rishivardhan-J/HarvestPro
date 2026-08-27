import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:harvestpro/data/models/yield_prediction.dart';
import 'package:harvestpro/l10n/app_localizations.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/providers/scroll_signal_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared_widgets/action_card.dart';
import '../../../shared_widgets/reason_chip.dart';
import '../../../shared_widgets/source_badge.dart';
import '../../../shared_widgets/yield_gauge.dart';
import '../providers/home_provider.dart';
import '../utils/summary_generator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final FlutterTts _tts = FlutterTts();
  String? _lastNarratedPredictionId;
  String? _currentSummary;

  @override
  void dispose() {
    _scrollController.dispose();
    _tts.stop();
    super.dispose();
  }

  Future<void> _playNarration(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  void _handlePredictionLoaded(YieldPrediction prediction, AppLocalizations l10n) {
    if (_lastNarratedPredictionId == prediction.id) {
      return;
    }
    
    _lastNarratedPredictionId = prediction.id;
    final summary = SummaryGenerator.generate(prediction, l10n);
    setState(() {
      _currentSummary = summary;
    });

    final narrationEnabled = ref.read(voiceNarrationEnabledProvider);
    if (narrationEnabled && summary.isNotEmpty) {
      _playNarration(summary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<DateTime?>(scrollToTopSignalProvider(0), (_, next) {
      if (next != null && _scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    final predictionAsync = ref.watch(homeYieldPredictionProvider);

    ref.listen<AsyncValue<YieldPrediction?>>(homeYieldPredictionProvider, (prev, next) {
      next.whenData((prediction) {
        if (prediction != null) {
          _handlePredictionLoaded(prediction, l10n);
        }
      });
    });

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      floatingActionButton: _buildDebugFab(),
      body: SafeArea(
        bottom: false,
        child: predictionAsync.when(
          data: (prediction) {
            if (prediction == null) {
              return const Center(child: Text('No profile active'));
            }
            return _buildContent(context, prediction);
          },
          loading: () => _buildSkeleton(context),
          error: (err, st) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, YieldPrediction prediction) {
    final profile = ref.watch(activeFarmerProfileProvider).value;
    final summary = _currentSummary ?? SummaryGenerator.generate(prediction, AppLocalizations.of(context)!);

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.lg, vertical: HarvestSpacing.md),
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (profile != null)
              Expanded(
                child: Text(
                  '${profile.name} · ${profile.village}',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.theme.hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (prediction.sourceBadges.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: prediction.sourceBadges
                    .map((badge) => Padding(
                          padding: const EdgeInsets.only(left: HarvestSpacing.xs),
                          child: SourceBadgeWidget(badge: badge),
                        ))
                    .toList(),
              ),
          ],
        ),
        
        const SizedBox(height: HarvestSpacing.xl),
        
        // Gauge wrapped in RepaintBoundary
        RepaintBoundary(
          child: Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: YieldGauge(
                value: prediction.predictedYieldPercent / 100.0,
                status: _resolveStatusColor(prediction.status),
                statusLabel: _resolveStatusLabel(prediction.status, AppLocalizations.of(context)!),
              ),
            ),
          ),
        ),

        const SizedBox(height: HarvestSpacing.lg),

        // Summary Text
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                summary,
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, size: 20),
              color: context.theme.primaryColor,
              onPressed: () {
                if (summary.isNotEmpty) {
                  _playNarration(summary);
                }
              },
            )
          ],
        ),

        const SizedBox(height: HarvestSpacing.lg),

        // Reason Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: _buildOrderedChips(prediction.factors),
          ),
        ),

        const SizedBox(height: HarvestSpacing.xl),
        const Divider(),
        const SizedBox(height: HarvestSpacing.xl),

        // Action Card
        Hero(
          tag: 'action_card_hero',
          child: Material(
            type: MaterialType.transparency,
            child: ActionCard(
              icon: Icons.water_drop,
              headline: 'Irrigate fields today',
              body: 'Soil moisture is dropping fast. Irrigating now will prevent yield loss.',
              buttonLabel: 'View Details',
              onButtonPressed: () {
                // Pre-warm the recommendations screen data if needed
                context.go('/recommendations');
              },
            ),
          ),
        ),
        
        const SizedBox(height: 80), // Bottom safe-area padding
      ],
    );
  }

  List<Widget> _buildOrderedChips(List<YieldFactor> factors) {
    final sorted = List<YieldFactor>.from(factors)
      ..sort((a, b) => b.contributionValue.abs().compareTo(a.contributionValue.abs()));
      
    final widgets = <Widget>[];
    for (int i = 0; i < sorted.length; i++) {
      // In real code we'd localize the factor name for the chip too, 
      // but the blueprint specifically says: 
      // "Factor names in the sentence must themselves be localized..., not the raw internal factor label string used for the ReasonChip."
      widgets.add(ReasonChip(
        label: sorted[i].label.replaceFirst('factor_', ''),
        contribution: sorted[i].contributionValue,
      ));
      if (i < sorted.length - 1) {
        widgets.add(const SizedBox(width: HarvestSpacing.sm));
      }
    }
    return widgets;
  }

  Widget _buildSkeleton(BuildContext context) {
    final surfaceAlt = HarvestColors.surfaceAlt(context.brightness);
    
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.lg, vertical: HarvestSpacing.md),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 120, height: 16, color: surfaceAlt),
            Container(width: 80, height: 24, decoration: BoxDecoration(color: surfaceAlt, borderRadius: BorderRadius.circular(4))),
          ],
        ),
        const SizedBox(height: HarvestSpacing.xl),
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(color: surfaceAlt, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(height: HarvestSpacing.lg),
        Center(child: Container(width: 200, height: 16, color: surfaceAlt)),
        const SizedBox(height: 8),
        Center(child: Container(width: 150, height: 16, color: surfaceAlt)),
        const SizedBox(height: HarvestSpacing.lg),
        Row(
          children: [
            Container(width: 100, height: 32, decoration: BoxDecoration(color: surfaceAlt, borderRadius: BorderRadius.circular(16))),
            const SizedBox(width: HarvestSpacing.sm),
            Container(width: 80, height: 32, decoration: BoxDecoration(color: surfaceAlt, borderRadius: BorderRadius.circular(16))),
          ],
        ),
        const SizedBox(height: HarvestSpacing.xl),
        const Divider(),
        const SizedBox(height: HarvestSpacing.xl),
        Container(
          height: 120,
          decoration: BoxDecoration(color: surfaceAlt, borderRadius: BorderRadius.circular(12)),
        ),
      ],
    );
  }

  Widget? _buildDebugFab() {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        final current = ref.read(debugScenarioProvider);
        ref.read(debugScenarioProvider.notifier).state = (current + 1) % 4;
      },
      child: const Icon(Icons.bug_report),
    );
  }

  StatusColor _resolveStatusColor(YieldStatus status) {
    switch (status) {
      case YieldStatus.good:
        return const StatusGood();
      case YieldStatus.caution:
        return const StatusCaution();
      case YieldStatus.critical:
        return const StatusCritical();
    }
  }

  String _resolveStatusLabel(YieldStatus status, AppLocalizations l10n) {
    switch (status) {
      case YieldStatus.good:
        return l10n.home_gaugeStatusGood;
      case YieldStatus.caution:
        return l10n.home_gaugeStatusCaution;
      case YieldStatus.critical:
        return l10n.home_gaugeStatusCritical;
    }
  }
}
