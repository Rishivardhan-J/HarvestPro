import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DailyCheckinScreen extends StatelessWidget {
  const DailyCheckinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Check-in')),
      body: Center(
        child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor)),
      ),
    );
  }
}
