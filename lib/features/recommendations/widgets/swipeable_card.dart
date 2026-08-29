import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/theme/motion_tokens.dart';
import '../../../data/models/recommendation.dart';
import '../../../l10n/app_localizations.dart';

enum SwipeDirection { left, right }

class RecommendationSwipeCard extends StatefulWidget {
  final Recommendation recommendation;
  final Widget child; // The actual ActionCard
  final ValueChanged<SwipeDirection> onSwiped;
  final VoidCallback onNonGestureTapRight;
  final VoidCallback onNonGestureTapLeft;
  
  const RecommendationSwipeCard({
    super.key,
    required this.recommendation,
    required this.child,
    required this.onSwiped,
    required this.onNonGestureTapRight,
    required this.onNonGestureTapLeft,
  });

  @override
  State<RecommendationSwipeCard> createState() => _RecommendationSwipeCardState();
}

class _RecommendationSwipeCardState extends State<RecommendationSwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  bool _hapticFired = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      setState(() {
        _dragOffset = Offset(
          _dragOffset.dx * (1 - _controller.value),
          _dragOffset.dy * (1 - _controller.value),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final commitThreshold = screenWidth * 0.35;
    
    if (_dragOffset.dx.abs() > commitThreshold && !_hapticFired) {
      HapticFeedback.selectionClick();
      _hapticFired = true;
    } else if (_dragOffset.dx.abs() <= commitThreshold) {
      _hapticFired = false;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final commitThreshold = screenWidth * 0.35;
    final velocityX = details.velocity.pixelsPerSecond.dx;
    const velocityThreshold = 800.0;

    bool committed = false;
    SwipeDirection? direction;

    if (_dragOffset.dx > commitThreshold || velocityX > velocityThreshold) {
      committed = true;
      direction = SwipeDirection.right;
    } else if (_dragOffset.dx < -commitThreshold || velocityX < -velocityThreshold) {
      committed = true;
      direction = SwipeDirection.left;
    }

    if (committed && direction != null) {
      HapticFeedback.mediumImpact();
      final offscreenX = direction == SwipeDirection.right ? screenWidth * 1.5 : -screenWidth * 1.5;
      _animateTo(Offset(offscreenX, _dragOffset.dy), duration: MotionTokens.durationStandard, curve: MotionTokens.curveExit).then((_) {
        widget.onSwiped(direction!);
      });
    } else {
      // Spring back
      _animateTo(Offset.zero, duration: const Duration(milliseconds: 400), curve: Curves.elasticOut).ignore();
    }
  }
  
  Future<void> _animateTo(Offset target, {required Duration duration, required Curve curve}) async {
    final startOffset = _dragOffset;
    _controller.duration = duration;
    
    final animation = CurvedAnimation(parent: _controller, curve: curve);
    
    void listener() {
      setState(() {
        _dragOffset = Offset.lerp(startOffset, target, animation.value)!;
      });
    }
    
    animation.addListener(listener);
    await _controller.forward(from: 0);
    animation.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate rotation: (dragX / screenWidth) * 15°
    final rotationAngle = (_dragOffset.dx / screenWidth) * (15 * pi / 180);
    
    // Overlays
    final rightIntentRatio = (_dragOffset.dx / (screenWidth * 0.35)).clamp(0.0, 1.0);
    final leftIntentRatio = (-_dragOffset.dx / (screenWidth * 0.35)).clamp(0.0, 1.0);

    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Transform.translate(
          offset: _dragOffset,
          child: Transform.rotate(
            angle: rotationAngle,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Stack(
                children: [
                  widget.child,
                  // Right Overlay (Done)
                  if (rightIntentRatio > 0)
                    Positioned.fill(
                      child: Opacity(
                        opacity: rightIntentRatio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: HarvestColors.statusGood.withValues(alpha: 0.8),
                            borderRadius: HarvestRadius.md,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle_outline, color: Colors.white, size: 64),
                                const SizedBox(height: 8),
                                Text(l10n.recommendations_done, style: context.textTheme.headlineMedium?.copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Left Overlay (Remind Later)
                  if (leftIntentRatio > 0)
                    Positioned.fill(
                      child: Opacity(
                        opacity: leftIntentRatio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.8),
                            borderRadius: HarvestRadius.md,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.schedule, color: Colors.white, size: 64),
                                const SizedBox(height: 8),
                                Text(l10n.recommendations_remindLater, style: context.textTheme.headlineMedium?.copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // Fallback Buttons (Bottom)
        if (!_isDragging && _dragOffset == Offset.zero)
          Positioned(
            bottom: -60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.small(
                  heroTag: 'remind_later',
                  onPressed: widget.onNonGestureTapLeft,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.schedule),
                ),
                FloatingActionButton.small(
                  heroTag: 'done',
                  onPressed: widget.onNonGestureTapRight,
                  backgroundColor: HarvestColors.statusGood,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
