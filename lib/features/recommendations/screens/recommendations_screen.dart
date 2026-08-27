import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/scroll_signal_provider.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared_widgets/action_card.dart';

class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  ConsumerState<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen<DateTime?>(scrollToTopSignalProvider(2), (_, next) {
      if (next != null && _scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations')),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          Hero(
            tag: 'action_card_hero',
            child: Material(
              type: MaterialType.transparency,
              child: ActionCard(
                icon: Icons.water_drop,
                headline: 'Irrigate fields today',
                body: 'Soil moisture is dropping fast. Irrigating now will prevent yield loss.',
                buttonLabel: 'Completed',
                onButtonPressed: () {},
              ),
            ),
          ),
          const SizedBox(height: HarvestSpacing.lg),
          ...List.generate(30, (index) => ListTile(title: Text('Recommendation Item $index'))),
        ],
      ),
    );
  }
}
