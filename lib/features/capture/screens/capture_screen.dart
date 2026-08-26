import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/scroll_signal_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen<DateTime?>(scrollToTopSignalProvider(1), (_, next) {
      if (next != null && _scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Capture')),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Center(child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor))),
          const SizedBox(height: HarvestSpacing.md),
          ElevatedButton(
            onPressed: () => context.go('/capture/daily-checkin'),
            child: const Text('Go to Daily Check-in'),
          ),
          // Add dummy content to make it scrollable
          ...List.generate(30, (index) => ListTile(title: Text('Capture Item $index'))),
        ],
      ),
    );
  }
}
