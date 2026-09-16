import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AnimatedSectionBackground extends StatefulWidget {
  const AnimatedSectionBackground({
    required this.compact,
    this.intensity = 1,
    super.key,
  });

  final bool compact;
  final double intensity;

  @override
  State<AnimatedSectionBackground> createState() =>
      _AnimatedSectionBackgroundState();
}

class _AnimatedSectionBackgroundState extends State<AnimatedSectionBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
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
          painter: _AnimatedSectionPainter(
            animation: _controller,
            compact: widget.compact,
            intensity: widget.intensity,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _AnimatedSectionPainter extends CustomPainter {
  _AnimatedSectionPainter({
    required this.animation,
    required this.compact,
    required this.intensity,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final bool compact;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final phase = animation.value * math.pi * 2;

    _paintStaticGlows(canvas, size);
    _paintOrbitNodes(canvas, size, phase);
    _paintFloatingBubbles(canvas, size, phase);
  }

  void _paintStaticGlows(Canvas canvas, Size size) {
    _paintGlow(
      canvas: canvas,
      center: Offset(size.width * 0.80, size.height * 0.20),
      radius: compact ? 190 : 300,
      color: AppColors.secondary,
      alpha: 0.19 * intensity,
    );

    _paintGlow(
      canvas: canvas,
      center: Offset(size.width * 0.12, size.height * 0.80),
      radius: compact ? 180 : 275,
      color: AppColors.primary,
      alpha: 0.16 * intensity,
    );

    if (!compact) {
      _paintGlow(
        canvas: canvas,
        center: Offset(size.width * 0.50, size.height * 0.48),
        radius: 220,
        color: AppColors.accent,
        alpha: 0.065 * intensity,
      );
    }
  }

  void _paintGlow({
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

  void _paintOrbitNodes(Canvas canvas, Size size, double phase) {
    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
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
    }) {
      orbitPaint.color = color.withValues(alpha: 0.075 * intensity);

      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radiusX * 2,
          height: radiusY * 2,
        ),
        orbitPaint,
      );

      final angle = (phase * speed) + offset;

      final point = Offset(
        center.dx + math.cos(angle) * radiusX,
        center.dy + math.sin(angle) * radiusY,
      );

      nodePaint.color = color.withValues(alpha: 0.48 * intensity);

      haloPaint.color = color.withValues(alpha: 0.14 * intensity);

      canvas.drawCircle(point, compact ? 2.5 : 3.1, nodePaint);

      canvas.drawCircle(point, compact ? 7 : 8, haloPaint);
    }

    drawOrbit(
      center: Offset(size.width * 0.23, size.height * 0.27),
      radiusX: compact ? 46 : 72,
      radiusY: compact ? 29 : 43,
      color: AppColors.primary,
      speed: 0.82,
      offset: 0,
    );

    drawOrbit(
      center: Offset(size.width * 0.78, size.height * 0.70),
      radiusX: compact ? 58 : 92,
      radiusY: compact ? 35 : 55,
      color: AppColors.secondary,
      speed: -0.64,
      offset: math.pi * 0.55,
    );

    if (!compact) {
      drawOrbit(
        center: Offset(size.width * 0.55, size.height * 0.35),
        radiusX: 110,
        radiusY: 61,
        color: AppColors.accent,
        speed: 0.46,
        offset: math.pi,
      );
    }
  }

  void _paintFloatingBubbles(Canvas canvas, Size size, double phase) {
    final count = compact ? 5 : 8;

    final bubblePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    for (var index = 0; index < count; index++) {
      final fraction = (index + 1) / (count + 1);

      final angle = phase + (index * 0.82);

      final x = size.width * fraction + math.sin(angle) * (compact ? 26 : 38);

      final y =
          size.height * (0.16 + ((index % 4) * 0.22)) +
          math.cos((phase * 0.72) + index) * (compact ? 22 : 31);

      final color = index.isEven ? AppColors.primary : AppColors.secondary;

      final pulse = 0.84 + math.sin((phase * 1.05) + index) * 0.16;

      bubblePaint.color = color.withValues(alpha: 0.29 * intensity * pulse);

      haloPaint.color = color.withValues(alpha: 0.09 * intensity * pulse);

      final center = Offset(x, y);
      final radius = index % 3 == 0 ? 3.4 : 2.5;

      canvas.drawCircle(center, radius, bubblePaint);

      if (index.isEven) {
        canvas.drawCircle(center, radius + 5.5, haloPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AnimatedSectionPainter oldDelegate) {
    return oldDelegate.compact != compact || oldDelegate.intensity != intensity;
  }
}
