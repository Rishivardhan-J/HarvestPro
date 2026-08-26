import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';

enum StatusBadgeSize { small, large }

class StatusBadge extends StatelessWidget {
  final StatusColor status;
  final String label;
  final StatusBadgeSize size;

  const StatusBadge({
    super.key,
    required this.status,
    required this.label,
    this.size = StatusBadgeSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = size == StatusBadgeSize.small;
    
    // Layout parameters based on size variant
    final iconSize = isSmall ? 16.0 : 24.0;
    final gap = isSmall ? HarvestSpacing.xs : HarvestSpacing.sm;
    final padding = isSmall 
        ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0)
        : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
    
    // Typography
    final baseStyle = isSmall ? context.textTheme.labelLarge : context.textTheme.bodyLarge;
    final textStyle = baseStyle?.copyWith(
      fontWeight: FontWeight.w700, // Bold variant
      color: HarvestColors.resolveStatusColor(status),
    );

    // Color derivation
    final bgColor = HarvestColors.statusBg(status, context.brightness);
    final fgColor = HarvestColors.resolveStatusColor(status);

    // Icon resolution
    final IconData iconData = switch (status) {
      StatusGood() => Icons.check_circle_outline,
      StatusCaution() => Icons.warning_amber_outlined,
      StatusCritical() => Icons.error_outline,
    };

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: HarvestRadius.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: iconSize,
            color: fgColor,
          ),
          SizedBox(width: gap),
          Text(
            label,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
