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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final tier = AppBreakpoints.tierForWidth(viewportWidth);
    final ultraNarrow = tier == AppViewportTier.ultraNarrow;

    final introduction = _ContactIntroduction(windowSize: windowSize);

    final communicationHub = _CommunicationHub(
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
          border: Border.all(
            color: colors.outline.withValues(alpha: isDark ? 0.90 : 0.74),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF0D1728),
                    Color(0xFF080F1D),
                    Color(0xFF050A14),
                  ]
                : const [
                    Color(0xFFFFFFFF),
                    Color(0xFFF8FAFF),
                    Color(0xFFF0F4FA),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.24 : 0.07),
              blurRadius: 36,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSectionBackground(
                compact: _isCompact,
                intensity: isDark ? 1.08 : 0.42,
              ),
            ),
            if (!ultraNarrow)
              Positioned(
                top: 0,
                right: _isCompact ? 20 : 36,
                child: const _SectionIndex(),
              ),
            Padding(
              padding: EdgeInsets.all(switch (tier) {
                AppViewportTier.ultraNarrow => 12.0,
                AppViewportTier.narrow => 14.0,
                AppViewportTier.compact => AppSpacing.lg,
                AppViewportTier.medium => AppSpacing.xl,
                AppViewportTier.expanded => AppSpacing.xxl,
                AppViewportTier.ultraWide => AppSpacing.xxl,
              }),
              child: _isExpanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 10, child: introduction),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 9, child: communicationHub),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        introduction,
                        SizedBox(
                          height: _isCompact ? AppSpacing.lg : AppSpacing.xxl,
                        ),
                        communicationHub,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactIntroduction extends StatelessWidget {
  const _ContactIntroduction({required this.windowSize});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final tier = AppBreakpoints.tierForWidth(viewportWidth);

    final titleSize = switch (tier) {
      AppViewportTier.ultraNarrow => 22.0,
      AppViewportTier.narrow => 24.0,
      AppViewportTier.compact => 28.0,
      AppViewportTier.medium => 35.0,
      AppViewportTier.expanded => 42.0,
      AppViewportTier.ultraWide => 42.0,
    };

    final bodySize = switch (tier) {
      AppViewportTier.ultraNarrow => 12.0,
      AppViewportTier.narrow => 12.5,
      AppViewportTier.compact => 14.0,
      AppViewportTier.medium => 16.0,
      AppViewportTier.expanded => 16.0,
      AppViewportTier.ultraWide => 16.0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.alternate_email_rounded,
          label: 'CONTACT / CONNECT',
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'Have a Flutter project or professional opportunity to discuss?',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: titleSize,
            height: 1.11,
            letterSpacing: -0.9,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'Reach me directly for Flutter development work, professional '
            'opportunities, product discussions, or collaboration.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.66),
              fontSize: bodySize,
              height: 1.66,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _ContactCoordinates(),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _WorkFocusCard(),
      ],
    );
  }
}

class _ContactCoordinates extends StatelessWidget {
  const _ContactCoordinates();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ContactInfoCard(
          icon: Icons.email_outlined,
          title: 'EMAIL',
          value: 'asif.gub182@gmail.com',
        ),
        SizedBox(height: AppSpacing.xs),
        _ContactInfoCard(
          icon: Icons.phone_outlined,
          title: 'PHONE',
          value: '+880 1795-331001',
        ),
        SizedBox(height: AppSpacing.xs),
        _ContactInfoCard(
          icon: Icons.location_on_outlined,
          title: 'LOCATION',
          value: 'Mirpur, Dhaka, Bangladesh',
        ),
      ],
    );
  }
}

