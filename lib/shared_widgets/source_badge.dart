import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../data/models/yield_prediction.dart';

class SourceBadgeWidget extends StatelessWidget {
  final SourceBadge badge;

  const SourceBadgeWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    String text;
    IconData icon;

    switch (badge) {
      case SourceBadge.imdWeatherVerified:
        text = 'IMD Weather Verified';
        icon = Icons.verified;
        break;
      case SourceBadge.agriStackLinked:
        text = 'AgriStack Linked';
        icon = Icons.domain_verification;
        break;
    }

    // Using surface-alt background (Phase 2 derived token)
    final bgColor = HarvestColors.surfaceAlt(context.brightness);
    final fgColor = context.brightness == Brightness.light
        ? HarvestColors.inkSoftLight
        : HarvestColors.inkSoftDark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: HarvestSpacing.sm,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(HarvestSpacing.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.0, color: fgColor),
          const SizedBox(width: HarvestSpacing.xs),
          Text(
            text,
            style: context.textTheme.labelSmall?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
