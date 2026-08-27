import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/app_state_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../data/models/daily_checkin.dart';
import '../../../data/repositories/capture_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/checkin_provider.dart';

class DailyCheckinSheet extends ConsumerStatefulWidget {
  const DailyCheckinSheet({super.key});

  @override
  ConsumerState<DailyCheckinSheet> createState() => _DailyCheckinSheetState();
}

class _DailyCheckinSheetState extends ConsumerState<DailyCheckinSheet> {
  CheckinMood? _selectedMood;

  Future<void> _handleMoodSelection(CheckinMood mood) async {
    if (_selectedMood != null) {
      return; // Prevent multiple taps
    }
    
    setState(() => _selectedMood = mood);
    unawaited(HapticFeedback.selectionClick());

    final profile = ref.read(activeFarmerProfileProvider).valueOrNull;
    if (profile != null) {
      final checkIn = DailyCheckIn(
        id: const Uuid().v4(),
        farmerProfileId: profile.id,
        date: DateTime.now(),
        mood: mood,
        createdAt: DateTime.now(),
      );

      await ref.read(captureRepositoryProvider).saveDailyCheckIn(checkIn);
      ref.invalidate(todayCheckInProvider(profile.id)); // Refresh state
    }

    // Auto-dismiss after 600ms
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.capture_dailyCheckInTitle,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HarvestSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MoodButton(
                  emoji: '🙁',
                  mood: CheckinMood.sad,
                  isSelected: _selectedMood == CheckinMood.sad,
                  isAnySelected: _selectedMood != null,
                  onTap: () => _handleMoodSelection(CheckinMood.sad),
                ),
                _MoodButton(
                  emoji: '😐',
                  mood: CheckinMood.neutral,
                  isSelected: _selectedMood == CheckinMood.neutral,
                  isAnySelected: _selectedMood != null,
                  onTap: () => _handleMoodSelection(CheckinMood.neutral),
                ),
                _MoodButton(
                  emoji: '🙂',
                  mood: CheckinMood.happy,
                  isSelected: _selectedMood == CheckinMood.happy,
                  isAnySelected: _selectedMood != null,
                  onTap: () => _handleMoodSelection(CheckinMood.happy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final String emoji;
  final CheckinMood mood;
  final bool isSelected;
  final bool isAnySelected;
  final VoidCallback onTap;

  const _MoodButton({
    required this.emoji,
    required this.mood,
    required this.isSelected,
    required this.isAnySelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isSelected ? 1.2 : 1.0;
    final opacity = (!isSelected && isAnySelected) ? 0.3 : 1.0;

    return GestureDetector(
      onTap: isAnySelected ? null : onTap,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: MotionTokens.durationFor(context, MotionTokens.durationMicro),
        child: AnimatedScale(
          scale: scale,
          duration: MotionTokens.durationFor(context, MotionTokens.durationMicro),
          curve: MotionTokens.curveStandard,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HarvestColors.surfaceAlt(context.brightness),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 40)),
                ),
              ),
              if (isSelected)
                const Positioned(
                  bottom: -4,
                  right: -4,
                  child: Icon(Icons.check_circle, color: HarvestColors.accent, size: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
