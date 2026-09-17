import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/responsive/responsive_metrics.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_controller.dart';

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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(
          alpha: isDark ? 0.94 : 0.92,
        ),
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.90),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.20 : 0.07),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: ResponsiveLayout(
          builder: (context, windowSize, constraints) {
            final viewportWidth = constraints.maxWidth;

            final tier = AppBreakpoints.tierForWidth(viewportWidth);

            final ultraNarrow = tier == AppViewportTier.ultraNarrow;

            final horizontalPadding = ResponsiveMetrics.pageHorizontalPadding(
              viewportWidth,
            );

            final navbarHeight = ResponsiveMetrics.navbarHeight(viewportWidth);

            final compact = windowSize != AppWindowSize.expanded;

            final controlSize = ultraNarrow ? 40.0 : 44.0;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.maxContentWidth,
                  ),
                  child: SizedBox(
                    height: navbarHeight,
                    child: Row(
                      children: [
                        _Brand(
                          compact: windowSize == AppWindowSize.compact,
                          ultraNarrow: ultraNarrow,
                        ),
                        const Spacer(),
                        if (!compact) ...[
                          _DesktopNavigation(
                            activeSection: activeSection,
                            enabledSections: enabledSections,
                            onSectionSelected: onSectionSelected,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const _ThemeToggle(size: 46),
                          const SizedBox(width: AppSpacing.sm),
                          _ResumeButton(onPressed: onResumePressed),
                        ] else ...[
                          _ThemeToggle(size: controlSize),
                          SizedBox(width: ultraNarrow ? 4 : AppSpacing.xs),
                          _ResumeButton(
                            compact: true,
                            size: controlSize,
                            onPressed: onResumePressed,
                          ),
                          SizedBox(width: ultraNarrow ? 4 : AppSpacing.xs),
                          _CompactNavigation(
                            activeSection: activeSection,
                            enabledSections: enabledSections,
                            onSectionSelected: onSectionSelected,
                            size: controlSize,
                            ultraNarrow: ultraNarrow,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({this.compact = false, this.ultraNarrow = false});

  final bool compact;
  final bool ultraNarrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final markSize = ultraNarrow ? 32.0 : 34.0;

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
            child: SizedBox(
              width: markSize,
              height: markSize,
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ultraNarrow ? 15 : 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          if (!compact) ...[
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
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.52),
                    fontSize: 8.5,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
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
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.outline.withValues(alpha: 0.72)),
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
                onPressed: () {
                  onSectionSelected(section);
                },
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final active = widget.isActive;
    final enabled = widget.isEnabled;

    final foregroundColor = switch ((active, enabled, _hovered)) {
      (true, _, _) => isDark ? AppColors.white : AppColors.primary,
      (false, true, true) => colors.onSurface,
      (false, true, false) => colors.onSurface.withValues(alpha: 0.68),
      _ => colors.onSurface.withValues(alpha: 0.34),
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
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: active && isDark ? AppColors.brandGradient : null,
          color: active && !isDark
              ? AppColors.primary.withValues(alpha: 0.10)
              : !active && _hovered
              ? colors.primary.withValues(alpha: 0.08)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: active && !isDark
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.22))
              : null,
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(
                      alpha: isDark ? 0.18 : 0.08,
                    ),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: TextButton(
          onPressed: enabled ? widget.onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor: colors.onSurface.withValues(alpha: 0.32),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: const StadiumBorder(),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 12,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
            ),
            child: Text(widget.section.label),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle({required this.size});

  final double size;

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    final targetLabel = isDark
        ? 'Switch to light theme'
        : 'Switch to dark theme';

    return Tooltip(
      message: targetLabel,
      child: Semantics(
        button: true,
        label: targetLabel,
        child: MouseRegion(
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
          child: AnimatedScale(
            scale: _hovered ? 1.045 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: () {
                  ThemeController.instance.toggleTheme();
                },
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? colors.primary.withValues(alpha: 0.11)
                        : colors.surface.withValues(alpha: 0.76),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.primary.withValues(alpha: 0.58)
                          : colors.outline.withValues(alpha: 0.72),
                    ),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      child: Icon(
                        isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        key: ValueKey(isDark),
                        size: widget.size < 44 ? 17 : 19,
                        color: isDark
                            ? const Color(0xFFFFD66B)
                            : AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ),
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
    required this.size,
    required this.ultraNarrow,
  });

  final PortfolioSection activeSection;
  final Set<PortfolioSection> enabledSections;
  final ValueChanged<PortfolioSection> onSectionSelected;
  final double size;
  final bool ultraNarrow;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return PopupMenuButton<PortfolioSection>(
      tooltip: 'Current section: ${activeSection.label}',
      color: colors.surface,
      surfaceTintColor: AppColors.transparent,
      elevation: 12,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
        side: BorderSide(color: colors.outline),
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
                    duration: const Duration(milliseconds: 220),
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
                                : colors.onSurface
                          : colors.onSurface.withValues(alpha: 0.38),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: size,
        width: ultraNarrow ? 78 : 96,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
        ),
        padding: EdgeInsets.symmetric(horizontal: ultraNarrow ? 7 : 9),
        child: Row(
          children: [
            Icon(
              Icons.menu_rounded,
              size: ultraNarrow ? 16 : 17,
              color: AppColors.primary,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  activeSection.label,
                  key: ValueKey(activeSection),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: ultraNarrow ? 9 : 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  const _ResumeButton({
    required this.onPressed,
    this.compact = false,
    this.size = 46,
  });

  final VoidCallback? onPressed;
  final bool compact;
  final double size;

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;

    if (widget.compact) {
      return Tooltip(
        message: 'View Resume',
        child: MouseRegion(
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
            scale: _hovered ? 1.045 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: enabled ? AppColors.brandGradient : null,
                color: enabled ? null : colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: IconButton(
                  tooltip: 'View Resume',
                  onPressed: widget.onPressed,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.description_outlined,
                    size: widget.size < 44 ? 17 : 18,
                  ),
                  color: AppColors.white,
                  disabledColor: colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ),
          ),
        ),
      );
    }

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
            color: enabled ? null : colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.transparent,
              foregroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.transparent,
              disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
              shadowColor: AppColors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
              ),
            ),
            icon: const Icon(Icons.description_outlined, size: 18),
            label: const Text(
              'View Resume',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
