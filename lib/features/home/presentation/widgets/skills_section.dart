import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(icon: Icons.code_rounded, label: 'SKILLS'),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Flutter technologies used across real production work.',
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
            'My stack spans Flutter application architecture, state '
            'management, networking, local persistence, third-party '
            'integrations, responsive UI, maintenance, and production '
            'delivery.',
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

            final spacing = _isCompact ? AppSpacing.md : AppSpacing.lg;

            final cardWidth =
                (constraints.maxWidth - (spacing * (columnCount - 1))) /
                columnCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final group in _skillGroups)
                  SizedBox(
                    width: cardWidth,
                    child: _SkillGroupCard(group: group, compact: _isCompact),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group, required this.compact});

  final _SkillGroup group;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: SizedBox(
                    width: compact ? 40 : 44,
                    height: compact ? 40 : 44,
                    child: Icon(
                      group.icon,
                      color: AppColors.primary,
                      size: compact ? 20 : 22,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    group.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 17 : 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            Text(
              group.description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 12.5 : 13.5,
                height: 1.5,
              ),
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final skill in group.skills)
                  _SkillChip(label: skill, compact: compact),
              ],
            ),
          ],
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
        color: AppColors.background.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xs : AppSpacing.sm,
          vertical: compact ? 6 : 7,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: compact ? 11 : 12,
            fontWeight: FontWeight.w600,
          ),
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