class _ContactInfoCard extends StatefulWidget {
  const _ContactInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
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
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.065)
              : colors.surface.withValues(alpha: 0.54),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.38)
                : colors.outline.withValues(alpha: 0.64),
          ),
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.16),
                ),
              ),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Icon(widget.icon, size: 19, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.42),
                      fontSize: 9.5,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  SelectableText(
                    widget.value,
                    style: TextStyle(
                      color: colors.onSurface,
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

class _WorkFocusCard extends StatelessWidget {
  const _WorkFocusCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.secondary.withValues(alpha: 0.055),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.19)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.phone_android_rounded,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter-focused delivery',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Application architecture, responsive UI, REST API '
                    'integration, local persistence, maintenance, and '
                    'Android/iOS production releases.',
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.58),
                      fontSize: 12,
                      height: 1.5,
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

class _CommunicationHub extends StatelessWidget {
  const _CommunicationHub({
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final dense = viewportWidth <= AppBreakpoints.ultraNarrowMax;
    final narrow = viewportWidth < AppBreakpoints.narrow;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: isDark ? 0.74 : 0.91),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outline.withValues(alpha: 0.76)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.18 : 0.055),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          dense
              ? 10
              : narrow
              ? 12
              : compact
              ? AppSpacing.md
              : AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HubHeader(),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            _PrimaryContactAction(onPressed: onEmailPressed),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            Text(
              'OTHER CHANNELS',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.34),
                fontSize: 9,
                letterSpacing: 1.3,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _ContactRoute(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              description: 'Direct conversation',
              onPressed: onWhatsAppPressed,
            ),
            const SizedBox(height: AppSpacing.xs),
            _ContactRoute(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              description: 'Professional profile',
              onPressed: onLinkedInPressed,
            ),
            const SizedBox(height: AppSpacing.xs),
            _ContactRoute(
              icon: Icons.code_rounded,
              label: 'GitHub',
              description: 'Development profile',
              onPressed: onGitHubPressed,
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            const _CommunicationSummary(),
          ],
        ),
      ),
    );
  }
}

class _HubHeader extends StatelessWidget {
  const _HubHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
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
            width: 46,
            height: 46,
            child: Icon(Icons.send_rounded, size: 21, color: AppColors.white),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Communication hub',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Choose the channel that fits the conversation.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.48),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimaryContactAction extends StatefulWidget {
  const _PrimaryContactAction({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_PrimaryContactAction> createState() => _PrimaryContactActionState();
}

class _PrimaryContactActionState extends State<_PrimaryContactAction> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _active ? 1.01 : 1,
      duration: const Duration(milliseconds: 190),
      curve: Curves.easeOutCubic,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _active ? 0.23 : 0.16),
              blurRadius: _active ? 26 : 20,
              offset: const Offset(0, 10),
            ),
          ],
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
            borderRadius: BorderRadius.circular(AppRadius.lg),
            hoverColor: AppColors.transparent,
            focusColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            splashColor: AppColors.white.withValues(alpha: 0.08),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.16),
                      ),
                    ),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.email_outlined,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Send an email',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Project and opportunity discussions',
                          style: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.74),
                            fontSize: 11,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSlide(
                    offset: _active ? const Offset(0.14, 0) : Offset.zero,
                    duration: const Duration(milliseconds: 190),
                    curve: Curves.easeOutCubic,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 19,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactRoute extends StatefulWidget {
  const _ContactRoute({
    required this.icon,
    required this.label,
    required this.description,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onPressed;

  @override
  State<_ContactRoute> createState() => _ContactRouteState();
}

class _ContactRouteState extends State<_ContactRoute> {
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
              ? AppColors.primary.withValues(alpha: 0.40)
              : colors.outline.withValues(alpha: 0.62),
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
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: SizedBox(
                    width: 38,
                    height: 38,
                    child: Icon(
                      widget.icon,
                      size: 18,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: colors.onSurface.withValues(alpha: 0.46),
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSlide(
                  offset: _active ? const Offset(0.14, 0) : Offset.zero,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    size: 17,
                    color: _active
                        ? AppColors.primary
                        : colors.onSurface.withValues(alpha: 0.34),
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

class _CommunicationSummary extends StatelessWidget {
  const _CommunicationSummary();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.17)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            const Icon(Icons.hub_outlined, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Email, WhatsApp, LinkedIn, and GitHub are available '
                'directly from this portfolio.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.54),
                  fontSize: 11.5,
                  height: 1.45,
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
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '06 / CONTACT',
        style: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.30),
          fontSize: 9.5,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
