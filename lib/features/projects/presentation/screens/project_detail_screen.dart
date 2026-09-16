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
              AppWindowSize.compact => AppSpacing.lg,
              AppWindowSize.medium => AppSpacing.xl,
              AppWindowSize.expanded => AppSpacing.xxl,
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              windowSize: windowSize,
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
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.96),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: SizedBox(
              height: compact ? 64 : 74,
              child: Row(
                children: [
                  _BackButton(compact: compact, onPressed: onBackPressed),
                  const Spacer(),
                  const _HeaderBrand(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  const _BackButton({required this.compact, required this.onPressed});

  final bool compact;
  final VoidCallback onPressed;

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
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
            : AppColors.surface.withValues(alpha: 0.52),
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
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  offset: _active ? const Offset(-0.10, 0) : Offset.zero,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  widget.compact ? 'Back' : 'Back to Portfolio',
                  style: const TextStyle(
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

class _HeaderBrand extends StatelessWidget {
  const _HeaderBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.18),
                blurRadius: 14,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'ASIF',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
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
      ],
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
              AppWindowSize.compact => 32,
              AppWindowSize.medium => 44,
              AppWindowSize.expanded => 56,
            },
            height: 1.04,
            letterSpacing: -1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return AppColors.brandGradient.createShader(bounds);
          },
          child: Text(
            project.subtitle,
            style: TextStyle(
              color: AppColors.white,
              fontSize: _isCompact ? 14 : 18,
              height: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          project.summary,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.68,
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
              icon: Icons.layers_outlined,
              label: 'Flutter Project',
            ),
          ],
        ),
        if (project.note != null) ...[
          SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
          _ProjectNote(note: project.note!),
        ],
      ],
    );

    final graphic = _FeatureGraphic(project: project, compact: _isCompact);

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
            const Positioned(
              top: -170,
              left: -140,
              child: _AmbientOrb(
                size: 370,
                color: AppColors.primary,
                opacity: 0.08,
              ),
            ),
            const Positioned(
              right: -160,
              bottom: -190,
              child: _AmbientOrb(
                size: 390,
                color: AppColors.secondary,
                opacity: 0.10,
              ),
            ),
            const Positioned(top: 0, left: 28, right: 28, child: _TopAccent()),
            Positioned(
              top: _isCompact ? 18 : 24,
              right: _isCompact ? 20 : 28,
              child: const _CaseStudyIndex(),
            ),
            Padding(
              padding: EdgeInsets.all(
                _isCompact ? AppSpacing.lg : AppSpacing.xxl,
              ),
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
                        SizedBox(
                          height: _isCompact ? AppSpacing.lg : AppSpacing.xxl,
                        ),
                        graphic,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureGraphic extends StatefulWidget {
  const _FeatureGraphic({required this.project, required this.compact});

  final PortfolioProject project;
  final bool compact;

  @override
  State<_FeatureGraphic> createState() => _FeatureGraphicState();
}

class _FeatureGraphicState extends State<_FeatureGraphic> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(
            widget.compact ? AppRadius.lg : AppRadius.xl,
          ),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.borderStrong,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.compact ? AppRadius.lg - 1 : AppRadius.xl - 1,
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedScale(
                  scale: _hovered ? 1.025 : 1,
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    widget.project.featureGraphic,
                    fit: BoxFit.cover,
                    semanticLabel: '${widget.project.title} feature graphic',
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.transparent,
                        AppColors.background.withValues(alpha: 0.02),
                        AppColors.background.withValues(alpha: 0.38),
                      ],
                    ),
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
          Container(
            width: compact ? 58 : 68,
            height: compact ? 58 : 68,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.18),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.22),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
                semanticLabel: '${project.title} logo',
              ),
            ),
          ),
      ],
    );
  }
}

