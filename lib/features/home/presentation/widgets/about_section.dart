import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';

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
                'I build Flutter products from architecture to production release.',
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
        Text(
          'I am a Mobile Application Developer specializing in Flutter, '
          'with 3+ years of professional experience building and maintaining '
          'real-world applications for Android and iOS.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.68,
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
            height: 1.68,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _OwnershipHighlights(),
      ],
    );

    final capabilities = _CapabilityPanel(compact: _isCompact);

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
            colors: [Color(0xFF0E182A), Color(0xFF080F1E), Color(0xFF050A15)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.24),
              blurRadius: 34,
              offset: const Offset(0, 16),
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
              child: _isExpanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 11, child: introduction),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 10, child: capabilities),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        introduction,
                        SizedBox(
                          height: _isCompact ? AppSpacing.lg : AppSpacing.xxl,
                        ),
                        capabilities,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnershipHighlights extends StatelessWidget {
  const _OwnershipHighlights();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: const [
        _OwnershipChip(
          icon: Icons.layers_outlined,
          label: 'Flutter Application Layer',
        ),
        _OwnershipChip(
          icon: Icons.devices_outlined,
          label: 'Android & iOS Delivery',
        ),
        _OwnershipChip(
          icon: Icons.build_circle_outlined,
          label: 'Production Maintenance',
        ),
      ],
    );
  }
}

class _OwnershipChip extends StatelessWidget {
  const _OwnershipChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.primary),
            const SizedBox(width: 7),
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
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
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
                  ),
                  child: const SizedBox(
                    width: 42,
                    height: 42,
                    child: Icon(
                      Icons.dashboard_customize_outlined,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter product ownership',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: compact ? 17 : 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Core areas I handle across application development.',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: compact ? 11.5 : 12.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final useTwoColumns = !compact && constraints.maxWidth >= 460;

                if (!useTwoColumns) {
                  return const Column(
                    children: [
                      _CapabilityCard(
                        icon: Icons.account_tree_outlined,
                        title: 'Architecture & State',
                        description:
                            'Application structure, feature organization, and state management.',
                      ),
                      SizedBox(height: AppSpacing.xs),
                      _CapabilityCard(
                        icon: Icons.devices_rounded,
                        title: 'Responsive UI',
                        description:
                            'Adaptive Flutter interfaces across different screen sizes.',
                      ),
                      SizedBox(height: AppSpacing.xs),
                      _CapabilityCard(
                        icon: Icons.api_rounded,
                        title: 'API Integration',
                        description:
                            'REST APIs, authentication flows, networking, and client logic.',
                      ),
                      SizedBox(height: AppSpacing.xs),
                      _CapabilityCard(
                        icon: Icons.storage_rounded,
                        title: 'Local Data',
                        description:
                            'Local persistence, caching, preferences, and offline-oriented data.',
                      ),
                      SizedBox(height: AppSpacing.xs),
                      _CapabilityCard(
                        icon: Icons.bug_report_outlined,
                        title: 'Quality & Maintenance',
                        description:
                            'Debugging, device testing, production fixes, and ongoing maintenance.',
                      ),
                      SizedBox(height: AppSpacing.xs),
                      _CapabilityCard(
                        icon: Icons.rocket_launch_outlined,
                        title: 'Production Releases',
                        description:
                            'Android and iOS build, release, and store delivery workflows.',
                      ),
                    ],
                  );
                }

                const gap = AppSpacing.xs;
                final cardWidth = (constraints.maxWidth - gap) / 2;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.account_tree_outlined,
                        title: 'Architecture & State',
                        description:
                            'Application structure, feature organization, and state management.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.devices_rounded,
                        title: 'Responsive UI',
                        description:
                            'Adaptive Flutter interfaces across different screen sizes.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.api_rounded,
                        title: 'API Integration',
                        description:
                            'REST APIs, authentication flows, networking, and client logic.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.storage_rounded,
                        title: 'Local Data',
                        description:
                            'Local persistence, caching, preferences, and offline-oriented data.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.bug_report_outlined,
                        title: 'Quality & Maintenance',
                        description:
                            'Debugging, device testing, production fixes, and ongoing maintenance.',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: const _CapabilityCard(
                        icon: Icons.rocket_launch_outlined,
                        title: 'Production Releases',
                        description:
                            'Android and iOS build, release, and store delivery workflows.',
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CapabilityCard extends StatefulWidget {
  const _CapabilityCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.surfaceElevated
              : AppColors.surface.withValues(alpha: 0.66),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.18)
                    : AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.primary.withValues(
                    alpha: _hovered ? 0.28 : 0.14,
                  ),
                ),
              ),
              child: Icon(widget.icon, size: 17, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5,
                      height: 1.45,
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
        '02 / PROFILE',
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
