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
      duration: Duration(seconds: widget.overlay ? 32 : 26),
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
    _ParticleSeed(0.07, 0.10, 2.8, 20, 16, 0.08),
    _ParticleSeed(0.17, 0.26, 3.4, 28, 20, 0.24),
    _ParticleSeed(0.29, 0.13, 2.3, 22, 24, 0.48),
    _ParticleSeed(0.40, 0.35, 3.0, 26, 18, 0.66),
    _ParticleSeed(0.53, 0.18, 2.4, 22, 22, 0.84),
    _ParticleSeed(0.64, 0.31, 3.6, 30, 21, 0.12),
    _ParticleSeed(0.76, 0.11, 2.3, 21, 24, 0.36),
    _ParticleSeed(0.90, 0.38, 3.1, 27, 17, 0.60),
    _ParticleSeed(0.12, 0.60, 2.9, 24, 20, 0.78),
    _ParticleSeed(0.31, 0.74, 3.4, 29, 18, 0.20),
    _ParticleSeed(0.56, 0.65, 2.4, 22, 24, 0.55),
    _ParticleSeed(0.73, 0.82, 3.1, 27, 19, 0.91),
    _ParticleSeed(0.91, 0.69, 2.6, 22, 17, 0.33),
    _ParticleSeed(0.47, 0.88, 3.3, 26, 22, 0.70),
    _ParticleSeed(0.22, 0.49, 2.2, 20, 16, 0.42),
    _ParticleSeed(0.84, 0.54, 2.8, 24, 18, 0.73),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final phase = animation.value * math.pi * 2;

    if (!overlay) {
      _paintStaticGlows(canvas, size);
    }

    _paintOrbitSystems(canvas, size, phase);
    _paintFloatingBubbles(canvas, size, phase);
  }

  void _paintStaticGlows(Canvas canvas, Size size) {
    _paintStaticGlow(
      canvas: canvas,
      center: Offset(size.width * 0.14, size.height * 0.18),
      radius: compact ? 230 : 360,
      color: AppColors.primary,
      alpha: compact ? 0.10 : 0.13,
    );

    _paintStaticGlow(
      canvas: canvas,
      center: Offset(size.width * 0.86, size.height * 0.68),
      radius: compact ? 250 : 410,
      color: AppColors.secondary,
      alpha: compact ? 0.10 : 0.14,
    );

    if (!compact) {
      _paintStaticGlow(
        canvas: canvas,
        center: Offset(size.width * 0.52, size.height * 0.44),
        radius: 300,
        color: AppColors.accent,
        alpha: 0.055,
      );
    }
  }

  void _paintStaticGlow({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required Color color,
    required double alpha,
  }) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: alpha),
          color.withValues(alpha: alpha * 0.42),
          color.withValues(alpha: 0),
        ],
        stops: const [0, 0.48, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  void _paintOrbitSystems(Canvas canvas, Size size, double phase) {
    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = overlay ? 0.7 : 0.9
      ..isAntiAlias = true;

    final nodePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    void drawOrbit({
      required Offset center,
      required double radiusX,
      required double radiusY,
      required Color color,
      required double speed,
      required double offset,
      required double nodeRadius,
    }) {
      orbitPaint.color = color.withValues(alpha: overlay ? 0.035 : 0.075);

      final rect = Rect.fromCenter(
        center: center,
        width: radiusX * 2,
        height: radiusY * 2,
      );

      canvas.drawOval(rect, orbitPaint);

      final angle = (phase * speed) + offset;

      final nodeCenter = Offset(
        center.dx + math.cos(angle) * radiusX,
        center.dy + math.sin(angle) * radiusY,
      );

      nodePaint.color = color.withValues(alpha: overlay ? 0.16 : 0.48);

      haloPaint.color = color.withValues(alpha: overlay ? 0.05 : 0.16);

      canvas.drawCircle(nodeCenter, nodeRadius, nodePaint);
      canvas.drawCircle(nodeCenter, nodeRadius + 5, haloPaint);

      final oppositeAngle = angle + math.pi;

      final oppositeNode = Offset(
        center.dx + math.cos(oppositeAngle) * radiusX,
        center.dy + math.sin(oppositeAngle) * radiusY,
      );

      nodePaint.color = color.withValues(alpha: overlay ? 0.09 : 0.26);

      canvas.drawCircle(oppositeNode, nodeRadius * 0.65, nodePaint);
    }

    drawOrbit(
      center: Offset(size.width * (compact ? 0.18 : 0.16), size.height * 0.26),
      radiusX: compact ? 54 : 92,
      radiusY: compact ? 34 : 58,
      color: AppColors.primary,
      speed: 0.72,
      offset: 0,
      nodeRadius: compact ? 2.4 : 3.1,
    );

    drawOrbit(
      center: Offset(size.width * (compact ? 0.79 : 0.84), size.height * 0.72),
      radiusX: compact ? 68 : 118,
      radiusY: compact ? 42 : 72,
      color: AppColors.secondary,
      speed: -0.56,
      offset: math.pi * 0.4,
      nodeRadius: compact ? 2.6 : 3.3,
    );

    if (!compact && !overlay) {
      drawOrbit(
        center: Offset(size.width * 0.55, size.height * 0.47),
        radiusX: 152,
        radiusY: 92,
        color: AppColors.accent,
        speed: 0.38,
        offset: math.pi * 0.85,
        nodeRadius: 2.7,
      );
    }
  }

  void _paintFloatingBubbles(Canvas canvas, Size size, double phase) {
    final particleCount = compact
        ? overlay
              ? 5
              : 9
        : overlay
        ? 8
        : _particles.length;

    final bubblePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = overlay ? 0.7 : 1
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
          math.cos(angle * 0.74) * particle.verticalTravel;

      final color = index.isEven ? AppColors.primary : AppColors.secondary;

      final pulse = 0.84 + (math.sin(angle * 1.1) * 0.16);

      bubblePaint.color = color.withValues(
        alpha: (overlay ? 0.09 : 0.27) * pulse,
      );

      haloPaint.color = color.withValues(
        alpha: (overlay ? 0.025 : 0.075) * pulse,
      );

      final center = Offset(x, y);

      final radius = overlay ? particle.radius * 0.72 : particle.radius;

      canvas.drawCircle(center, radius, bubblePaint);

      if (index.isEven) {
        canvas.drawCircle(center, radius + (overlay ? 4 : 7), haloPaint);
      }
    }
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
