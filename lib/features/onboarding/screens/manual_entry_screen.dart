import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ManualEntryScreen extends StatelessWidget {
  const ManualEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Entry')),
      body: Center(
        child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor)),
      ),
    );
  }
}
