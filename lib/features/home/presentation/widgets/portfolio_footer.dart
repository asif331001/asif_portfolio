import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({
    required this.windowSize,
    required this.onEmailPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    required this.onBackToTopPressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onEmailPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onBackToTopPressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final brand = _FooterIdentity(compact: _isCompact);

    final connect = _FooterConnect(
      compact: _isCompact,
      onEmailPressed: onEmailPressed,
      onLinkedInPressed: onLinkedInPressed,
      onGitHubPressed: onGitHubPressed,
      onWhatsAppPressed: onWhatsAppPressed,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        _isCompact ? AppRadius.lg : AppRadius.xl,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            _isCompact ? AppRadius.lg : AppRadius.xl,
          ),
          border: Border.all(
            color: colors.outline.withValues(alpha: isDark ? 0.90 : 0.74),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF0A1324),
                    Color(0xFF070D1A),
                    Color(0xFF040914),
                  ]
                : const [
                    Color(0xFFFFFFFF),
                    Color(0xFFF8FAFF),
                    Color(0xFFF0F4FA),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.20 : 0.055),
              blurRadius: 30,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -190,
              right: -160,
              child: _AmbientOrb(
                size: 380,
                color: AppColors.secondary,
                opacity: isDark ? 0.065 : 0.035,
              ),
            ),
            Positioned(
              left: -170,
              bottom: -210,
              child: _AmbientOrb(
                size: 400,
                color: AppColors.primary,
                opacity: isDark ? 0.050 : 0.030,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(switch (windowSize) {
                AppWindowSize.compact => AppSpacing.lg,
                AppWindowSize.medium => AppSpacing.xl,
                AppWindowSize.expanded => AppSpacing.xxl,
              }),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_isExpanded)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: brand),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 6, child: connect),
                        const SizedBox(width: AppSpacing.xxl),
                        _BackToTopButton(onPressed: onBackToTopPressed),
                      ],
                    )
                  else ...[
                    brand,
                    SizedBox(
                      height: _isCompact ? AppSpacing.lg : AppSpacing.xl,
                    ),
                    connect,
                    SizedBox(
                      height: _isCompact ? AppSpacing.lg : AppSpacing.xl,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _BackToTopButton(onPressed: onBackToTopPressed),
                    ),
                  ],
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
                  Divider(
                    height: 1,
                    color: colors.outline.withValues(alpha: 0.56),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
                  if (_isCompact)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CopyrightText(),
                        SizedBox(height: 6),
                        _BuiltWithFlutter(),
                      ],
                    )
                  else
                    const Row(
                      children: [
                        _CopyrightText(),
                        Spacer(),
                        _BuiltWithFlutter(),
                      ],
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

class _FooterIdentity extends StatelessWidget {
  const _FooterIdentity({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterBrand(),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'MD. Asif Ahmed',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: compact ? 15 : 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Mobile Application Developer • Flutter Developer',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.62),
            fontSize: compact ? 12 : 13,
            height: 1.45,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Building and maintaining production Flutter applications '
            'with responsive interfaces, application architecture, '
            'integrations, local data, debugging, and Android/iOS delivery.',
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.50),
              fontSize: 12.5,
              height: 1.62,
            ),
          ),
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        const _FooterSignals(),
      ],
    );
  }
}

class _FooterSignals extends StatelessWidget {
  const _FooterSignals();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: const [
        _FooterSignal(icon: Icons.flutter_dash_rounded, label: 'Flutter'),
        _FooterSignal(icon: Icons.devices_outlined, label: 'Android + iOS'),
        _FooterSignal(
          icon: Icons.location_on_outlined,
          label: 'Dhaka, Bangladesh',
        ),
      ],
    );
  }
}

class _FooterSignal extends StatelessWidget {
  const _FooterSignal({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.outline.withValues(alpha: 0.58)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.58),
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterConnect extends StatelessWidget {
  const _FooterConnect({
    required this.compact,
    required this.onEmailPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
  });

  final bool compact;
  final VoidCallback onEmailPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: compact ? 15 : 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Direct channels for professional conversations.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.48),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _FooterAction(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'asif.gub182@gmail.com',
          onPressed: onEmailPressed,
        ),
        const SizedBox(height: AppSpacing.xs),
        _FooterAction(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          value: 'Professional profile',
          onPressed: onLinkedInPressed,
        ),
        const SizedBox(height: AppSpacing.xs),
        _FooterAction(
          icon: Icons.code_rounded,
          label: 'GitHub',
          value: 'Development profile',
          onPressed: onGitHubPressed,
        ),
        const SizedBox(height: AppSpacing.xs),
        _FooterAction(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'WhatsApp',
          value: 'Direct conversation',
          onPressed: onWhatsAppPressed,
        ),
      ],
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.18),
                blurRadius: 18,
              ),
            ],
          ),
          child: const SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'ASIF',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.40),
                fontSize: 8.5,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterAction extends StatefulWidget {
  const _FooterAction({
    required this.icon,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onPressed;

  @override
  State<_FooterAction> createState() => _FooterActionState();
}

class _FooterActionState extends State<_FooterAction> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(0, _active ? -2 : 0, 0),
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.07)
            : colors.surface.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _active
              ? AppColors.primary.withValues(alpha: 0.38)
              : colors.outline.withValues(alpha: 0.60),
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) {
            setState(() {
              _hovered = value;
            });
          },
          onFocusChange: (value) {
            setState(() {
              _focused = value;
            });
          },
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(AppRadius.md),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.06),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      widget.icon,
                      size: 17,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colors.onSurface.withValues(alpha: 0.44),
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSlide(
                  offset: _active ? const Offset(0.12, 0) : Offset.zero,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    size: 16,
                    color: _active
                        ? AppColors.primary
                        : colors.onSurface.withValues(alpha: 0.30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackToTopButton extends StatefulWidget {
  const _BackToTopButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.09)
            : colors.surface.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _active
              ? AppColors.primary.withValues(alpha: 0.40)
              : colors.outline.withValues(alpha: 0.60),
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) {
            setState(() {
              _hovered = value;
            });
          },
          onFocusChange: (value) {
            setState(() {
              _focused = value;
            });
          },
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(AppRadius.md),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.06),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  offset: _active ? const Offset(0, -0.12) : Offset.zero,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    size: 17,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Back to top',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.68),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyrightText extends StatelessWidget {
  const _CopyrightText();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      '© 2026 MD. Asif Ahmed',
      style: TextStyle(
        color: colors.onSurface.withValues(alpha: 0.40),
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _BuiltWithFlutter extends StatelessWidget {
  const _BuiltWithFlutter();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.flutter_dash_rounded,
          size: 15,
          color: AppColors.primary,
        ),
        const SizedBox(width: 6),
        Text(
          'Built with Flutter.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.40),
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }
}

class _AmbientOrb extends StatelessWidget {
  const _AmbientOrb({
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
