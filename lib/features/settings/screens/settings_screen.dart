import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/design_tokens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(HarvestSpacing.lg),
        children: [
          ElevatedButton(
            onPressed: () => context.go('/settings/profiles'),
            child: const Text('Manage Profiles'),
          ),
          const SizedBox(height: HarvestSpacing.md),
          ElevatedButton(
            onPressed: () => context.go('/settings/data'),
            child: const Text('Data & Privacy'),
          ),
        ],
      ),
    );
  }
}
