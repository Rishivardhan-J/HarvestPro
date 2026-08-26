import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/scroll_signal_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen<DateTime?>(scrollToTopSignalProvider(3), (_, next) {
      if (next != null && _scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Center(child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor))),
          const SizedBox(height: HarvestSpacing.md),
          ElevatedButton(
            onPressed: () => context.go('/community/post/mock_post_id'),
            child: const Text('View Post Detail'),
          ),
          ...List.generate(30, (index) => ListTile(title: Text('Community Post $index'))),
        ],
      ),
    );
  }
}
