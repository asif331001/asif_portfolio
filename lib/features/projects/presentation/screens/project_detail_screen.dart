import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/portfolio_project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final PortfolioProject project;

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveLayout(
          builder: (context, windowSize, _) {
            final isCompact = windowSize == AppWindowSize.compact;

            final horizontalPadding = switch (windowSize) {
              AppWindowSize.compact => AppSpacing.md,
              AppWindowSize.medium => AppSpacing.xl,
              AppWindowSize.expanded => AppSpacing.xxl,
            };

            final sectionGap = switch (windowSize) {
              AppWindowSize.compact => AppSpacing.xl,
              AppWindowSize.medium => AppSpacing.xxl,
              AppWindowSize.expanded => AppSpacing.xxxl,
            };

            return Column(
              children: [
                _ProjectHeader(
                  compact: isCompact,
                  horizontalPadding: horizontalPadding,
                  onBackPressed: () => _goBack(context),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: isCompact ? AppSpacing.md : AppSpacing.xxl,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: AppBreakpoints.maxContentWidth,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ProjectHero(
                              project: project,
                              windowSize: windowSize,
                            ),
                            SizedBox(height: sectionGap),
                            _ProjectOverview(
                              project: project,
                              windowSize: windowSize,
                            ),
                            SizedBox(height: sectionGap),
                            _EngineeringSection(
                              project: project,
                              windowSize: windowSize,
                            ),
                            SizedBox(height: sectionGap),
                            _TechnologySection(
                              project: project,
                              compact: isCompact,
                            ),
                            SizedBox(height: sectionGap),
                            _ScreenshotSection(
                              project: project,
                              windowSize: windowSize,
                            ),
                            SizedBox(height: sectionGap),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  const _ProjectHeader({
    required this.compact,
    required this.horizontalPadding,
    required this.onBackPressed,
  });

  final bool compact;
  final double horizontalPadding;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: SizedBox(
              height: compact ? 64 : 72,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onBackPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 19),
                    label: Text(
                      compact ? 'Back' : 'Back to Portfolio',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'ASIF',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                        ),
                        TextSpan(
                          text: '.',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
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

class _ProjectHero extends StatelessWidget {
  const _ProjectHero({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.apps_rounded, label: 'PROJECT DETAIL'),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        _ProjectLogos(project: project, compact: _isCompact),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          project.title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: switch (windowSize) {
              AppWindowSize.compact => 31,
              AppWindowSize.medium => 43,
              AppWindowSize.expanded => 54,
            },
            height: 1.05,
            letterSpacing: -1,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          project.subtitle,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: _isCompact ? 14 : 18,
            height: 1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          project.summary,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.65,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _MetaChip(
              icon: Icons.devices_rounded,
              label: project.platformLabel,
            ),
            const _MetaChip(icon: Icons.flutter_dash_rounded, label: 'Flutter'),
            const _MetaChip(
              icon: Icons.verified_outlined,
              label: 'Production Work',
            ),
          ],
        ),
        if (project.note != null) ...[
          SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.18),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      project.note!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );

    final graphic = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          _isCompact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          _isCompact ? AppRadius.lg - 1 : AppRadius.xl - 1,
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            project.featureGraphic,
            fit: BoxFit.cover,
            semanticLabel: '${project.title} feature graphic',
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          _isCompact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceElevated.withValues(alpha: 0.82),
            AppColors.background,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(_isCompact ? AppSpacing.lg : AppSpacing.xxl),
        child: _isExpanded
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 9, child: content),
                  const SizedBox(width: AppSpacing.xxxl),
                  Expanded(flex: 11, child: graphic),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  content,
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  graphic,
                ],
              ),
      ),
    );
  }
}

class _ProjectLogos extends StatelessWidget {
  const _ProjectLogos({required this.project, required this.compact});