class _ProjectNote extends StatelessWidget {
  const _ProjectNote({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: AppColors.accent,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                note,
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
    return _SectionShell(
      compact: _isCompact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailSectionHeader(
            compact: _isCompact,
            icon: Icons.dashboard_outlined,
            label: 'OVERVIEW',
            title: 'Project overview',
            subtitle:
                'Architecture and implementation highlights from the application.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
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
      ),
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
    return _SectionShell(
      compact: _isCompact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailSectionHeader(
            compact: _isCompact,
            icon: Icons.engineering_outlined,
            label: 'MY ROLE',
            title: 'Flutter engineering responsibilities',
            subtitle:
                'Application-side responsibilities handled across this project.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
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
      ),
    );
  }
}

class _TechnologySection extends StatelessWidget {
  const _TechnologySection({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      compact: _isCompact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailSectionHeader(
            compact: _isCompact,
            icon: Icons.code_rounded,
            label: 'TECHNOLOGY',
            title: 'Technology stack',
            subtitle:
                'Frameworks, libraries, integrations, and data technologies used in the application.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final technology in project.technologies)
                _TechnologyChip(label: technology, compact: _isCompact),
            ],
          ),
        ],
      ),
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
    return _SectionShell(
      compact: _isCompact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailSectionHeader(
            compact: _isCompact,
            icon: Icons.phone_android_rounded,
            label: 'APP SCREENS',
            title: 'Product screenshots',
            subtitle:
                'Real screens from the application, displayed responsively across device sizes.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
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
                  for (
                    var index = 0;
                    index < project.screenshots.length;
                    index++
                  )
                    SizedBox(
                      width: cardWidth,
                      child: _ScreenshotCard(
                        index: index + 1,
                        imagePath: project.screenshots[index],
                        semanticLabel:
                            '${project.title} screenshot ${index + 1}',
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({required this.compact, required this.child});

  final bool compact;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        compact ? AppRadius.lg : AppRadius.xl,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.lg : AppRadius.xl,
          ),
          border: Border.all(color: AppColors.borderStrong),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1526), Color(0xFF080F1D), Color(0xFF050A15)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.18),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -180,
              right: -160,
              child: _AmbientOrb(
                size: 360,
                color: AppColors.secondary,
                opacity: 0.05,
              ),
            ),
            const Positioned(top: 0, left: 28, right: 28, child: _TopAccent()),
            Padding(
              padding: EdgeInsets.all(compact ? AppSpacing.lg : AppSpacing.xxl),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSectionHeader extends StatelessWidget {
  const _DetailSectionHeader({
    required this.compact,
    required this.icon,
    required this.label,
    required this.title,
    required this.subtitle,
  });

  final bool compact;
  final IconData icon;
  final String label;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(icon: icon, label: label),
        SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!compact) ...[
              Container(
                width: 3,
                height: 58,
                decoration: BoxDecoration(
                  gradient: AppColors.futuristicGradient,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: compact ? 25 : 32,
                  height: 1.15,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Text(
            subtitle,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: compact ? 13 : 15,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatefulWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
        duration: const Duration(milliseconds: 190),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.surfaceElevated
              : AppColors.surface.withValues(alpha: 0.66),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.16),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(widget.icon, color: AppColors.white, size: 21),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.body,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.5,
                  height: 1.62,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightsCard extends StatefulWidget {
  const _HighlightsCard({required this.highlights});

  final List<String> highlights;

  @override
  State<_HighlightsCard> createState() => _HighlightsCardState();
}

class _HighlightsCardState extends State<_HighlightsCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
        duration: const Duration(milliseconds: 190),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.surfaceElevated
              : AppColors.surface.withValues(alpha: 0.66),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.08),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.accent,
                    size: 19,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Key implementation highlights',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              for (
                var index = 0;
                index < widget.highlights.length;
                index++
              ) ...[
                _BulletText(text: widget.highlights[index]),
                if (index != widget.highlights.length - 1)
                  const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ResponsibilityCard extends StatefulWidget {
  const _ResponsibilityCard({required this.index, required this.text});

  final int index;
  final String text;

  @override
  State<_ResponsibilityCard> createState() => _ResponsibilityCardState();
}

class _ResponsibilityCardState extends State<_ResponsibilityCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final indexLabel = widget.index.toString().padLeft(2, '0');

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
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.surfaceElevated
              : AppColors.surface.withValues(alpha: 0.64),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.07),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.16),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: Text(
                    indexLabel,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.52,
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

class _ScreenshotCard extends StatefulWidget {
  const _ScreenshotCard({
    required this.index,
    required this.imagePath,
    required this.semanticLabel,
  });

  final int index;
  final String imagePath;
  final String semanticLabel;

  @override
  State<_ScreenshotCard> createState() => _ScreenshotCardState();
}

class _ScreenshotCardState extends State<_ScreenshotCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final indexLabel = widget.index.toString().padLeft(2, '0');

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
      child: AnimatedScale(
        scale: _hovered ? 1.012 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _hovered ? AppColors.borderAccent : AppColors.borderStrong,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.10)
                    : AppColors.black.withValues(alpha: 0.22),
                blurRadius: _hovered ? 26 : 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg - 1),
            child: AspectRatio(
              aspectRatio: 0.455,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScale(
                    scale: _hovered ? 1.018 : 1,
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      semanticLabel: widget.semanticLabel,
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(color: AppColors.borderStrong),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Text(
                          indexLabel,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 9,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      height: _hovered ? 3 : 2,
                      decoration: BoxDecoration(
                        gradient: AppColors.futuristicGradient,
                        boxShadow: _hovered
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.28,
                                  ),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
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

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
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
              height: 1.52,
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
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: compact ? 7 : 9,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.30),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: compact ? 11.5 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
        color: AppColors.background.withValues(alpha: 0.70),
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
            Icon(icon, size: 15, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xxs),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
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

class _CaseStudyIndex extends StatelessWidget {
  const _CaseStudyIndex();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'CASE STUDY',
      style: TextStyle(
        color: AppColors.textSubtle,
        fontSize: 9,
        letterSpacing: 1.7,
        fontWeight: FontWeight.w900,
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
