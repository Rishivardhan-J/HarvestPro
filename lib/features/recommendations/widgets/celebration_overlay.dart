import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../l10n/app_localizations.dart';

class CelebrationOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const CelebrationOverlay({super.key, required this.onComplete});

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        SemanticsService.sendAnnouncement(View.of(context), l10n.recommendations_done, Directionality.of(context));
      }
    });
    
    // Initialize particles
    for (int i = 0; i < 20; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * 2 - 1, // -1 to 1
        y: _random.nextDouble() * 2 - 1,
        speed: _random.nextDouble() * 2 + 1,
        angle: _random.nextDouble() * 2 * pi,
        color: [HarvestColors.statusGood, HarvestColors.accent, Colors.orange][_random.nextInt(3)],
        size: _random.nextDouble() * 6 + 4,
      ));
    }

    _controller.addListener(() {
      setState(() {
        for (final p in _particles) {
          p.update(_controller.value);
        }
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect reduce motion
    if (MediaQuery.disableAnimationsOf(context)) {
      return const Center(
        child: Icon(Icons.check_circle, size: 64, color: HarvestColors.statusGood),
      );
    }

    return CustomPaint(
      painter: _ParticlePainter(particles: _particles, progress: _controller.value),
      child: const SizedBox.expand(),
    );
  }
}

class _Particle {
  final double startX, startY;
  double currentX = 0;
  double currentY = 0;
  final double speed;
  final double angle;
  final Color color;
  final double size;

  _Particle({
    required double x,
    required double y,
    required this.speed,
    required this.angle,
    required this.color,
    required this.size,
  })  : startX = x,
        startY = y;

  void update(double progress) {
    // move outwards
    final distance = speed * progress * 50;
    currentX = startX * 50 + cos(angle) * distance;
    currentY = startY * 50 + sin(angle) * distance;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);
    
    for (final p in particles) {
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(center + Offset(p.currentX, p.currentY), p.size * (1 - progress * 0.5), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
