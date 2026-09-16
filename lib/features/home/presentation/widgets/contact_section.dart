import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.windowSize,
    required this.onEmailPressed,
    required this.onWhatsAppPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onEmailPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.alternate_email_rounded,
          label: 'CONTACT',
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isCompact) ...[
              Container(
                width: 3,
                height: 82,
                decoration: BoxDecoration(
                  gradient: AppColors.futuristicGradient,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Text(
                'Have a Flutter project or opportunity to discuss?',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: switch (windowSize) {
                    AppWindowSize.compact => 28,
                    AppWindowSize.medium => 35,
                    AppWindowSize.expanded => 42,
                  },
                  height: 1.12,
                  letterSpacing: -0.9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'You can reach me directly for Flutter development work, '
            'professional opportunities, product discussions, or '
            'collaboration.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              fontSize: _isCompact ? 14 : 16,
              height: 1.68,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _ContactInfoCard(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'asif.gub182@gmail.com',
        ),
        const SizedBox(height: AppSpacing.sm),
        const _ContactInfoCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: '+880 1795-331001',
        ),
        const SizedBox(height: AppSpacing.sm),
        const _ContactInfoCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Mirpur, Dhaka, Bangladesh',
        ),
      ],
    );

    final actions = _ContactActions(
      compact: _isCompact,
      onEmailPressed: onEmailPressed,
      onWhatsAppPressed: onWhatsAppPressed,
      onLinkedInPressed: onLinkedInPressed,
      onGitHubPressed: onGitHubPressed,
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
            colors: [Color(0xFF0D172A), Color(0xFF080F1D), Color(0xFF040914)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.24),
              blurRadius: 36,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSectionBackground(
                compact: _isCompact,
                intensity: 1.35,
              ),
            ),
            Positioned(
              top: 0,
              right: _isCompact ? 22 : 38,
              child: const _SectionIndex(),
            ),
            Padding(
              padding: EdgeInsets.all(switch (windowSize) {
                AppWindowSize.compact => AppSpacing.lg,
                AppWindowSize.medium => AppSpacing.xl,
                AppWindowSize.expanded => AppSpacing.xxl,
              }),
              child: _isExpanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 10, child: introduction),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 8, child: actions),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        introduction,
                        SizedBox(
                          height: _isCompact ? AppSpacing.lg : AppSpacing.xxl,
                        ),
                        actions,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactActions extends StatelessWidget {
  const _ContactActions({
    required this.compact,
    required this.onEmailPressed,
    required this.onWhatsAppPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
  });

  final bool compact;
  final VoidCallback onEmailPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg - 1),
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: _TopAccent(),
            ),
            Padding(
              padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppColors.brandGradient,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.20),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: compact ? 44 : 48,
                          height: compact ? 44 : 48,
                          child: const Icon(
                            Icons.send_rounded,
                            color: AppColors.white,
                            size: 21,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Connect directly',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: compact ? 18 : 21,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Choose the channel that works best for you.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: compact ? 12 : 13.5,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  _ContactActionButton(
                    icon: Icons.email_outlined,
                    label: 'Send an Email',
                    subtitle: 'Best for project and opportunity discussions',
                    primary: true,
                    onPressed: onEmailPressed,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ContactActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'WhatsApp',
                    subtitle: 'Direct conversation',
                    onPressed: onWhatsAppPressed,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ContactActionButton(
                    icon: Icons.work_outline_rounded,
                    label: 'LinkedIn',
                    subtitle: 'Professional profile',
                    onPressed: onLinkedInPressed,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ContactActionButton(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    subtitle: 'Development profile',
                    onPressed: onGitHubPressed,
                  ),
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  const Divider(height: 1, color: AppColors.border),
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  const _FocusSummary(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactActionButton extends StatefulWidget {
  const _ContactActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onPressed,
    this.primary = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onPressed;
  final bool primary;

  @override
  State<_ContactActionButton> createState() => _ContactActionButtonState();
}

class _ContactActionButtonState extends State<_ContactActionButton> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    final useBrandSurface = widget.primary || _active;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 190),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: useBrandSurface
            ? null
            : AppColors.surface.withValues(alpha: 0.72),
        gradient: useBrandSurface ? AppColors.brandGradient : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: useBrandSurface
              ? AppColors.transparent
              : AppColors.borderStrong,
        ),
        boxShadow: useBrandSurface
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: widget.primary ? 0.18 : 0.13,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
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
          borderRadius: BorderRadius.circular(AppRadius.md),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          splashColor: AppColors.white.withValues(alpha: 0.08),
          highlightColor: AppColors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: useBrandSurface ? AppColors.white : AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: useBrandSurface
                              ? AppColors.white
                              : AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: useBrandSurface
                              ? AppColors.white.withValues(alpha: 0.76)
                              : AppColors.textMuted,
                          fontSize: 10.5,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                AnimatedSlide(
                  offset: _active ? const Offset(0.12, 0) : Offset.zero,
                  duration: const Duration(milliseconds: 190),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: useBrandSurface
                        ? AppColors.white
                        : AppColors.textMuted,
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

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.56),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.18),
                    AppColors.secondary.withValues(alpha: 0.10),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.16),
                ),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10.5,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  SelectableText(
                    value,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13.5,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
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

class _FocusSummary extends StatelessWidget {
  const _FocusSummary();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.10),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.18)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_android_rounded,
              color: AppColors.accent,
              size: 19,
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Focused on Flutter application development, '
                'production maintenance, and Android/iOS delivery.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.14),
            blurRadius: 18,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.white),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionIndex extends StatelessWidget {
  const _SectionIndex();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '06 / CONTACT',
        style: TextStyle(
          color: AppColors.textSubtle,
          fontSize: 9.5,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TopAccent extends StatelessWidget {
  const _TopAccent();

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
