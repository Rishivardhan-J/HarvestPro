import 'package:flutter/material.dart';
import 'package:harvestpro/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../theme/design_tokens.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(HarvestSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: HarvestColors.resolveStatusColor(const StatusCritical())),
              const SizedBox(height: HarvestSpacing.md),
              Text(
                l10n != null ? "That page doesn't exist" : "That page doesn't exist", // Placeholder until real l10n key exists
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: HarvestSpacing.lg),
              FilledButton(
                onPressed: () {}, // GoRouter will handle pop/home
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
