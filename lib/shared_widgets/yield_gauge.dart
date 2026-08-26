import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_tokens.dart';
import '../../core/theme/motion_tokens.dart';
import 'status_badge.dart';

class YieldGauge extends StatefulWidget {
  final double value; // 0.0 to 1.0
  final StatusColor status;
  final String statusLabel;

  const YieldGauge({
    super.key,
    required this.value,
    required this.status,
    required this.statusLabel,
  });

  @override
  State<YieldGauge> createState() => _YieldGaugeState();
}

class _YieldGaugeState extends State<YieldGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0.0;

  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      _controller.duration = MotionTokens.durationFor(context, MotionTokens.durationHero);
      _setupAnimation(0.0, widget.value);
      _controller.forward();
      _hasInitialized = true;
    }
  }

  @override
  void didUpdateWidget(YieldGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _controller.duration = MotionTokens.durationFor(context, MotionTokens.durationEmphasis);
      _setupAnimation(_oldValue, widget.value);
      _controller.forward(from: 0.0);
    }
  }

  void _setupAnimation(double begin, double end) {
    _animation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: MotionTokens.curveEmphasis,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive scaling based on a 360dp width reference
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 360.0;
    
    // Scale proportionally, but never go below 160dp
    final diameter = math.max(160.0, 200.0 * scaleFactor);

    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Track
          CustomPaint(
            size: Size(diameter, diameter),
            painter: _GaugePainter(
              value: 1.0,
              color: context.theme.canvasColor, // 'surface' color
              strokeWidth: 12.0,
            ),
          ),
          
          // Foreground Fill
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final currentValue = disableAnimations ? widget.value : _animation.value;
              final displayValue = (currentValue * 100).round();
              
              // On very small screens (< 180dp diameter), fallback to displaySmall
              final textStyle = diameter < 180 
                  ? context.textTheme.displayMedium 
                  : context.textTheme.displayLarge;

              return Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(diameter, diameter),
                    painter: _GaugePainter(
                      value: currentValue,
                      color: HarvestColors.resolveStatusColor(widget.status),
                      strokeWidth: 12.0,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$displayValue%',
                        style: textStyle,
                      ),
                      const SizedBox(height: 4), // small gap
                      StatusBadge(
                        status: widget.status,
                        label: widget.statusLabel,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;

  _GaugePainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Start at 150 degrees, which is (150 * pi) / 180 radians
    const startAngle = 150 * (math.pi / 180);
    // Sweep is 240 degrees total
    final sweepAngle = (240 * (math.pi / 180)) * value;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false, // useCenter
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
