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
            colors: [Color(0xFF0C1628), Color(0xFF080F1D), Color(0xFF040914)],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionLabel(
                    icon: Icons.grid_view_rounded,
                    label: 'PROJECTS',
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
                          'Selected Flutter products I have worked on.',
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
                    constraints: const BoxConstraints(maxWidth: 850),
                    child: Text(
                      'These projects represent real Flutter application '
                      'work across education, finance, Islamic learning, '
                      'medical learning, and human resource management.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: _isCompact ? 14 : 16,
                        height: 1.68,
                      ),
                    ),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columnCount = switch (windowSize) {
                        AppWindowSize.expanded => 3,
                        AppWindowSize.medium => 2,
                        AppWindowSize.compact => 1,
                      };

                      final spacing = switch (windowSize) {
                        AppWindowSize.compact => AppSpacing.md,
                        AppWindowSize.medium => AppSpacing.lg,
                        AppWindowSize.expanded => AppSpacing.lg,
                      };

                      final cardWidth =
                          (constraints.maxWidth -
                              (spacing * (columnCount - 1))) /
                          columnCount;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: [
                          for (
                            var index = 0;
                            index < PortfolioProjects.all.length;
                            index++
                          )
                            SizedBox(
                              width: cardWidth,
                              child: _ProjectCard(
                                index: index,
                                project: PortfolioProjects.all[index],
                                compact: _isCompact,
                                onPressed: () {
                                  context.push<void>(
                                    PortfolioProjects.all[index].routePath,
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    },
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.index,
    required this.project,
    required this.compact,
    required this.onPressed,
  });

  final int index;
  final PortfolioProject project;
  final bool compact;
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
    final radius = widget.compact ? AppRadius.lg : AppRadius.xl;

    final visibleTechnologyCount = widget.compact ? 4 : 5;

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
              ? AppColors.surfaceElevated
              : AppColors.surface.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: _active ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _active
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.11),
                    blurRadius: 30,
                    offset: const Offset(0, 14),
                  ),
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.07),
                    blurRadius: 38,
                    offset: const Offset(0, 18),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.16),
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
              splashColor: AppColors.primary.withValues(alpha: 0.08),
              highlightColor: AppColors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProjectPreview(
                    active: _active,
                    index: widget.index,
                    project: widget.project,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      widget.compact ? AppSpacing.md : AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: widget.compact ? 20 : 22,
                            height: 1.15,
                            letterSpacing: -0.25,
                            fontWeight: FontWeight.w900,
                          ),
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
                            color: AppColors.textSecondary,
                            fontSize: widget.compact ? 13 : 14,
                            height: 1.56,
                          ),
                        ),
                        if (widget.project.note != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          _ProjectNote(text: widget.project.note!),
                        ],
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
  });

  final bool active;
  final int index;
  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
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
                  AppColors.background.withValues(alpha: 0.06),
                  AppColors.background.withValues(alpha: 0.80),
                ],
                stops: const [0, 0.52, 1],
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
              children: [
                Flexible(child: _PlatformBadge(label: project.platformLabel)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              height: active ? 3 : 2,
              decoration: BoxDecoration(
                gradient: AppColors.futuristicGradient,
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.30),
                          blurRadius: 12,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ],
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
        color: AppColors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.22)),
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
        color: AppColors.background.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        child: Text(
          value,
          style: const TextStyle(
            color: AppColors.textSecondary,
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
        color: AppColors.background.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderStrong),
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
                  color: AppColors.textPrimary,
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

class _ProjectNote extends StatelessWidget {
  const _ProjectNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.10),
            AppColors.primary.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: active ? null : AppColors.background.withValues(alpha: 0.58),
        gradient: active ? AppColors.brandGradient : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: active ? AppColors.transparent : AppColors.borderStrong,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
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
              'View Project',
              style: TextStyle(
                color: active ? AppColors.white : AppColors.textPrimary,
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized
            ? AppColors.primary.withValues(alpha: 0.10)
            : AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: emphasized
              ? AppColors.primary.withValues(alpha: 0.22)
              : AppColors.border,
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
            color: emphasized ? AppColors.primary : AppColors.textSecondary,
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
    return const Padding(
      padding: EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '04 / PROJECTS',
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
