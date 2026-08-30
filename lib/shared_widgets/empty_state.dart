import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/localization/locale_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../features/home/providers/home_provider.dart';

class EmptyState extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  ConsumerState<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends ConsumerState<EmptyState> {
  final FlutterTts _tts = FlutterTts();
  bool _hasNarrated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _playNarration();
      }
    });
  }

  Future<void> _playNarration() async {
    if (_hasNarrated) {
      return;
    }
    
    final voiceEnabled = ref.read(voiceNarrationEnabledProvider);
    if (!voiceEnabled) {
      return;
    }

    final locale = ref.read(localeProvider).languageCode;
    await _tts.setLanguage(locale == 'ta' ? 'ta-IN' : 'en-US');
    await _tts.speak('${widget.title}. ${widget.description}');
    _hasNarrated = true;
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 64, color: context.theme.disabledColor),
            const SizedBox(height: HarvestSpacing.lg),
            Text(
              widget.title,
              style: context.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HarvestSpacing.sm),
            Text(
              widget.description,
              style: context.textTheme.bodyLarge?.copyWith(color: context.theme.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HarvestSpacing.xl),
            ElevatedButton(
              onPressed: widget.onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: HarvestColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md, horizontal: HarvestSpacing.xl),
              ),
              child: Text(widget.actionLabel, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

