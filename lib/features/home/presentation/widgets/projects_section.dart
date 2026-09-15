import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../projects/data/portfolio_projects.dart';
import '../../../projects/domain/entities/portfolio_project.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.grid_view_rounded, label: 'PROJECTS'),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Selected Flutter products I have worked on.',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: switch (windowSize) {
              AppWindowSize.compact => 27,
              AppWindowSize.medium => 34,
              AppWindowSize.expanded => 40,
            },
            height: 1.15,
            letterSpacing: -0.7,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            'These projects represent real Flutter application work across '
            'education, finance, Islamic learning, medical learning, and '
            'human resource management.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              fontSize: _isCompact ? 14 : 16,
              height: 1.65,
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
                (constraints.maxWidth - (spacing * (columnCount - 1))) /
                columnCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final project in PortfolioProjects.all)
                  SizedBox(
                    width: cardWidth,
                    child: _ProjectCard(
                      project: project,
                      compact: _isCompact,
                      onPressed: () {
                        context.push<void>(project.routePath);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.compact,
    required this.onPressed,
  });

  final PortfolioProject project;
  final bool compact;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.lg - 1 : AppRadius.xl - 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ColoredBox(
                color: AppColors.background,
                child: Image.asset(
                  project.featureGraphic,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  semanticLabel: '${project.title} project preview',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 20 : 22,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    project.subtitle,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: compact ? 12.5 : 13.5,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
                  Text(
                    project.summary,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: compact ? 13 : 14,
                      height: 1.55,
                    ),
                  ),
                  if (project.note != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        child: Text(
                          project.note!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11.5,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final technology in project.technologies)
                        _TechnologyChip(label: technology, compact: compact),
                    ],
                  ),
                  SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                  OutlinedButton.icon(
                    onPressed: onPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.borderStrong),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppRadius.md),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new_rounded, size: 17),
                    label: const Text(
                      'View Project',
                      style: TextStyle(fontWeight: FontWeight.w700),
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

class _TechnologyChip extends StatelessWidget {
  const _TechnologyChip({required this.label, required this.compact});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xs : AppSpacing.sm,
          vertical: compact ? 5 : 6,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: AppColors.primary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
