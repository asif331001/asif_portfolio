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
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
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

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.maxContentWidth,
                  ),
                  child: SizedBox(
                    height: 72,
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
                          const SizedBox(width: AppSpacing.lg),
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
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'ASIF',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
            TextSpan(
              text: '.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final section in PortfolioSection.values)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: _DesktopNavItem(
              section: section,
              isActive: section == activeSection,
              isEnabled: enabledSections.contains(section),
              onPressed: () => onSectionSelected(section),
            ),
          ),
      ],
    );
  }
}

class _DesktopNavItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final foregroundColor = switch ((isActive, isEnabled)) {
      (true, _) => AppColors.primary,
      (false, true) => AppColors.textSecondary,
      (false, false) => AppColors.textMuted,
    };

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(foregroundColor),
        overlayColor: WidgetStatePropertyAll(
          AppColors.primary.withValues(alpha: 0.08),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
          ),
        ),
      ),
      child: Text(
        section.label,
        style: const TextStyle(fontWeight: FontWeight.w600),
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
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      color: AppColors.surfaceElevated,
      surfaceTintColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        side: BorderSide(color: AppColors.border),
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
                  SizedBox(
                    width: 20,
                    child: section == activeSection
                        ? const Icon(
                            Icons.circle,
                            size: 7,
                            color: AppColors.primary,
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    section.label,
                    style: TextStyle(
                      color: enabledSections.contains(section)
                          ? section == activeSection
                                ? AppColors.primary
                                : AppColors.textPrimary
                          : AppColors.textMuted,
                      fontWeight: section == activeSection
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ];
      },
    );
  }
}

class _ResumeButton extends StatelessWidget {
  const _ResumeButton({required this.onPressed, this.compact = false});

  final VoidCallback? onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        disabledBackgroundColor: AppColors.surfaceSoft,
        disabledForegroundColor: AppColors.textMuted,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
        ),
      ),
      icon: Icon(Icons.download_rounded, size: compact ? 17 : 18),
      label: Text(
        compact ? 'Resume' : 'View Resume',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );

    if (onPressed != null) {
      return button;
    }

    return Tooltip(message: 'View resume', child: button);
  }
}
