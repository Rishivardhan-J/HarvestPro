import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Logic is handled by the GoRouter redirect. The screen itself just renders.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HarvestColors.bgLight, // bg background
      body: Center(
        child: Text(
          'HarvestPro',
          style: context.textTheme.displayMedium?.copyWith(
            color: HarvestColors.inkSoftLight, // ink-colored wordmark
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