  final PortfolioProject project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final logo in project.logoAssets)
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.borderStrong),
            ),
            child: SizedBox(
              width: compact ? 58 : 68,
              height: compact ? 58 : 68,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.asset(
                    logo,
                    fit: BoxFit.contain,
                    semanticLabel: '${project.title} logo',
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProjectOverview extends StatelessWidget {
  const _ProjectOverview({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.dashboard_outlined, label: 'OVERVIEW'),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Project overview',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: _isCompact ? 25 : 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final useTwoColumns = windowSize != AppWindowSize.compact;

            if (!useTwoColumns) {
              return Column(
                children: [
                  _InfoCard(
                    icon: Icons.account_tree_outlined,
                    title: 'Architecture',
                    body: project.architecture,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _HighlightsCard(highlights: project.highlights),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.account_tree_outlined,
                    title: 'Architecture',
                    body: project.architecture,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: _HighlightsCard(highlights: project.highlights),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _EngineeringSection extends StatelessWidget {
  const _EngineeringSection({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.engineering_outlined, label: 'MY ROLE'),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Flutter engineering responsibilities',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: _isCompact ? 25 : 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Application-side responsibilities handled across this project.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 13 : 15,
            height: 1.5,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = switch (windowSize) {
              AppWindowSize.expanded => 3,
              AppWindowSize.medium => 2,
              AppWindowSize.compact => 1,
            };

            final spacing = _isCompact ? AppSpacing.sm : AppSpacing.md;

            final width =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (
                  var index = 0;
                  index < project.responsibilities.length;
                  index++
                )
                  SizedBox(
                    width: width,
                    child: _ResponsibilityCard(
                      index: index + 1,
                      text: project.responsibilities[index],
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

class _TechnologySection extends StatelessWidget {
  const _TechnologySection({required this.project, required this.compact});

  final PortfolioProject project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.code_rounded, label: 'TECHNOLOGY'),
        SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Technology stack',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: compact ? 25 : 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Frameworks, libraries, integrations, and data technologies used in the application.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: compact ? 13 : 15,
            height: 1.5,
          ),
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final technology in project.technologies)
              _TechnologyChip(label: technology, compact: compact),
          ],
        ),
      ],
    );
  }
}

class _ScreenshotSection extends StatelessWidget {
  const _ScreenshotSection({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.phone_android_rounded,
          label: 'APP SCREENS',
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Product screenshots',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: _isCompact ? 25 : 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Real screens from the application, displayed responsively across device sizes.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 13 : 15,
            height: 1.5,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = switch (windowSize) {
              AppWindowSize.expanded => 4,
              AppWindowSize.medium => 3,
              AppWindowSize.compact => constraints.maxWidth >= 420 ? 2 : 1,
            };

            final spacing = _isCompact ? AppSpacing.sm : AppSpacing.md;

            final cardWidth =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (var index = 0; index < project.screenshots.length; index++)
                  SizedBox(
                    width: cardWidth,
                    child: _ScreenshotCard(
                      imagePath: project.screenshots[index],
                      semanticLabel: '${project.title} screenshot ${index + 1}',
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

class _ScreenshotCard extends StatelessWidget {
  const _ScreenshotCard({required this.imagePath, required this.semanticLabel});

  final String imagePath;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderStrong),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.45),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg - 1),
        child: AspectRatio(
          aspectRatio: 0.455,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            semanticLabel: semanticLabel,
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Icon(icon, color: AppColors.primary, size: 21),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              body,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.5,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightsCard extends StatelessWidget {
  const _HighlightsCard({required this.highlights});

  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Key implementation highlights',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (var index = 0; index < highlights.length; index++) ...[
              _BulletText(text: highlights[index]),
              if (index != highlights.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResponsibilityCard extends StatelessWidget {
  const _ResponsibilityCard({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 27,
                height: 27,
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: AppColors.background,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.5,
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

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            Icons.check_circle_rounded,
            size: 15,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
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
        color: AppColors.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: compact ? 7 : 9,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: compact ? 11.5 : 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xxs),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
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
