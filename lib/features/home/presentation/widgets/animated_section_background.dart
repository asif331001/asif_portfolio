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
      duration: const Duration(seconds: 14),
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

    _paintGlow(
      canvas: canvas,
      center: Offset(
        size.width * 0.78 + math.sin(phase * 0.72) * (compact ? 70 : 120),
        size.height * 0.20 + math.cos(phase * 0.58) * (compact ? 52 : 82),
      ),
      radius: compact ? 200 : 310,
      color: AppColors.secondary,
      alpha: 0.24 * intensity,
    );

    _paintGlow(
      canvas: canvas,
      center: Offset(
        size.width * 0.14 + math.cos(phase * 0.53) * (compact ? 65 : 105),
        size.height * 0.79 + math.sin(phase * 0.64) * (compact ? 54 : 78),
      ),
      radius: compact ? 190 : 285,
      color: AppColors.primary,
      alpha: 0.20 * intensity,
    );

    if (!compact) {
      _paintGlow(
        canvas: canvas,
        center: Offset(
          size.width * 0.48 + math.sin(phase * 0.39) * 72,
          size.height * 0.47 + math.cos(phase * 0.44) * 52,
        ),
        radius: 215,
        color: AppColors.accent,
        alpha: 0.10 * intensity,
      );
    }

    _paintParticles(canvas, size, phase);

    _paintAccentLines(canvas, size, phase);
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
          color.withValues(alpha: alpha * 0.46),
          color.withValues(alpha: 0),
        ],
        stops: const [0, 0.46, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  void _paintParticles(Canvas canvas, Size size, double phase) {
    final count = compact ? 5 : 7;

    final particlePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    for (var index = 0; index < count; index++) {
      final fraction = (index + 1) / (count + 1);

      final x =
          size.width * fraction +
          math.sin(phase + index * 0.85) * (compact ? 34 : 48);

      final y =
          size.height * (0.17 + ((index % 4) * 0.21)) +
          math.cos((phase * 0.74) + index) * (compact ? 28 : 38);

      final color = index.isEven ? AppColors.primary : AppColors.secondary;

      final pulse = 0.82 + math.sin(phase * 1.2 + index) * 0.18;

      particlePaint.color = color.withValues(alpha: 0.34 * intensity * pulse);

      haloPaint.color = color.withValues(alpha: 0.13 * intensity * pulse);

      final center = Offset(x, y);

      final radius = index % 3 == 0 ? 3.8 : 2.7;

      canvas.drawCircle(center, radius, particlePaint);

      if (index.isEven) {
        canvas.drawCircle(center, radius + 6, haloPaint);
      }
    }
  }

  void _paintAccentLines(Canvas canvas, Size size, double phase) {
    if (compact) {
      return;
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..isAntiAlias = true;

    final shift = math.sin(phase * 0.48) * 70;

    paint.color = AppColors.primary.withValues(alpha: 0.15 * intensity);

    canvas.drawLine(
      Offset(size.width * 0.05 + shift, size.height * 0.20),
      Offset(size.width * 0.23 + shift, size.height * 0.07),
      paint,
    );

    paint.color = AppColors.secondary.withValues(alpha: 0.16 * intensity);

    canvas.drawLine(
      Offset(size.width * 0.70 - shift, size.height * 0.88),
      Offset(size.width * 0.94 - shift, size.height * 0.68),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimatedSectionPainter oldDelegate) {
    return oldDelegate.compact != compact || oldDelegate.intensity != intensity;
  }
}
