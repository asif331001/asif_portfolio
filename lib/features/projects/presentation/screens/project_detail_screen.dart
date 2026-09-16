import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_controller.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
                    AppColors.background,
                    AppColors.backgroundSoft,
                    AppColors.background,
                  ]
                : const [
                    AppColors.lightBackground,
                    AppColors.lightBackgroundSoft,
                    AppColors.lightBackground,
                  ],
          ),
        ),
        child: SafeArea(
          child: ResponsiveLayout(
            builder: (context, windowSize, _) {
              final compact = windowSize == AppWindowSize.compact;

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
                    compact: compact,
                    horizontalPadding: horizontalPadding,
                    onBackPressed: () {
                      _goBack(context);
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: compact ? AppSpacing.md : AppSpacing.xxl,
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
                              _ProjectClosingCard(
                                project: project,
                                compact: compact,
                                onBackPressed: () {
                                  _goBack(context);
                                },
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(
          alpha: isDark ? 0.94 : 0.96,
        ),
        border: Border(
          bottom: BorderSide(color: colors.outline.withValues(alpha: 0.58)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.14 : 0.04),
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
                  if (!compact) ...[
                    const _HeaderBrand(),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  const _ThemeToggle(),
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
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(_active ? -2 : 0, 0, 0),
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.09)
            : colors.surface.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _active
              ? AppColors.primary.withValues(alpha: 0.38)
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
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  widget.compact ? 'Back' : 'Back to Portfolio',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.68),
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
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.16),
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
                  color: colors.onSurface,
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

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle();

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

    return Semantics(
      button: true,
      label: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      child: Tooltip(
        message: isDark ? 'Light theme' : 'Dark theme',
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
            scale: _hovered ? 1.05 : 1,
            duration: const Duration(milliseconds: 170),
            curve: Curves.easeOutCubic,
            child: InkWell(
              onTap: () {
                ThemeController.instance.toggleTheme();
              },
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.primary.withValues(alpha: 0.09)
                      : colors.surface.withValues(alpha: 0.60),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.38)
                        : colors.outline.withValues(alpha: 0.62),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween<double>(
                        begin: 0.75,
                        end: 1,
                      ).animate(animation),
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    key: ValueKey(isDark),
                    size: 19,
                    color: AppColors.primary,
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

class _ProjectHero extends StatelessWidget {
  const _ProjectHero({required this.project, required this.windowSize});

  final PortfolioProject project;
  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.apps_rounded,
          label: 'PROJECT / CASE STUDY',
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        _ProjectLogos(project: project, compact: _isCompact),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          project.title,
          style: TextStyle(
            color: colors.onSurface,
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
            color: colors.onSurface.withValues(alpha: 0.64),
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
              label: 'Application Layer',
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
            Positioned(
              top: -170,
              left: -140,
              child: _AmbientOrb(
                size: 370,
                color: AppColors.primary,
                opacity: isDark ? 0.075 : 0.035,
              ),
            ),
            Positioned(
              right: -160,
              bottom: -190,
              child: _AmbientOrb(
                size: 390,
                color: AppColors.secondary,
                opacity: isDark ? 0.085 : 0.030,
              ),
            ),
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
        scale: _hovered ? 1.008 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(
              widget.compact ? AppRadius.lg : AppRadius.xl,
            ),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.46)
                  : colors.outline.withValues(alpha: 0.72),
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.11)
                    : AppColors.black.withValues(alpha: isDark ? 0.14 : 0.04),
                blurRadius: _hovered ? 28 : 18,
                offset: const Offset(0, 10),
              ),
            ],
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
                          AppColors.background.withValues(alpha: 0.32),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.sm,
                    bottom: AppSpacing.sm,
                    child: _GraphicBadge(label: widget.project.platformLabel),
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

class _GraphicBadge extends StatelessWidget {
  const _GraphicBadge({required this.label});

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
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
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
          Container(
            width: compact ? 58 : 68,
            height: compact ? 58 : 68,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.18),
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
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.10),
            AppColors.primary.withValues(alpha: 0.045),
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
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.60),
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
            title: 'How this product is structured.',
            subtitle:
                'Architecture and implementation highlights from the Flutter application.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
          LayoutBuilder(
            builder: (context, constraints) {
              if (_isCompact) {
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
            title: 'Flutter engineering ownership.',
            subtitle:
                'Application-side responsibilities handled across this product.',
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
            title: 'Production technology stack.',
            subtitle:
                'Frameworks, state tools, networking, integrations, and persistence technologies used in this application.',
          ),
          SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
          _TechnologyMatrix(
            technologies: project.technologies,
            compact: _isCompact,
          ),
        ],
      ),
    );
  }
}

class _TechnologyMatrix extends StatelessWidget {
  const _TechnologyMatrix({required this.technologies, required this.compact});

