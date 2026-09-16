import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class HeroSection extends StatefulWidget {
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

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset? _hoverPosition;
  Offset _portraitParallax = Offset.zero;

  bool get _isExpanded => widget.windowSize == AppWindowSize.expanded;

  bool get _isCompact => widget.windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final content = _isExpanded
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: _HeroContent(
                  windowSize: widget.windowSize,
                  onViewProjectsPressed: widget.onViewProjectsPressed,
                  onResumePressed: widget.onResumePressed,
                  onLinkedInPressed: widget.onLinkedInPressed,
                  onGitHubPressed: widget.onGitHubPressed,
                  onWhatsAppPressed: widget.onWhatsAppPressed,
                ),
              ),
              const SizedBox(width: AppSpacing.xxxl),
              Expanded(
                flex: 4,
                child: _HeroMotionPortrait(parallax: _portraitParallax),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroContent(
                windowSize: widget.windowSize,
                onViewProjectsPressed: widget.onViewProjectsPressed,
                onResumePressed: widget.onResumePressed,
                onLinkedInPressed: widget.onLinkedInPressed,
                onGitHubPressed: widget.onGitHubPressed,
                onWhatsAppPressed: widget.onWhatsAppPressed,
              ),
              SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxxl),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: _isCompact ? 265 : 430),
                  child: _HeroMotionPortrait(compact: _isCompact),
                ),
              ),
            ],
          );

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: _isExpanded
              ? (event) {
                  final width = constraints.maxWidth;

                  if (!width.isFinite || width <= 0) {
                    return;
                  }

                  final normalizedX =
                      ((event.localPosition.dx / width) - 0.5) * 2;

                  final normalizedY =
                      ((event.localPosition.dy / 720) - 0.5) * 2;

                  setState(() {
                    _hoverPosition = event.localPosition;
                    _portraitParallax = Offset(
                      normalizedX.clamp(-1.0, 1.0) * 9,
                      normalizedY.clamp(-1.0, 1.0) * 6,
                    );
                  });
                }
              : null,
          onExit: _isExpanded
              ? (_) {
                  setState(() {
                    _hoverPosition = null;
                    _portraitParallax = Offset.zero;
                  });
                }
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              _isCompact ? AppRadius.lg : AppRadius.xl,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  _isCompact ? AppRadius.lg : AppRadius.xl,
                ),
                border: Border.all(color: AppColors.borderStrong),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.26),
                    blurRadius: 48,
                    offset: const Offset(0, 22),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Positioned.fill(child: _HeroBackground()),
                  if (_hoverPosition != null)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutCubic,
                      left: _hoverPosition!.dx - 210,
                      top: _hoverPosition!.dy - 210,
                      child: const _CursorGlow(),
                    ),
                  Positioned(
                    top: -150 + (_portraitParallax.dy * 0.65),
                    right: -100 - (_portraitParallax.dx * 0.80),
                    child: const _GlowOrb(
                      size: 390,
                      color: AppColors.primary,
                      opacity: 0.13,
                    ),
                  ),
                  Positioned(
                    bottom: -180 - (_portraitParallax.dy * 0.45),
                    left: -100 - (_portraitParallax.dx * 0.55),
                    child: const _GlowOrb(
                      size: 360,
                      color: AppColors.secondary,
                      opacity: 0.11,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: _isCompact ? 24 : 42,
                    child: const _TopAccent(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: switch (widget.windowSize) {
                        AppWindowSize.compact => AppSpacing.md,
                        AppWindowSize.medium => AppSpacing.xl,
                        AppWindowSize.expanded => AppSpacing.xxxl,
                      },
                      vertical: switch (widget.windowSize) {
                        AppWindowSize.compact => AppSpacing.lg,
                        AppWindowSize.medium => 56,
                        AppWindowSize.expanded => 82,
                      },
                    ),
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
    final nameSize = switch (windowSize) {
      AppWindowSize.compact => 38.0,
      AppWindowSize.medium => 58.0,
      AppWindowSize.expanded => 72.0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AvailabilityBadge(compact: _isCompact),
            if (!_isCompact) ...[
              const SizedBox(width: AppSpacing.sm),
              const _PortfolioIndex(),
            ],
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'MD. ASIF',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: nameSize,
            height: 0.90,
            letterSpacing: _isCompact ? -1.2 : -2.2,
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
              letterSpacing: _isCompact ? -1.2 : -2.2,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xxs,
          children: [
            Text(
              'Mobile Application Developer',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondary,
                fontSize: _isCompact ? 15 : 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            const _RoleSeparator(),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return AppColors.brandGradient.createShader(bounds);
              },
              child: Text(
                'Flutter Developer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontSize: _isCompact ? 15 : 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'I turn product ideas into polished, '
            'production-ready Flutter experiences.',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: _isCompact ? 22 : 31,
              height: _isCompact ? 1.18 : 1.22,
              fontWeight: FontWeight.w700,
              letterSpacing: _isCompact ? -0.3 : -0.65,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            _isCompact
                ? '3+ years building and shipping production '
                      'Flutter apps across architecture, APIs, '
                      'local data, maintenance, testing, and '
                      'Android/iOS releases.'
                : '3+ years of professional experience owning '
                      'Flutter architecture, responsive UI, '
                      'REST API integration, local persistence, '
                      'maintenance, device testing, and '
                      'Android/iOS production releases.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: _isCompact ? 1.5 : 1.65,
              fontSize: _isCompact ? 14 : 16.5,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.phone_android_rounded,
              label: 'Android & iOS',
            ),
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.rocket_launch_rounded,
              label: 'Production Releases',
            ),
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.account_tree_outlined,
              label: 'Architecture',
            ),
          ],
        ),
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
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xxs,
          runSpacing: AppSpacing.xxs,
          children: [
            _SocialButton(
              compact: _isCompact,
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            _SocialButton(
              compact: _isCompact,
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            _SocialButton(
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

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: compact ? 7 : AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.50),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const SizedBox(width: 7, height: 7),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '3+ YEARS • PRODUCTION FLUTTER',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 9.5 : 11.5,
                letterSpacing: compact ? 0.6 : 1.05,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioIndex extends StatelessWidget {
  const _PortfolioIndex();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '01 / PORTFOLIO',
      style: TextStyle(
        color: AppColors.textSubtle,
        fontSize: 10.5,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _RoleSeparator extends StatelessWidget {
  const _RoleSeparator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: AppColors.textMuted,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _CapabilityChip extends StatefulWidget {
  const _CapabilityChip({
    required this.compact,
    required this.icon,
    required this.label,
  });

  final bool compact;
  final IconData icon;
  final String label;

  @override
  State<_CapabilityChip> createState() => _CapabilityChipState();
}

class _CapabilityChipState extends State<_CapabilityChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.surfaceSoft
              : AppColors.surface.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? AppSpacing.sm : AppSpacing.md,
            vertical: widget.compact ? 7 : AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: widget.compact ? 14 : 16,
                color: AppColors.primary,
              ),
              SizedBox(width: widget.compact ? AppSpacing.xxs : AppSpacing.xs),
              Text(
                widget.label,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: widget.compact ? 11 : 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
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
            color: enabled ? null : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: _hovered ? 0.30 : 0.17,
                      ),
                      blurRadius: _hovered ? 30 : 18,
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
              disabledForegroundColor: AppColors.textMuted,
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
                ? AppColors.surfaceSoft.withValues(alpha: 0.82)
                : AppColors.surface.withValues(alpha: 0.55),
            foregroundColor: AppColors.textPrimary,
            disabledForegroundColor: AppColors.textMuted,
            side: BorderSide(
              color: _hovered ? AppColors.borderAccent : AppColors.borderStrong,
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

class _SocialButton extends StatefulWidget {
  const _SocialButton({
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
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.07)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: TextButton.icon(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: _hovered
                ? AppColors.primary
                : AppColors.textSecondary,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.xs : AppSpacing.sm,
              vertical: widget.compact ? 6 : AppSpacing.sm,
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
      ),
    );
  }
}

class _HeroMotionPortrait extends StatefulWidget {
  const _HeroMotionPortrait({
    this.compact = false,
    this.parallax = Offset.zero,
  });

  final bool compact;
  final Offset parallax;

  @override
  State<_HeroMotionPortrait> createState() => _HeroMotionPortraitState();
}

class _HeroMotionPortraitState extends State<_HeroMotionPortrait>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (disableAnimations || widget.compact) {
      _controller.stop();
      _controller.value = 0;
      return;
    }

    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _HeroMotionPortrait oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.compact != widget.compact) {
      final disableAnimations =
          MediaQuery.maybeOf(context)?.disableAnimations ?? false;

      if (disableAnimations || widget.compact) {
        _controller.stop();
        _controller.value = 0;
      } else if (!_controller.isAnimating) {
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (disableAnimations) {
      return Transform.translate(
        offset: widget.parallax,
        child: _HeroPortrait(compact: widget.compact),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      child: RepaintBoundary(child: _HeroPortrait(compact: widget.compact)),
      builder: (context, child) {
        final floatingY = widget.compact
            ? 0.0
            : math.sin(_controller.value * math.pi * 2) * 4;

        return Transform.translate(
          offset: Offset(widget.parallax.dx, widget.parallax.dy + floatingY),
          child: child,
        );
      },
    );
  }
}

class _HeroPortrait extends StatefulWidget {
  const _HeroPortrait({this.compact = false});

  final bool compact;

  @override
  State<_HeroPortrait> createState() => _HeroPortraitState();
}

class _HeroPortraitState extends State<_HeroPortrait> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
      child: AnimatedScale(
        scale: _hovered && !widget.compact ? 1.012 : 1,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        child: AspectRatio(
          aspectRatio: widget.compact ? 0.92 : 0.84,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: widget.compact ? 8 : 14,
                left: widget.compact ? 8 : 14,
                right: widget.compact ? -8 : -14,
                bottom: widget.compact ? -8 : -14,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      widget.compact ? AppRadius.lg : AppRadius.xl,
                    ),
                    border: Border.all(
                      color: AppColors.secondary.withValues(alpha: 0.22),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      widget.compact ? AppRadius.lg : AppRadius.xl,
                    ),
                    gradient: AppColors.surfaceGradient,
                    border: Border.all(
                      color: _hovered
                          ? AppColors.borderAccent
                          : AppColors.borderStrong,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: _hovered ? 0.18 : 0.10,
                        ),
                        blurRadius: _hovered ? 54 : 38,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.compact ? AppRadius.lg - 1 : AppRadius.xl - 1,
                    ),
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
                        Positioned(
                          left: widget.compact ? AppSpacing.sm : AppSpacing.md,
                          right: widget.compact ? AppSpacing.sm : AppSpacing.md,
                          bottom: widget.compact
                              ? AppSpacing.sm
                              : AppSpacing.md,
                          child: _PortraitInfoCard(compact: widget.compact),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: widget.compact ? 14 : 20,
                right: widget.compact ? 14 : 20,
                child: _LiveBadge(compact: widget.compact),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortraitOverlay extends StatelessWidget {
  const _PortraitOverlay();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00050914), Color(0x12030712), Color(0xD9030712)],
          stops: [0.45, 0.68, 1],
        ),
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 10,
          vertical: compact ? 5 : 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, size: 6, color: AppColors.accent),
            const SizedBox(width: 6),
            Text(
              'FLUTTER',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: compact ? 8.5 : 10,
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

class _PortraitInfoCard extends StatelessWidget {
  const _PortraitInfoCard({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceGlass,
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.md : AppRadius.lg,
        ),
        border: Border.all(color: AppColors.borderStrong),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SizedBox(
                width: compact ? 32 : 40,
                height: compact ? 32 : 40,
                child: Icon(
                  Icons.flutter_dash_rounded,
                  color: AppColors.white,
                  size: compact ? 18 : 22,
                ),
              ),
            ),
            SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 11.5 : 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 2),
                    const Text(
                      'Architecture • UI • APIs • Releases',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeroGridPainter(),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D172A), Color(0xFF070D1A), Color(0xFF030712)],
          ),
        ),
      ),
    );
  }
}

class _HeroGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.035)
      ..strokeWidth = 1;

    const spacing = 48.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _TopAccent extends StatelessWidget {
  const _TopAccent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 2,
      decoration: const BoxDecoration(gradient: AppColors.futuristicGradient),
    );
  }
}

class _CursorGlow extends StatelessWidget {
  const _CursorGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 420,
        height: 420,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.10),
              AppColors.secondary.withValues(alpha: 0.045),
              AppColors.transparent,
            ],
            stops: const [0, 0.46, 1],
          ),
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
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
      child: Container(
        width: size,
        height: size,
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
    );
  }
}
