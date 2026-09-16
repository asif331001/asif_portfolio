import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AnimatedPortfolioBackground extends StatefulWidget {
  const AnimatedPortfolioBackground({
    required this.compact,
    this.overlay = false,
    super.key,
  });

  final bool compact;
  final bool overlay;

  @override
  State<AnimatedPortfolioBackground> createState() =>
      _AnimatedPortfolioBackgroundState();
}

class _AnimatedPortfolioBackgroundState
    extends State<AnimatedPortfolioBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.overlay ? 34 : 28),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (disableAnimations) {
      _controller.stop();
      _controller.value = 0;
      return;
    }

    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _FloatingBackgroundPainter(
            animation: _controller,
            compact: widget.compact,
            overlay: widget.overlay,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _FloatingBackgroundPainter extends CustomPainter {
  _FloatingBackgroundPainter({
    required this.animation,
    required this.compact,
    required this.overlay,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final bool compact;
  final bool overlay;

  static const List<_ParticleSeed> _particles = [
    _ParticleSeed(0.06, 0.08, 2.8, 24, 18, 0.08),
    _ParticleSeed(0.16, 0.24, 3.5, 31, 22, 0.26),
    _ParticleSeed(0.28, 0.12, 2.4, 24, 28, 0.49),
    _ParticleSeed(0.39, 0.34, 3.2, 28, 19, 0.67),
    _ParticleSeed(0.52, 0.17, 2.5, 25, 24, 0.86),
    _ParticleSeed(0.64, 0.30, 3.8, 34, 23, 0.13),
    _ParticleSeed(0.77, 0.10, 2.4, 23, 27, 0.38),
    _ParticleSeed(0.90, 0.37, 3.3, 30, 18, 0.61),
    _ParticleSeed(0.11, 0.59, 3.0, 27, 22, 0.79),
    _ParticleSeed(0.31, 0.73, 3.6, 32, 20, 0.20),
    _ParticleSeed(0.56, 0.64, 2.5, 24, 26, 0.56),
    _ParticleSeed(0.73, 0.82, 3.3, 30, 21, 0.92),
    _ParticleSeed(0.91, 0.68, 2.7, 24, 18, 0.34),
    _ParticleSeed(0.47, 0.88, 3.5, 28, 24, 0.71),
    _ParticleSeed(0.22, 0.48, 2.3, 22, 17, 0.42),
    _ParticleSeed(0.84, 0.53, 2.9, 26, 20, 0.74),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final progress = animation.value;
    final phase = progress * math.pi * 2;

    if (!overlay) {
      _paintAmbientRings(canvas, size, phase);
    }

    final particleCount = compact
        ? overlay
              ? 5
              : 9
        : overlay
        ? 8
        : _particles.length;

    final particlePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = overlay ? 0.8 : 1
      ..isAntiAlias = true;

    for (var index = 0; index < particleCount; index++) {
      final particle =
          _particles[(index + (overlay ? 3 : 0)) % _particles.length];

      final angle = phase + (particle.phaseOffset * math.pi * 2);

      final x =
          (particle.x * size.width) +
          math.sin(angle) * particle.horizontalTravel;

      final y =
          (particle.y * size.height) +
          math.cos(angle * 0.76) * particle.verticalTravel;

      final usePrimary = index.isEven;

      final baseColor = usePrimary ? AppColors.primary : AppColors.secondary;

      final pulse = 0.78 + (math.sin(angle * 1.25) * 0.18);

      final particleAlpha = overlay ? 0.10 : 0.28;
      final haloAlpha = overlay ? 0.035 : 0.09;

      particlePaint.color = baseColor.withValues(alpha: particleAlpha * pulse);

      haloPaint.color = baseColor.withValues(alpha: haloAlpha * pulse);

      final center = Offset(x, y);

      canvas.drawCircle(
        center,
        overlay ? particle.radius * 0.78 : particle.radius,
        particlePaint,
      );

      if (index % 2 == 0) {
        canvas.drawCircle(
          center,
          particle.radius + (overlay ? 5 : 8),
          haloPaint,
        );
      }
    }

    if (overlay && !compact) {
      _paintDriftingAccents(canvas, size, phase);
    }
  }

  void _paintAmbientRings(Canvas canvas, Size size, double phase) {
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..isAntiAlias = true;

    final firstCenter = Offset(
      size.width * 0.15 + math.sin(phase * 0.72) * 30,
      size.height * 0.24 + math.cos(phase * 0.58) * 24,
    );

    ringPaint.color = AppColors.primary.withValues(alpha: 0.075);

    canvas.drawCircle(firstCenter, compact ? 95 : 145, ringPaint);

    final secondCenter = Offset(
      size.width * 0.84 + math.cos(phase * 0.63) * 32,
      size.height * 0.72 + math.sin(phase * 0.51) * 24,
    );

    ringPaint.color = AppColors.secondary.withValues(alpha: 0.08);

    canvas.drawCircle(secondCenter, compact ? 118 : 180, ringPaint);

    if (!compact) {
      final thirdCenter = Offset(
        size.width * 0.53 + math.sin(phase * 0.46) * 26,
        size.height * 0.48 + math.cos(phase * 0.41) * 20,
      );

      ringPaint.color = AppColors.accent.withValues(alpha: 0.05);

      canvas.drawCircle(thirdCenter, 230, ringPaint);
    }
  }

  void _paintDriftingAccents(Canvas canvas, Size size, double phase) {
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    final firstShift = math.sin(phase * 0.52) * 34;

    linePaint.color = AppColors.primary.withValues(alpha: 0.055);

    canvas.drawLine(
      Offset(size.width * 0.08 + firstShift, size.height * 0.20),
      Offset(size.width * 0.19 + firstShift, size.height * 0.13),
      linePaint,
    );

    final secondShift = math.cos(phase * 0.47) * 38;

    linePaint.color = AppColors.secondary.withValues(alpha: 0.06);

    canvas.drawLine(
      Offset(size.width * 0.78 + secondShift, size.height * 0.67),
      Offset(size.width * 0.91 + secondShift, size.height * 0.59),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FloatingBackgroundPainter oldDelegate) {
    return oldDelegate.compact != compact || oldDelegate.overlay != overlay;
  }
}

class _ParticleSeed {
  const _ParticleSeed(
    this.x,
    this.y,
    this.radius,
    this.horizontalTravel,
    this.verticalTravel,
    this.phaseOffset,
  );

  final double x;
  final double y;
  final double radius;
  final double horizontalTravel;
  final double verticalTravel;
  final double phaseOffset;
}
