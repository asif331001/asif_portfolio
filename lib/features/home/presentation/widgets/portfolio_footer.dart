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
    final brand = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterBrand(),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'MD. Asif Ahmed',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Mobile Application Developer • Flutter Developer',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.5,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const Text(
            'Building and maintaining production Flutter applications '
            'with a focus on responsive UI, architecture, integrations, '
            'local data, and Android/iOS delivery.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12.5,
              height: 1.62,
            ),
          ),
        ),
      ],
    );

    final connections = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13.5,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Find me across these channels.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _FooterAction(
              icon: Icons.email_outlined,
              label: 'Email',
              onPressed: onEmailPressed,
            ),
            _FooterAction(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            _FooterAction(
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            _FooterAction(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onPressed: onWhatsAppPressed,
            ),
          ],
        ),
      ],
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
          border: Border.all(color: AppColors.borderStrong),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1324), Color(0xFF070D1A), Color(0xFF040914)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.20),
              blurRadius: 30,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -180,
              right: -150,
              child: _AmbientOrb(
                size: 360,
                color: AppColors.secondary,
                opacity: 0.07,
              ),
            ),
            const Positioned(
              left: -160,
              bottom: -190,
              child: _AmbientOrb(
                size: 380,
                color: AppColors.primary,
                opacity: 0.05,
              ),
            ),
            const Positioned(
              top: 0,
              left: 28,
              right: 28,
              child: _FooterAccent(),
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
                        Expanded(flex: 6, child: brand),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 5, child: connections),
                        const SizedBox(width: AppSpacing.xxl),
                        _BackToTopButton(onPressed: onBackToTopPressed),
                      ],
                    )
                  else ...[
                    brand,
                    SizedBox(
                      height: _isCompact ? AppSpacing.lg : AppSpacing.xl,
                    ),
                    connections,
                    SizedBox(
                      height: _isCompact ? AppSpacing.lg : AppSpacing.xl,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _BackToTopButton(onPressed: onBackToTopPressed),
                    ),
                  ],
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
                  const Divider(height: 1, color: AppColors.border),
                  SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
                  if (_isCompact)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CopyrightText(),
                        SizedBox(height: 5),
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

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.20),
                blurRadius: 18,
              ),
            ],
          ),
          child: const SizedBox(
            width: 42,
            height: 42,
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
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
                      color: AppColors.textPrimary,
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
            const Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: AppColors.textMuted,
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
    required this.onPressed,
  });

  final IconData icon;
  final String label;
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _active ? null : AppColors.background.withValues(alpha: 0.52),
        gradient: _active ? AppColors.brandGradient : null,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: _active ? AppColors.transparent : AppColors.borderStrong,
        ),
        boxShadow: _active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.13),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
              ]
            : null,
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
          borderRadius: BorderRadius.circular(AppRadius.sm),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          splashColor: AppColors.white.withValues(alpha: 0.08),
          highlightColor: AppColors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color: _active ? AppColors.white : AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: _active ? AppColors.white : AppColors.textSecondary,
                    fontSize: 12,
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.10)
            : AppColors.background.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: _active ? AppColors.borderAccent : AppColors.border,
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
          borderRadius: BorderRadius.circular(AppRadius.sm),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          highlightColor: AppColors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
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
                const Text(
                  'Back to top',
                  style: TextStyle(
                    color: AppColors.textSecondary,
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
    return const Text(
      '© 2026 MD. Asif Ahmed',
      style: TextStyle(
        color: AppColors.textMuted,
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
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.flutter_dash_rounded, size: 15, color: AppColors.primary),
        SizedBox(width: 6),
        Text(
          'Built with Flutter.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
        ),
      ],
    );
  }
}

class _FooterAccent extends StatelessWidget {
  const _FooterAccent();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        gradient: AppColors.futuristicGradient,
      ),
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
