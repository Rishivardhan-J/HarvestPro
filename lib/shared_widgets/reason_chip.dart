import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';

/// A chip representing a factor's contribution to the yield prediction.
class ReasonChip extends StatelessWidget {
  final String label;
  final double contribution; // -1.0 to 1.0
  final VoidCallback? onTap;

  const ReasonChip({
    super.key,
    required this.label,
    required this.contribution,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on sign. No caution color used here per Gap 1 extension.
    final isPositive = contribution >= 0;
    final StatusColor status = isPositive ? const StatusGood() : const StatusCritical();
    final fgColor = HarvestColors.resolveStatusColor(status);
    final bgColor = fgColor.withAlpha((255 * 0.60).round()); // 60% opacity

    // Determine icon size with sqrt scaling
    final absContrib = contribution.abs();
    double iconSize;
    if (absContrib < 0.15) {
      iconSize = 16.0;
    } else if (absContrib >= 0.5) {
      iconSize = 28.0;
    } else {
      // Scale between 0.15 and 0.5 using sqrt
      // Normalize to 0.0 - 1.0 range
      final normalized = (absContrib - 0.15) / (0.5 - 0.15);
      // Sqrt scaling
      final scaled = math.sqrt(normalized);
      // Map to 16.0 - 28.0 range
      iconSize = 16.0 + (scaled * (28.0 - 16.0));
    }

    final IconData icon = isPositive 
        ? Icons.trending_up 
        : Icons.trending_down;

    final textStyle = context.textTheme.labelLarge?.copyWith(
      color: fgColor, // Using full opacity foreground for readability
    );

    // Build the visual chip
    final Widget chip = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: HarvestRadius.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: fgColor),
          const SizedBox(width: 4.0),
          Text(label, style: textStyle),
        ],
      ),
    );

    // Wrap in GestureDetector and ensure 48dp min tap target
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48.0),
        child: Center(
          child: chip,
        ),
      ),
    );
  }
}

/// A horizontal scrollable row that staggers the entrance of its ReasonChips.
class ReasonChipRow extends StatefulWidget {
  final List<ReasonChip> chips;

  const ReasonChipRow({
    super.key,
    required this.chips,
  });

  @override
  State<ReasonChipRow> createState() => _ReasonChipRowState();
}

class _ReasonChipRowState extends State<ReasonChipRow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 900ms delay to wait for the gauge, plus enough time for all staggers
    final totalDuration = 900 + (widget.chips.length * 60) + 200;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalDuration),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: HarvestSpacing.lg), // 16dp edge padding
      child: Row(
        children: List.generate(widget.chips.length, (index) {
          final isLast = index == widget.chips.length - 1;
          
          if (disableAnimations) {
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : HarvestSpacing.sm),
              child: widget.chips[index],
            );
          }

          // Staggered timing: Wait 900ms (for gauge), then 60ms per index.
          final delayMs = 900 + (index * 60);
          final start = delayMs / _controller.duration!.inMilliseconds;
          final end = (delayMs + 200) / _controller.duration!.inMilliseconds;

          final curve = CurvedAnimation(
            parent: _controller,
            curve: Interval(start.clamp(0.0, 1.0), end.clamp(0.0, 1.0), curve: Curves.easeOut),
          );

          return Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : HarvestSpacing.sm), // 8dp gap
            child: AnimatedBuilder(
              animation: curve,
              builder: (context, child) {
                return Opacity(
                  opacity: curve.value,
                  child: Transform.translate(
                    offset: Offset(0, 8.0 * (1 - curve.value)),
                    child: child,
                  ),
                );
              },
              child: widget.chips[index],
            ),
          );
        }),
      ),
    );
  }
}
