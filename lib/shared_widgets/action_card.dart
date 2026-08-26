import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';

class ActionCard extends StatefulWidget {
  final IconData icon;
  final String headline;
  final String body;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  
  /// Extension point for Phase 7 swipe physics. Not wired to logic in Phase 1.
  final ValueChanged<DragStartDetails>? onSwipeStart;

  const ActionCard({
    super.key,
    required this.icon,
    required this.headline,
    required this.body,
    required this.buttonLabel,
    required this.onButtonPressed,
    this.onSwipeStart,
  });

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    // Determine elevation based on drag state
    final shadows = _isDragging 
        ? HarvestElevation.level2(context.brightness)
        : HarvestElevation.level1(context.brightness);

    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(HarvestSpacing.lg),
      decoration: BoxDecoration(
        color: context.theme.canvasColor, // surface
        borderRadius: HarvestRadius.md,
        boxShadow: shadows,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headline row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, size: 24.0, color: context.brightness == Brightness.light ? HarvestColors.inkLight : HarvestColors.inkDark),
              const SizedBox(width: HarvestSpacing.sm),
              Expanded(
                child: Text(
                  widget.headline,
                  style: context.textTheme.headlineLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: HarvestSpacing.sm),
          
          // Body text (max 3 lines, ellipsis)
          Text(
            widget.body,
            style: context.textTheme.bodyLarge,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: HarvestSpacing.lg),
          
          // Primary Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: HarvestColors.resolveInteractiveColor(const InteractiveAccent()),
                foregroundColor: HarvestColors.bgLight, // assuming dark text/icon on accent, or light. Usually inkLight works well on accent, but spec doesn't specify. I'll use bgLight for high contrast.
                padding: const EdgeInsets.symmetric(vertical: HarvestSpacing.md),
                shape: const RoundedRectangleBorder(borderRadius: HarvestRadius.md),
              ),
              onPressed: widget.onButtonPressed,
              child: Text(
                widget.buttonLabel,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HarvestColors.bgLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Provide a GestureDetector to simulate swipe state changes for the elevation
    return GestureDetector(
      onHorizontalDragStart: (details) {
        setState(() => _isDragging = true);
        widget.onSwipeStart?.call(details);
      },
      onHorizontalDragEnd: (details) {
        setState(() => _isDragging = false);
      },
      onHorizontalDragCancel: () {
        setState(() => _isDragging = false);
      },
      child: card,
    );
  }
}