  final List<String> technologies;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (var index = 0; index < technologies.length; index++)
          _TechnologyChip(
            index: index + 1,
            label: technologies[index],
            compact: compact,
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
    return _SectionShell(
      compact: _isCompact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailSectionHeader(
            compact: _isCompact,
            icon: Icons.phone_android_rounded,
            label: 'APP SCREENS',
            title: 'Inside the product.',
            subtitle:
                'Real application screens showing the product interface and user workflows.',
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

              final width =
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
                      width: width,
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        compact ? AppRadius.lg : AppRadius.xl,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.lg : AppRadius.xl,
          ),
          border: Border.all(
            color: colors.outline.withValues(alpha: isDark ? 0.88 : 0.72),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF0B1526),
                    Color(0xFF080F1D),
                    Color(0xFF050A15),
                  ]
                : const [
                    Color(0xFFFFFFFF),
                    Color(0xFFF8FAFF),
                    Color(0xFFF0F4FA),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.18 : 0.05),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -180,
              right: -160,
              child: _AmbientOrb(
                size: 360,
                color: AppColors.secondary,
                opacity: isDark ? 0.045 : 0.025,
              ),
            ),
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
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(icon: icon, label: label),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: compact ? 25 : 32,
            height: 1.14,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Text(
            subtitle,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.57),
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.07)
              : colors.surface.withValues(alpha: isDark ? 0.66 : 0.88),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.42)
                : colors.outline.withValues(alpha: 0.65),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(AppRadius.md),
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
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.body,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.60),
                fontSize: 13.5,
                height: 1.62,
              ),
            ),
          ],
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.secondary.withValues(alpha: 0.07)
              : colors.surface.withValues(alpha: isDark ? 0.66 : 0.88),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _hovered
                ? AppColors.secondary.withValues(alpha: 0.38)
                : colors.outline.withValues(alpha: 0.65),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.brandGradient,
                  ),
                  child: SizedBox(
                    width: 38,
                    height: 38,
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      size: 18,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Implementation highlights',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            for (var index = 0; index < widget.highlights.length; index++) ...[
              _BulletText(text: widget.highlights[index]),
              if (index != widget.highlights.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.07)
              : colors.surface.withValues(alpha: isDark ? 0.64 : 0.88),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.40)
                : colors.outline.withValues(alpha: 0.62),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                shape: BoxShape.circle,
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
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.60),
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.46)
                  : colors.outline.withValues(alpha: 0.72),
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.10)
                    : AppColors.black.withValues(alpha: isDark ? 0.18 : 0.04),
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
                        color: AppColors.background.withValues(alpha: 0.84),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.14),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Text(
                          indexLabel,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
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
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(
            Icons.check_circle_rounded,
            size: 15,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.60),
              fontSize: 13,
              height: 1.52,
            ),
          ),
        ),
      ],
    );
  }
}

class _TechnologyChip extends StatefulWidget {
  const _TechnologyChip({
    required this.index,
    required this.label,
    required this.compact,
  });

  final int index;
  final String label;
  final bool compact;

  @override
  State<_TechnologyChip> createState() => _TechnologyChipState();
}

class _TechnologyChipState extends State<_TechnologyChip> {
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
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? AppSpacing.sm : AppSpacing.md,
          vertical: widget.compact ? 7 : 9,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.09)
              : colors.surface.withValues(alpha: 0.62),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.40)
                : colors.outline.withValues(alpha: 0.60),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.index.toString().padLeft(2, '0'),
              style: TextStyle(
                color: AppColors.primary.withValues(alpha: 0.70),
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.66),
                  fontSize: widget.compact ? 11.5 : 13,
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
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.outline.withValues(alpha: 0.62)),
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
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.64),
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

class _ProjectClosingCard extends StatelessWidget {
  const _ProjectClosingCard({
    required this.project,
    required this.compact,
    required this.onBackPressed,
  });

  final PortfolioProject project;
  final bool compact;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.primary.withValues(alpha: 0.14),
                  AppColors.secondary.withValues(alpha: 0.09),
                  colors.surface.withValues(alpha: 0.82),
                ]
              : [
                  AppColors.primary.withValues(alpha: 0.09),
                  AppColors.secondary.withValues(alpha: 0.045),
                  colors.surface,
                ],
        ),
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.lg : AppSpacing.xl),
        child: compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ClosingContent(project: project),
                  const SizedBox(height: AppSpacing.lg),
                  _ClosingButton(onPressed: onBackPressed),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _ClosingContent(project: project)),
                  const SizedBox(width: AppSpacing.xxl),
                  _ClosingButton(onPressed: onBackPressed),
                ],
              ),
      ),
    );
  }
}

class _ClosingContent extends StatelessWidget {
  const _ClosingContent({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PROJECT COMPLETE',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 9.5,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          project.title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Return to the portfolio to explore the other Flutter products.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.54),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _ClosingButton extends StatefulWidget {
  const _ClosingButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_ClosingButton> createState() => _ClosingButtonState();
}

class _ClosingButtonState extends State<_ClosingButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _hovered ? 1.02 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: _hovered ? 0.22 : 0.15,
              ),
              blurRadius: 20,
              offset: const Offset(0, 8),
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
            borderRadius: BorderRadius.circular(AppRadius.md),
            mouseCursor: SystemMouseCursors.click,
            hoverColor: AppColors.transparent,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    size: 17,
                    color: AppColors.white,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
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
    final colors = Theme.of(context).colorScheme;

    return Text(
      'CASE STUDY',
      style: TextStyle(
        color: colors.onSurface.withValues(alpha: 0.28),
        fontSize: 9,
        letterSpacing: 1.7,
        fontWeight: FontWeight.w900,
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
