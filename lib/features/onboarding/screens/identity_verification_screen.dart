import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identity Verification')),
      body: Center(
        child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor)),
      ),
    );
  }
}
