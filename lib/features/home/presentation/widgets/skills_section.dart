import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

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

    final totalSkills = _skillGroups.fold<int>(
      0,
      (total, group) => total + group.skills.length,
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
                    Color(0xFF0E182A),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionLabel(
                    icon: Icons.code_rounded,
                    label: 'SKILLS / STACK',
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
                  Text(
                    'A Flutter stack shaped by production application work.',
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
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Text(
                      'My day-to-day stack spans Flutter application '
                      'architecture, state management, networking, local '
                      'persistence, platform integrations, responsive UI, '
                      'maintenance, and production delivery.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.66),
                        fontSize: bodySize,
                        height: 1.66,
                      ),
                    ),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
                  _SkillOverview(compact: _isCompact, totalSkills: totalSkills),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  if (_isExpanded)
                    const _ExpandedSkillsLayout()
                  else
                    _ResponsiveSkillsLayout(compact: _isCompact),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillOverview extends StatelessWidget {
  const _SkillOverview({required this.compact, required this.totalSkills});

  final bool compact;
  final int totalSkills;

  @override
  Widget build(BuildContext context) {
    final items = [
      const _SkillOverviewData(
        icon: Icons.flutter_dash_rounded,
        value: 'Flutter',
        label: 'Primary application stack',
      ),
      _SkillOverviewData(
        icon: Icons.dashboard_customize_outlined,
        value: '${_skillGroups.length} Areas',
        label: 'Capability groups',
      ),
      _SkillOverviewData(
        icon: Icons.memory_rounded,
        value: '$totalSkills Items',
        label: 'Tools & technologies',
      ),
      const _SkillOverviewData(
        icon: Icons.devices_outlined,
        value: 'Android + iOS',
        label: 'Production delivery',
      ),
    ];

    if (compact) {
      return Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _SkillOverviewCard(data: items[index]),
            if (index != items.length - 1)
              const SizedBox(height: AppSpacing.xs),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          Expanded(child: _SkillOverviewCard(data: items[index])),
          if (index != items.length - 1) const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _SkillOverviewData {
  const _SkillOverviewData({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

class _SkillOverviewCard extends StatelessWidget {
  const _SkillOverviewCard({required this.data});

  final _SkillOverviewData data;

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

class _ExpandedSkillsLayout extends StatelessWidget {
  const _ExpandedSkillsLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: _SkillGroupCard(index: 0, group: _skillGroups.first),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          flex: 13,
          child: LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.md;
              final width = (constraints.maxWidth - gap) / 2;

              final secondaryGroups = _skillGroups.skip(1).toList();

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var index = 0; index < secondaryGroups.length; index++)
                    SizedBox(
                      width: width,
                      child: _SkillGroupCard(
                        index: index + 1,
                        group: secondaryGroups[index],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ResponsiveSkillsLayout extends StatelessWidget {
  const _ResponsiveSkillsLayout({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Column(
        children: [
          _SkillGroupCard(index: 0, group: _skillGroups.first),
          const SizedBox(height: AppSpacing.md),
          for (var index = 1; index < _skillGroups.length; index++) ...[
            _SkillGroupCard(index: index, group: _skillGroups[index]),
            if (index != _skillGroups.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.lg;
        final width = (constraints.maxWidth - gap) / 2;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var index = 0; index < _skillGroups.length; index++)
              SizedBox(
                width: width,
                child: _SkillGroupCard(
                  index: index,
                  group: _skillGroups[index],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SkillGroupCard extends StatefulWidget {
  const _SkillGroupCard({required this.index, required this.group});

  final int index;
  final _SkillGroup group;

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final dense =
        MediaQuery.sizeOf(context).width <= AppBreakpoints.ultraNarrowMax;

    final indexLabel = (widget.index + 1).toString().padLeft(2, '0');

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
        duration: const Duration(milliseconds: 190),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 190),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(dense ? 12 : AppSpacing.lg),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withValues(alpha: isDark ? 0.075 : 0.055)
                : colors.surface.withValues(alpha: isDark ? 0.70 : 0.90),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.42)
                  : colors.outline.withValues(alpha: 0.68),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.17),
                      ),
                    ),
                    child: SizedBox(
                      width: dense ? 38 : 44,
                      height: dense ? 38 : 44,
                      child: Icon(
                        widget.group.icon,
                        size: dense ? 18 : 21,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.group.title,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: dense ? 15 : 18,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        indexLabel,
                        style: TextStyle(
                          color: colors.onSurface.withValues(alpha: 0.28),
                          fontSize: 9.5,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${widget.group.skills.length} ITEMS',
                        style: TextStyle(
                          color: colors.onSurface.withValues(alpha: 0.40),
                          fontSize: 8.5,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.group.description,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.57),
                  fontSize: dense ? 11 : 12.5,
                  height: 1.52,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final skill in widget.group.skills)
                    _SkillChip(label: skill),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.64),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.outline.withValues(alpha: 0.60)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.66),
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

class _SkillGroup {
  const _SkillGroup({
    required this.icon,
    required this.title,
    required this.description,
    required this.skills,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> skills;
}

const List<_SkillGroup> _skillGroups = [
  _SkillGroup(
    icon: Icons.flutter_dash_rounded,
    title: 'Core Flutter',
    description:
        'Core technologies used to build and maintain cross-platform mobile applications.',
    skills: ['Flutter', 'Dart', 'Responsive UI', 'Adaptive UI', 'Material UI'],
  ),
  _SkillGroup(
    icon: Icons.account_tree_outlined,
    title: 'State & Architecture',
    description:
        'Application organization and state-management approaches used across different products.',
    skills: [
      'Riverpod',
      'GetX',
      'Provider',
      'ChangeNotifier',
      'MVVM',
      'Repository Pattern',
      'Layered Architecture',
    ],
  ),
  _SkillGroup(
    icon: Icons.cloud_outlined,
    title: 'Networking & Data',
    description:
        'API integration and persistence technologies for connected and local-first application flows.',
    skills: ['REST API', 'Dio', 'HTTP', 'Drift', 'SQLite', 'SharedPreferences'],
  ),
  _SkillGroup(
    icon: Icons.extension_outlined,
    title: 'Platform & Integrations',
    description:
        'Production integrations used for messaging, secured video, web content, media, and files.',
    skills: [
      'Firebase',
      'FCM',
      'VDoCipher',
      'WebView',
      'Deep Links',
      'YouTube',
      'Audio',
      'PDF',
      'File Handling',
    ],
  ),
  _SkillGroup(
    icon: Icons.rocket_launch_outlined,
    title: 'Delivery & Quality',
    description:
        'Day-to-day production responsibilities beyond feature implementation.',
    skills: [
      'Android Releases',
      'iOS Releases',
      'Device Testing',
      'Debugging',
      'Maintenance',
      'Production Fixes',
    ],
  ),
];

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
        '05 / SKILLS',
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
