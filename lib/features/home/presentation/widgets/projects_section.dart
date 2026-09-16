import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';
import '../../../projects/data/portfolio_projects.dart';
import '../../../projects/domain/entities/portfolio_project.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
                    Color(0xFF0C1628),
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
                intensity: isDark ? 1.10 : 0.44,
              ),
            ),
            Positioned(
              top: 0,
              right: _isCompact ? 20 : 36,
              child: const _SectionIndex(),
            ),
            Padding(
              padding: EdgeInsets.all(switch (windowSize) {
                AppWindowSize.compact => AppSpacing.lg,
                AppWindowSize.medium => AppSpacing.xl,
                AppWindowSize.expanded => AppSpacing.xxl,
              }),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionLabel(
                    icon: Icons.grid_view_rounded,
                    label: 'PROJECTS / PRODUCTS',
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
                  Text(
                    'Flutter products built for real users and real workflows.',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: switch (windowSize) {
                        AppWindowSize.compact => 28,
                        AppWindowSize.medium => 35,
                        AppWindowSize.expanded => 42,
                      },
                      height: 1.11,
                      letterSpacing: -0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Text(
                      'These projects represent production Flutter work across '
                      'education, finance, Islamic learning, medical learning, '
                      'and human resource management.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.66),
                        fontSize: _isCompact ? 14 : 16,
                        height: 1.66,
                      ),
                    ),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
                  _ProjectOverview(compact: _isCompact),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  _ProjectsLayout(windowSize: windowSize),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectOverview extends StatelessWidget {
  const _ProjectOverview({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    const items = [
      _OverviewData(
        icon: Icons.apps_rounded,
        value: '08',
        label: 'Flutter products',
      ),
      _OverviewData(
        icon: Icons.devices_outlined,
        value: 'Android + iOS',
        label: 'Production platforms',
      ),
      _OverviewData(
        icon: Icons.account_tree_outlined,
        value: 'App Layer',
        label: 'Flutter ownership',
      ),
      _OverviewData(
        icon: Icons.rocket_launch_outlined,
        value: 'Production',
        label: 'Release experience',
      ),
    ];

    if (compact) {
      return Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: [
          for (final item in items)
            SizedBox(
              width: double.infinity,
              child: _OverviewCard(data: item),
            ),
        ],
      );
    }

    return Row(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          Expanded(child: _OverviewCard(data: items[index])),
          if (index != items.length - 1) const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _OverviewData {
  const _OverviewData({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.data});

  final _OverviewData data;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.56),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outline.withValues(alpha: 0.64)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
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
                child: Icon(data.icon, size: 18, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.value,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.label,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.46),
                      fontSize: 10.5,
                      height: 1.3,
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

class _ProjectsLayout extends StatelessWidget {
  const _ProjectsLayout({required this.windowSize});

  final AppWindowSize windowSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final projects = PortfolioProjects.all;

        final spacing = switch (windowSize) {
          AppWindowSize.compact => AppSpacing.md,
          AppWindowSize.medium => AppSpacing.lg,
          AppWindowSize.expanded => AppSpacing.lg,
        };

        if (windowSize == AppWindowSize.compact) {
          return Column(
            children: [
              for (var index = 0; index < projects.length; index++) ...[
                _ProjectCard(
                  index: index,
                  project: projects[index],
                  compact: true,
                  featured: index < 2,
                  onPressed: () {
                    context.push<void>(projects[index].routePath);
                  },
                ),
                if (index != projects.length - 1) SizedBox(height: spacing),
              ],
            ],
          );
        }

        if (windowSize == AppWindowSize.medium) {
          final cardWidth = (constraints.maxWidth - spacing) / 2;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (var index = 0; index < projects.length; index++)
                SizedBox(
                  width: cardWidth,
                  child: _ProjectCard(
                    index: index,
                    project: projects[index],
                    compact: false,
                    featured: index < 2,
                    onPressed: () {
                      context.push<void>(projects[index].routePath);
                    },
                  ),
                ),
            ],
          );
        }

        final featuredWidth = (constraints.maxWidth - spacing) / 2;

        final standardWidth = (constraints.maxWidth - (spacing * 2)) / 3;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var index = 0; index < projects.length; index++)
              SizedBox(
                width: index < 2 ? featuredWidth : standardWidth,
                child: _ProjectCard(
                  index: index,
                  project: projects[index],
                  compact: false,
                  featured: index < 2,
                  onPressed: () {
                    context.push<void>(projects[index].routePath);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.index,
    required this.project,
    required this.compact,
    required this.featured,
    required this.onPressed,
  });

  final int index;
  final PortfolioProject project;
  final bool compact;
  final bool featured;
  final VoidCallback onPressed;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final radius = widget.compact ? AppRadius.lg : AppRadius.xl;

    final visibleTechnologyCount = widget.featured
        ? 6
        : widget.compact
        ? 4
        : 5;

    final visibleTechnologies = widget.project.technologies
        .take(visibleTechnologyCount)
        .toList();

    final hiddenTechnologyCount =
        widget.project.technologies.length - visibleTechnologies.length;

    return AnimatedScale(
      scale: _active ? 1.012 : 1,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _active
              ? colors.surface
              : colors.surface.withValues(alpha: isDark ? 0.70 : 0.88),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: _active
                ? AppColors.primary.withValues(alpha: 0.44)
                : colors.outline.withValues(alpha: 0.70),
          ),
          boxShadow: _active
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(
                      alpha: isDark ? 0.11 : 0.08,
                    ),
                    blurRadius: 30,
                    offset: const Offset(0, 14),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.black.withValues(
                      alpha: isDark ? 0.16 : 0.045,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius - 1),
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
              hoverColor: AppColors.transparent,
              focusColor: AppColors.transparent,
              highlightColor: AppColors.transparent,
              splashColor: AppColors.primary.withValues(alpha: 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProjectPreview(
                    active: _active,
                    index: widget.index,
                    project: widget.project,
                    featured: widget.featured,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      widget.compact ? AppSpacing.md : AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontSize: widget.featured
                                      ? widget.compact
                                            ? 21
                                            : 24
                                      : widget.compact
                                      ? 20
                                      : 21,
                                  height: 1.15,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            if (widget.featured) ...[
                              const SizedBox(width: AppSpacing.sm),
                              const _FeaturedBadge(),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          widget.project.subtitle,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: widget.compact ? 12.5 : 13.5,
                            height: 1.4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: widget.compact
                              ? AppSpacing.sm
                              : AppSpacing.md,
                        ),
                        Text(
                          widget.project.summary,
                          style: TextStyle(
                            color: colors.onSurface.withValues(alpha: 0.60),
                            fontSize: widget.compact ? 13 : 14,
                            height: 1.56,
                          ),
                        ),

                        SizedBox(
                          height: widget.compact
                              ? AppSpacing.md
                              : AppSpacing.lg,
                        ),
                        Wrap(
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: [
                            for (final technology in visibleTechnologies)
                              _TechnologyChip(
                                label: technology,
                                compact: widget.compact,
                              ),
                            if (hiddenTechnologyCount > 0)
                              _TechnologyChip(
                                label: '+$hiddenTechnologyCount',
                                compact: widget.compact,
                                emphasized: true,
                              ),
                          ],
                        ),
                        SizedBox(
                          height: widget.compact
                              ? AppSpacing.md
                              : AppSpacing.lg,
                        ),
                        _ProjectAction(active: _active),
                      ],
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

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({
    required this.active,
    required this.index,
    required this.project,
    required this.featured,
  });

  final bool active;
  final int index;
  final PortfolioProject project;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: featured ? 16 / 8.4 : 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.background),
          ClipRect(
            child: AnimatedScale(
              scale: active ? 1.035 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: Image.asset(
                project.featureGraphic,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                semanticLabel: '${project.title} project preview',
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.background.withValues(alpha: 0.04),
                  AppColors.background.withValues(alpha: 0.82),
                ],
                stops: const [0, 0.50, 1],
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: _ProjectNumber(index: index),
          ),
          if (project.logoAssets.isNotEmpty)
            Positioned(
              top: AppSpacing.sm,
              left: AppSpacing.sm,
              child: _ProjectLogo(
                assetPath: project.logoAssets.first,
                projectTitle: project.title,
              ),
            ),
          Positioned(
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: _PlatformBadge(label: project.platformLabel)),
                const Spacer(),
                if (featured) const _PreviewSignal(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewSignal extends StatelessWidget {
  const _PreviewSignal();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.28)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, size: 13, color: AppColors.primary),
            SizedBox(width: 4),
            Text(
              'PRODUCT',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 9,
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

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          'FEATURED',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 8.5,
            letterSpacing: 0.9,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _ProjectLogo extends StatelessWidget {
  const _ProjectLogo({required this.assetPath, required this.projectTitle});

  final String assetPath;
  final String projectTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.24),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        semanticLabel: '$projectTitle logo',
      ),
    );
  }
}

class _ProjectNumber extends StatelessWidget {
  const _ProjectNumber({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final value = (index + 1).toString().padLeft(2, '0');

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.14)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        child: Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 9.5,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  const _PlatformBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.14)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.devices_rounded,
              size: 14,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectAction extends StatelessWidget {
  const _ProjectAction({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: active ? null : colors.surface.withValues(alpha: 0.62),
        gradient: active ? AppColors.brandGradient : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: active
              ? AppColors.transparent
              : colors.outline.withValues(alpha: 0.70),
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Open project',
              style: TextStyle(
                color: active ? AppColors.white : colors.onSurface,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          AnimatedSlide(
            offset: active ? const Offset(0.12, 0) : Offset.zero,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 17,
              color: active ? AppColors.white : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnologyChip extends StatelessWidget {
  const _TechnologyChip({
    required this.label,
    required this.compact,
    this.emphasized = false,
  });

  final String label;
  final bool compact;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized
            ? AppColors.primary.withValues(alpha: 0.10)
            : colors.surface.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: emphasized
              ? AppColors.primary.withValues(alpha: 0.22)
              : colors.outline.withValues(alpha: 0.62),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xs : AppSpacing.sm,
          vertical: compact ? 5 : 6,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: emphasized
                ? AppColors.primary
                : colors.onSurface.withValues(alpha: 0.62),
            fontSize: compact ? 10.5 : 11.5,
            fontWeight: FontWeight.w600,
          ),
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
        '04 / PROJECTS',
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
