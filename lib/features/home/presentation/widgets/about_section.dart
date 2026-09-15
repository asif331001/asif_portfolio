import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.person_outline_rounded,
          label: 'ABOUT ME',
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'I build Flutter products from architecture to production release.',
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
        Text(
          'I am a Mobile Application Developer specializing in Flutter, '
          'with 3+ years of professional experience building and maintaining '
          'real-world applications for Android and iOS.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.65,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'My work covers Flutter architecture, responsive UI, state '
          'management, REST API integration, local persistence, debugging, '
          'device testing, maintenance, and production release workflows. '
          'I work closely with backend developers who provide the APIs while '
          'I own the Flutter application layer and client-side delivery.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.65,
          ),
        ),
      ],
    );

    final capabilities = _CapabilityPanel(compact: _isCompact);

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
        child: _isExpanded
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 11, child: introduction),
                  const SizedBox(width: AppSpacing.xxxl),
                  Expanded(flex: 9, child: capabilities),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  introduction,
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  capabilities,
                ],
              ),
      ),
    );
  }
}

class _CapabilityPanel extends StatelessWidget {
  const _CapabilityPanel({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter product ownership',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: compact ? 17 : 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Core areas I handle across application development.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 12.5 : 14,
                height: 1.45,
              ),
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            const _CapabilityItem(
              icon: Icons.account_tree_outlined,
              title: 'Architecture & State',
              description:
                  'Application structure, feature organization, and state management.',
            ),
            const _CapabilityItem(
              icon: Icons.devices_rounded,
              title: 'Responsive UI',
              description:
                  'Adaptive Flutter interfaces across different screen sizes.',
            ),
            const _CapabilityItem(
              icon: Icons.api_rounded,
              title: 'API Integration',
              description:
                  'REST APIs, authentication flows, networking, and client logic.',
            ),
            const _CapabilityItem(
              icon: Icons.storage_rounded,
              title: 'Local Data',
              description:
                  'Local persistence, caching, preferences, and offline-oriented data.',
            ),
            const _CapabilityItem(
              icon: Icons.bug_report_outlined,
              title: 'Quality & Maintenance',
              description:
                  'Debugging, device testing, production fixes, and ongoing maintenance.',
            ),
            const _CapabilityItem(
              icon: Icons.rocket_launch_outlined,
              title: 'Production Releases',
              description:
                  'Android and iOS build, release, and store delivery workflows.',
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _CapabilityItem extends StatelessWidget {
  const _CapabilityItem({
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
                color: AppColors.primary.withValues(alpha: 0.10),
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
                      height: 1.4,
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
