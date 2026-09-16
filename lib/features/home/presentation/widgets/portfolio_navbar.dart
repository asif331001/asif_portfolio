import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

enum PortfolioSection {
  home('Home'),
  about('About'),
  experience('Experience'),
  projects('Projects'),
  skills('Skills'),
  contact('Contact');

  const PortfolioSection(this.label);

  final String label;
}

class PortfolioNavbar extends StatelessWidget {
  const PortfolioNavbar({
    required this.activeSection,
    required this.enabledSections,
    required this.onSectionSelected,
    this.onResumePressed,
    super.key,
  });

  final PortfolioSection activeSection;
  final Set<PortfolioSection> enabledSections;
  final ValueChanged<PortfolioSection> onSectionSelected;
  final VoidCallback? onResumePressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.96),
        border: const Border(bottom: BorderSide(color: AppColors.dividerSoft)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: ResponsiveLayout(
          builder: (context, windowSize, constraints) {
            final horizontalPadding = switch (windowSize) {
              AppWindowSize.compact => AppSpacing.md,
              AppWindowSize.medium => AppSpacing.xl,
              AppWindowSize.expanded => AppSpacing.xxl,
            };

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppBreakpoints.maxContentWidth,
                      ),
                      child: SizedBox(
                        height: 78,
                        child: Row(
                          children: [
                            const _Brand(),
                            const Spacer(),
                            if (windowSize == AppWindowSize.expanded) ...[
                              _DesktopNavigation(
                                activeSection: activeSection,
                                enabledSections: enabledSections,
                                onSectionSelected: onSectionSelected,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              _ResumeButton(onPressed: onResumePressed),
                            ] else ...[
                              _ResumeButton(
                                compact: true,
                                onPressed: onResumePressed,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              _CompactNavigation(
                                activeSection: activeSection,
                                enabledSections: enabledSections,
                                onSectionSelected: onSectionSelected,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _NavbarAccentLine(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: 'MD. Asif Ahmed portfolio home',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.20),
                  blurRadius: 18,
                ),
              ],
            ),
            child: const SizedBox(
              width: 34,
              height: 34,
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'ASIF',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 8.5,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({
    required this.activeSection,
    required this.enabledSections,
    required this.onSectionSelected,
  });

  final PortfolioSection activeSection;
  final Set<PortfolioSection> enabledSections;
  final ValueChanged<PortfolioSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final section in PortfolioSection.values)
              _DesktopNavItem(
                section: section,
                isActive: section == activeSection,
                isEnabled: enabledSections.contains(section),
                onPressed: () => onSectionSelected(section),
              ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatefulWidget {
  const _DesktopNavItem({
    required this.section,
    required this.isActive,
    required this.isEnabled,
    required this.onPressed,
  });

  final PortfolioSection section;
  final bool isActive;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;
    final enabled = widget.isEnabled;

    final foregroundColor = switch ((active, enabled, _hovered)) {
      (true, _, _) => AppColors.white,
      (false, true, true) => AppColors.textPrimary,
      (false, true, false) => AppColors.textSecondary,
      _ => AppColors.textSubtle,
    };

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: active ? AppColors.brandGradient : null,
          color: !active && _hovered
              ? AppColors.surfaceSoft.withValues(alpha: 0.88)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: TextButton(
          onPressed: enabled ? widget.onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor: AppColors.textSubtle,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 10,
            ),
            shape: const StadiumBorder(),
          ),
          child: Text(
            widget.section.label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactNavigation extends StatelessWidget {
  const _CompactNavigation({
    required this.activeSection,
    required this.enabledSections,
    required this.onSectionSelected,
  });

  final PortfolioSection activeSection;
  final Set<PortfolioSection> enabledSections;
  final ValueChanged<PortfolioSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PortfolioSection>(
      tooltip: 'Open navigation menu',
      color: AppColors.surfaceElevated,
      surfaceTintColor: AppColors.transparent,
      elevation: 12,
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
        side: BorderSide(color: AppColors.borderStrong),
      ),
      onSelected: onSectionSelected,
      itemBuilder: (context) {
        return [
          for (final section in PortfolioSection.values)
            PopupMenuItem<PortfolioSection>(
              value: section,
              enabled: enabledSections.contains(section),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: section == activeSection
                          ? AppColors.primary
                          : AppColors.transparent,
                      boxShadow: section == activeSection
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.45,
                                ),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    section.label,
                    style: TextStyle(
                      color: enabledSections.contains(section)
                          ? section == activeSection
                                ? AppColors.primary
                                : AppColors.textPrimary
                          : AppColors.textMuted,
                      fontWeight: section == activeSection
                          ? FontWeight.w800
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ];
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderStrong),
        ),
        child: const SizedBox(
          width: 46,
          height: 46,
          child: Icon(Icons.menu_rounded, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  const _ResumeButton({required this.onPressed, this.compact = false});

  final VoidCallback? onPressed;
  final bool compact;

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
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
            gradient: enabled ? AppColors.brandGradient : null,
            color: enabled ? null : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: _hovered ? 0.28 : 0.16,
                      ),
                      blurRadius: _hovered ? 22 : 14,
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
                horizontal: widget.compact ? AppSpacing.sm : AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
              ),
            ),
            icon: Icon(
              Icons.description_outlined,
              size: widget.compact ? 16 : 18,
            ),
            label: Text(
              widget.compact ? 'Resume' : 'View Resume',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavbarAccentLine extends StatelessWidget {
  const _NavbarAccentLine();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.transparent,
              AppColors.primary,
              AppColors.secondary,
              AppColors.transparent,
            ],
            stops: [0, 0.38, 0.62, 1],
          ),
        ),
      ),
    );
  }
}
