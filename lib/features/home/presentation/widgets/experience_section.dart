import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(
          _isCompact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(switch (windowSize) {
          AppWindowSize.compact => AppSpacing.lg,
          AppWindowSize.medium => AppSpacing.xl,
          AppWindowSize.expanded => AppSpacing.xxl,
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionLabel(
              icon: Icons.work_outline_rounded,
              label: 'EXPERIENCE',
            ),
            SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
            Text(
              'Professional experience building and shipping Flutter products.',
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
                'My professional work focuses on end-to-end Flutter '
                'application delivery, from application structure and UI '
                'implementation to API integration, maintenance, testing, '
                'and production releases.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: _isCompact ? 14 : 16,
                  height: 1.65,
                ),
              ),
            ),
            SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
            _ExperienceCard(compact: _isCompact, expanded: _isExpanded),
          ],
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.compact, required this.expanded});

  final bool compact;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ResponsibilityItem(
          icon: Icons.account_tree_outlined,
          title: 'Flutter architecture',
          description:
              'Own application structure, feature organization, state management, and client-side implementation.',
        ),
        const _ResponsibilityItem(
          icon: Icons.devices_rounded,
          title: 'UI & responsive implementation',
          description:
              'Build production interfaces and responsive experiences for Flutter applications.',
        ),
        const _ResponsibilityItem(
          icon: Icons.api_rounded,
          title: 'API & application logic',
          description:
              'Integrate backend REST APIs and implement networking, state, and client-side business flows.',
        ),
        const _ResponsibilityItem(
          icon: Icons.storage_rounded,
          title: 'Local persistence',
          description:
              'Handle application-side local data, preferences, caching, and persistence requirements.',
        ),
        const _ResponsibilityItem(
          icon: Icons.build_outlined,
          title: 'Maintenance & debugging',
          description:
              'Investigate issues, maintain existing features, test on devices, and deliver production fixes.',
        ),
        const _ResponsibilityItem(
          icon: Icons.rocket_launch_outlined,
          title: 'Android & iOS releases',
          description:
              'Handle Flutter build and production release workflows for Android and iOS applications.',
          showDivider: false,
        ),
      ],
    );

    final roleSummary = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.20),
                ),
              ),
              child: SizedBox(
                width: compact ? 42 : 48,
                height: compact ? 42 : 48,
                child: Icon(
                  Icons.flutter_dash_rounded,
                  color: AppColors.primary,
                  size: compact ? 21 : 24,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Developer',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 19 : 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Medigene IT',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: compact ? 14 : 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: const [
            _MetaChip(
              icon: Icons.calendar_month_outlined,
              label: 'Feb 2023 — Present',
            ),
            _MetaChip(icon: Icons.phone_android_rounded, label: 'Flutter'),
            _MetaChip(icon: Icons.devices_outlined, label: 'Android & iOS'),
          ],
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'Working as the Flutter developer responsible for the mobile '
          'application layer while collaborating with backend developers '
          'who build and provide the APIs.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: compact ? 13.5 : 15,
            height: 1.6,
          ),
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        const _OwnershipBadge(),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: expanded
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: roleSummary),
                  const SizedBox(width: AppSpacing.xxl),
                  Container(width: 1, height: 430, color: AppColors.border),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(flex: 9, child: details),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  roleSummary,
                  SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xxl),
                  const Divider(height: 1, color: AppColors.border),
                  SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xxl),
                  details,
                ],
              ),
      ),
    );
  }
}

class _OwnershipBadge extends StatelessWidget {
  const _OwnershipBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.20)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_outlined, size: 19, color: AppColors.secondary),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Flutter ownership includes architecture, UI, state, API '
                'integration, client logic, local storage, debugging, '
                'testing, maintenance, and release delivery.',
                style: TextStyle(
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

class _ResponsibilityItem extends StatelessWidget {
  const _ResponsibilityItem({
    required this.icon,
    required this.title,
    required this.description,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
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
        color: AppColors.surface.withValues(alpha: 0.85),
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
                fontSize: 12,
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
