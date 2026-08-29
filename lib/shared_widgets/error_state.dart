import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String? alternativeActionLabel;
  final VoidCallback? onAlternativeAction;

  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.alternativeActionLabel,
    this.onAlternativeAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(HarvestSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: HarvestColors.statusCritical),
            const SizedBox(height: HarvestSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: HarvestSpacing.xl),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: HarvestColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md, horizontal: HarvestSpacing.xl),
              ),
              child: const Text('Retry', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            if (alternativeActionLabel != null && onAlternativeAction != null) ...[
              const SizedBox(height: HarvestSpacing.md),
              TextButton(
                onPressed: onAlternativeAction,
                child: Text(alternativeActionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
