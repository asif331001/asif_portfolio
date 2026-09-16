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
            colors: [Color(0xFF0E182A), Color(0xFF080F1D), Color(0xFF040914)],
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
                    icon: Icons.code_rounded,
                    label: 'SKILLS',
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
                          'Flutter technologies used across real production work.',
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
                      'My stack spans Flutter application architecture, '
                      'state management, networking, local persistence, '
                      'third-party integrations, responsive UI, maintenance, '
                      'and production delivery.',
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

                      final spacing = _isCompact
                          ? AppSpacing.md
                          : AppSpacing.lg;

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
                            index < _skillGroups.length;
                            index++
                          )
                            SizedBox(
                              width: cardWidth,
                              child: _SkillGroupCard(
                                index: index,
                                group: _skillGroups[index],
                                compact: _isCompact,
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

class _SkillGroupCard extends StatefulWidget {
  const _SkillGroupCard({
    required this.index,
    required this.group,
    required this.compact,
  });

  final int index;
  final _SkillGroup group;
  final bool compact;

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = widget.compact ? AppRadius.lg : AppRadius.xl;

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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _hovered
                    ? AppColors.surfaceElevated
                    : AppColors.surface.withValues(alpha: 0.76),
                AppColors.backgroundSoft.withValues(alpha: 0.92),
              ],
            ),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: _hovered ? AppColors.borderAccent : AppColors.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: AppColors.secondary.withValues(alpha: 0.06),
                      blurRadius: 34,
                      offset: const Offset(0, 16),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius - 1),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: widget.compact ? 18 : 22,
                  right: widget.compact ? 18 : 22,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: _hovered ? 3 : 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      gradient: AppColors.futuristicGradient,
                      boxShadow: _hovered
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.26,
                                ),
                                blurRadius: 12,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    widget.compact ? AppSpacing.md : AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: AppColors.brandGradient,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.18,
                                  ),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: widget.compact ? 42 : 46,
                              height: widget.compact ? 42 : 46,
                              child: Icon(
                                widget.group.icon,
                                color: AppColors.white,
                                size: widget.compact ? 20 : 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              widget.group.title,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: widget.compact ? 17 : 19,
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
                                style: const TextStyle(
                                  color: AppColors.textSubtle,
                                  fontSize: 9.5,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${widget.group.skills.length} SKILLS',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 8.5,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.compact ? AppSpacing.sm : AppSpacing.md,
                      ),
                      Text(
                        widget.group.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: widget.compact ? 12.5 : 13.5,
                          height: 1.52,
                        ),
                      ),
                      SizedBox(
                        height: widget.compact ? AppSpacing.md : AppSpacing.lg,
                      ),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: [
                          for (final skill in widget.group.skills)
                            _SkillChip(label: skill, compact: widget.compact),
                        ],
                      ),
                    ],
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

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label, required this.compact});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xs : AppSpacing.sm,
          vertical: compact ? 6 : 7,
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
                  fontSize: compact ? 11 : 12,
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
    return const Padding(
      padding: EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '05 / SKILLS',
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
