import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.windowSize,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    this.onViewProjectsPressed,
    this.onResumePressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback? onViewProjectsPressed;
  final VoidCallback? onResumePressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final radius = _isCompact ? AppRadius.lg : AppRadius.xl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: colors.outline.withValues(alpha: isDark ? 0.88 : 0.72),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.26 : 0.08),
              blurRadius: isDark ? 50 : 38,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(child: _HeroStaticBackground(isDark: isDark)),
            Positioned(
              top: -150,
              right: -110,
              child: _StaticGlow(
                size: _isCompact ? 300 : 430,
                color: AppColors.primary,
                opacity: isDark ? 0.13 : 0.10,
              ),
            ),
            Positioned(
              bottom: -170,
              left: -120,
              child: _StaticGlow(
                size: _isCompact ? 320 : 450,
                color: AppColors.secondary,
                opacity: isDark ? 0.11 : 0.08,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: switch (windowSize) {
                  AppWindowSize.compact => AppSpacing.md,
                  AppWindowSize.medium => AppSpacing.xl,
                  AppWindowSize.expanded => AppSpacing.xxxl,
                },
                vertical: switch (windowSize) {
                  AppWindowSize.compact => AppSpacing.lg,
                  AppWindowSize.medium => 52,
                  AppWindowSize.expanded => 72,
                },
              ),
              child: _isExpanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _HeroContent(
                            windowSize: windowSize,
                            onViewProjectsPressed: onViewProjectsPressed,
                            onResumePressed: onResumePressed,
                            onLinkedInPressed: onLinkedInPressed,
                            onGitHubPressed: onGitHubPressed,
                            onWhatsAppPressed: onWhatsAppPressed,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxxl),
                        const Expanded(flex: 4, child: _TechPortraitSystem()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _HeroContent(
                          windowSize: windowSize,
                          onViewProjectsPressed: onViewProjectsPressed,
                          onResumePressed: onResumePressed,
                          onLinkedInPressed: onLinkedInPressed,
                          onGitHubPressed: onGitHubPressed,
                          onWhatsAppPressed: onWhatsAppPressed,
                        ),
                        SizedBox(
                          height: _isCompact ? AppSpacing.xl : AppSpacing.xxxl,
                        ),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: _isCompact ? 330 : 470,
                            ),
                            child: const _TechPortraitSystem(),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.windowSize,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    required this.onViewProjectsPressed,
    required this.onResumePressed,
  });

  final AppWindowSize windowSize;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback? onViewProjectsPressed;
  final VoidCallback? onResumePressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final nameSize = switch (windowSize) {
      AppWindowSize.compact => 40.0,
      AppWindowSize.medium => 58.0,
      AppWindowSize.expanded => 70.0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const _SystemStatusBadge(),
            if (!_isCompact) const _MicroLabel(text: 'PORTFOLIO / 2026'),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'MD. ASIF',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: nameSize,
            height: 0.90,
            letterSpacing: _isCompact ? -1.4 : -2.3,
            fontWeight: FontWeight.w900,
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return AppColors.futuristicGradient.createShader(bounds);
          },
          child: Text(
            'AHMED',
            style: TextStyle(
              color: AppColors.white,
              fontSize: nameSize,
              height: 0.98,
              letterSpacing: _isCompact ? -1.4 : -2.3,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xxs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Mobile Application Developer',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.72),
                fontSize: _isCompact ? 15 : 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              'Flutter Developer',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontSize: _isCompact ? 15 : 19,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'I engineer mobile products that move from idea to production.',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: _isCompact ? 23 : 32,
              height: _isCompact ? 1.17 : 1.20,
              fontWeight: FontWeight.w700,
              letterSpacing: _isCompact ? -0.35 : -0.7,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 690),
          child: Text(
            '3+ years building production Flutter applications '
            'across responsive UI, application architecture, '
            'REST APIs, local persistence, maintenance, device '
            'testing, and Android/iOS release workflows.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.66),
              fontSize: _isCompact ? 14 : 16.5,
              height: _isCompact ? 1.52 : 1.62,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        _TechSignalGrid(compact: _isCompact),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _PrimaryAction(
              compact: _isCompact,
              icon: Icons.grid_view_rounded,
              label: 'Explore Projects',
              onPressed: onViewProjectsPressed,
            ),
            _SecondaryAction(
              compact: _isCompact,
              icon: Icons.description_outlined,
              label: 'View Resume',
              onPressed: onResumePressed,
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xxs,
          runSpacing: AppSpacing.xxs,
          children: [
            _SocialAction(
              compact: _isCompact,
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            _SocialAction(
              compact: _isCompact,
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            _SocialAction(
              compact: _isCompact,
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onPressed: onWhatsAppPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _SystemStatusBadge extends StatelessWidget {
  const _SystemStatusBadge();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 7,
              height: 7,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '3+ YEARS • PRODUCTION FLUTTER',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.76),
                fontSize: 10.5,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MicroLabel extends StatelessWidget {
  const _MicroLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      text,
      style: TextStyle(
        color: colors.onSurface.withValues(alpha: 0.38),
        fontSize: 10,
        letterSpacing: 1.6,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _TechSignalGrid extends StatelessWidget {
  const _TechSignalGrid({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.account_tree_outlined,
        value: 'Architecture',
        caption: 'Scalable Flutter structure',
      ),
      (
        icon: Icons.hub_outlined,
        value: 'API Systems',
        caption: 'REST & app integration',
      ),
      (
        icon: Icons.rocket_launch_outlined,
        value: 'Release',
        caption: 'Android & iOS delivery',
      ),
    ];

    if (compact) {
      return Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _TechSignalCard(
              icon: items[i].icon,
              value: items[i].value,
              caption: items[i].caption,
              compact: true,
            ),
            if (i != items.length - 1) const SizedBox(height: AppSpacing.xs),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: _TechSignalCard(
              icon: items[i].icon,
              value: items[i].value,
              caption: items[i].caption,
            ),
          ),
          if (i != items.length - 1) const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _TechSignalCard extends StatefulWidget {
  const _TechSignalCard({
    required this.icon,
    required this.value,
    required this.caption,
    this.compact = false,
  });

  final IconData icon;
  final String value;
  final String caption;
  final bool compact;

  @override
  State<_TechSignalCard> createState() => _TechSignalCardState();
}

class _TechSignalCardState extends State<_TechSignalCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: EdgeInsets.all(widget.compact ? AppSpacing.sm : AppSpacing.md),
        decoration: BoxDecoration(
          color: _hovered
              ? colors.primary.withValues(alpha: 0.08)
              : colors.surface.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.48)
                : colors.outline.withValues(alpha: 0.72),
          ),
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SizedBox(
                width: 38,
                height: 38,
                child: Icon(widget.icon, size: 18, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.value,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.48),
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryAction extends StatefulWidget {
  const _PrimaryAction({
    required this.compact,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final bool compact;
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  State<_PrimaryAction> createState() => _PrimaryActionState();
}

class _PrimaryActionState extends State<_PrimaryAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: enabled
          ? (_) {
              setState(() {
                _hovered = true;
              });
            }
          : null,
      onExit: enabled
          ? (_) {
              setState(() {
                _hovered = false;
              });
            }
          : null,
      child: AnimatedScale(
        scale: _hovered ? 1.025 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: enabled ? AppColors.futuristicGradient : null,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: _hovered ? 0.28 : 0.16,
                      ),
                      blurRadius: _hovered ? 26 : 16,
                    ),
                  ]
                : null,
          ),
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.transparent,
              foregroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.transparent,
              shadowColor: AppColors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? AppSpacing.md : AppSpacing.lg,
                vertical: widget.compact ? AppSpacing.sm : AppSpacing.md,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
              ),
            ),
            icon: Icon(widget.icon, size: widget.compact ? 17 : 19),
            label: Text(
              widget.label,
              style: TextStyle(
                fontSize: widget.compact ? 12.5 : 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryAction extends StatefulWidget {
  const _SecondaryAction({
    required this.compact,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final bool compact;
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  State<_SecondaryAction> createState() => _SecondaryActionState();
}

class _SecondaryActionState extends State<_SecondaryAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: enabled
          ? (_) {
              setState(() {
                _hovered = true;
              });
            }
          : null,
      onExit: enabled
          ? (_) {
              setState(() {
                _hovered = false;
              });
            }
          : null,
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: _hovered
                ? colors.primary.withValues(alpha: 0.08)
                : colors.surface.withValues(alpha: 0.52),
            foregroundColor: colors.onSurface,
            side: BorderSide(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.50)
                  : colors.outline,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.md : AppSpacing.lg,
              vertical: widget.compact ? AppSpacing.sm : AppSpacing.md,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
          ),
          icon: Icon(widget.icon, size: widget.compact ? 17 : 19),
          label: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.compact ? 12.5 : 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialAction extends StatefulWidget {
  const _SocialAction({
    required this.compact,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final bool compact;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  State<_SocialAction> createState() => _SocialActionState();
}

class _SocialActionState extends State<_SocialAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: TextButton.icon(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          foregroundColor: _hovered
              ? AppColors.primary
              : colors.onSurface.withValues(alpha: 0.62),
          backgroundColor: _hovered
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? AppSpacing.xs : AppSpacing.sm,
            vertical: widget.compact ? 6 : 9,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
          ),
        ),
        icon: Icon(widget.icon, size: widget.compact ? 15 : 17),
        label: Text(
          widget.label,
          style: TextStyle(
            fontSize: widget.compact ? 11.5 : 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TechPortraitSystem extends StatefulWidget {
  const _TechPortraitSystem();

  @override
  State<_TechPortraitSystem> createState() => _TechPortraitSystemState();
}

class _TechPortraitSystemState extends State<_TechPortraitSystem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hovered = false;

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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: AspectRatio(
        aspectRatio: 0.88,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _OrbitPainter(
                  animation: _controller,
                  primary: AppColors.primary,
                  secondary: AppColors.secondary,
                  accent: AppColors.accent,
                  isDark: isDark,
                ),
              ),
            ),
            Positioned(
              left: 42,
              right: 42,
              top: 52,
              bottom: 78,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                transform: Matrix4.diagonal3Values(
                  _hovered ? 1.012 : 1.0,
                  _hovered ? 1.012 : 1.0,
                  1,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.56)
                        : colors.outline,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(
                        alpha: isDark ? 0.30 : 0.10,
                      ),
                      blurRadius: 34,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl - 1),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/asif_ahmed_photo_optimized.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        semanticLabel: 'MD. Asif Ahmed',
                      ),
                      const _PortraitOverlay(),
                      const Positioned(
                        top: AppSpacing.md,
                        right: AppSpacing.md,
                        child: _FlutterBadge(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: _DeveloperConsole(isDark: isDark),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  _OrbitPainter({
    required this.animation,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.isDark,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color primary;
  final Color secondary;
  final Color accent;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.46);

    final phase = animation.value * math.pi * 2;

    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    final nodePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    void orbit({
      required double width,
      required double height,
      required Color color,
      required double speed,
      required double offset,
      required double radius,
    }) {
      orbitPaint.color = color.withValues(alpha: isDark ? 0.12 : 0.16);

      final rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );

      canvas.drawOval(rect, orbitPaint);

      final angle = phase * speed + offset;

      final point = Offset(
        center.dx + math.cos(angle) * (width / 2),
        center.dy + math.sin(angle) * (height / 2),
      );

      nodePaint.color = color.withValues(alpha: isDark ? 0.82 : 0.92);

      canvas.drawCircle(point, radius, nodePaint);
    }

    orbit(
      width: size.width * 0.86,
      height: size.height * 0.56,
      color: primary,
      speed: 0.74,
      offset: 0,
      radius: 3.5,
    );

    orbit(
      width: size.width * 0.70,
      height: size.height * 0.72,
      color: secondary,
      speed: -0.55,
      offset: math.pi * 0.46,
      radius: 3.2,
    );

    orbit(
      width: size.width * 0.96,
      height: size.height * 0.38,
      color: accent,
      speed: 0.42,
      offset: math.pi,
      radius: 2.8,
    );

    _paintBubbles(canvas, size, phase);
  }

  void _paintBubbles(Canvas canvas, Size size, double phase) {
    const seeds = [
      (0.09, 0.17, 2.4, 16.0, 10.0, 0.2),
      (0.82, 0.19, 3.0, 13.0, 14.0, 0.8),
      (0.12, 0.69, 2.5, 18.0, 12.0, 1.6),
      (0.88, 0.64, 2.8, 16.0, 14.0, 2.2),
      (0.23, 0.87, 2.2, 13.0, 10.0, 2.8),
      (0.74, 0.89, 2.6, 14.0, 11.0, 3.4),
    ];

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (var i = 0; i < seeds.length; i++) {
      final seed = seeds[i];

      final x = size.width * seed.$1 + math.sin(phase + seed.$6) * seed.$4;

      final y =
          size.height * seed.$2 + math.cos(phase * 0.78 + seed.$6) * seed.$5;

      final color = i.isEven ? primary : secondary;

      paint.color = color.withValues(alpha: isDark ? 0.38 : 0.48);

      canvas.drawCircle(Offset(x, y), seed.$3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) {
    return oldDelegate.primary != primary ||
        oldDelegate.secondary != secondary ||
        oldDelegate.accent != accent ||
        oldDelegate.isDark != isDark;
  }
}

class _PortraitOverlay extends StatelessWidget {
  const _PortraitOverlay();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const [Color(0x00030712), Color(0x16030712), Color(0xE8030712)]
              : const [Color(0x00FFFFFF), Color(0x08030712), Color(0xB3030712)],
          stops: const [0.48, 0.68, 1],
        ),
      ),
    );
  }
}

class _FlutterBadge extends StatelessWidget {
  const _FlutterBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.34)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flutter_dash_rounded, size: 14, color: AppColors.white),
            SizedBox(width: 6),
            Text(
              'FLUTTER',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 9.5,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeveloperConsole extends StatelessWidget {
  const _DeveloperConsole({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: isDark ? 0.93 : 0.96),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outline),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const _ConsoleDot(color: AppColors.error),
                const SizedBox(width: 5),
                const _ConsoleDot(color: AppColors.warning),
                const SizedBox(width: 5),
                const _ConsoleDot(color: AppColors.success),
                const Spacer(),
                Text(
                  'DEV / SYSTEM',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.38),
                    fontSize: 8.5,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.terminal_rounded,
                  color: AppColors.primary,
                  size: 17,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Flutter • Dart • REST • SQLite',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '> production-ready mobile systems',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.52),
                fontSize: 10.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsoleDot extends StatelessWidget {
  const _ConsoleDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 7,
      height: 7,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _HeroStaticBackground extends StatelessWidget {
  const _HeroStaticBackground({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StaticTechGridPainter(isDark: isDark),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF0D172A),
                    Color(0xFF070D1A),
                    Color(0xFF030712),
                  ]
                : const [
                    Color(0xFFFFFFFF),
                    Color(0xFFF7F9FD),
                    Color(0xFFEDF1F8),
                  ],
          ),
        ),
      ),
    );
  }
}

class _StaticTechGridPainter extends CustomPainter {
  const _StaticTechGridPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: isDark ? 0.035 : 0.055)
      ..strokeWidth = 1;

    const spacing = 52.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StaticTechGridPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _StaticGlow extends StatelessWidget {
  const _StaticGlow({
    required this.size,
    required this.color,
    required this.opacity,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: opacity),
                color.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
