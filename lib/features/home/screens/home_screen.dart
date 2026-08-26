import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/scroll_signal_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen<DateTime?>(scrollToTopSignalProvider(0), (_, next) {
      if (next != null && _scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(HarvestSpacing.lg),
                child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor)),
              ),
            );
          }
          return ListTile(title: Text('Home Item $index'));
        },
      ),
    );
  }
}
