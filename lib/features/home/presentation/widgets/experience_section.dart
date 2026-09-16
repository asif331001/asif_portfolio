import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

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
                    icon: Icons.work_outline_rounded,
                    label: 'EXPERIENCE',
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
                          'Professional experience building and shipping Flutter products.',
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
                      'My professional work focuses on end-to-end Flutter '
                      'application delivery, from application structure and '
                      'UI implementation to API integration, maintenance, '
                      'testing, and production releases.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: _isCompact ? 14 : 16,
                        height: 1.68,
                      ),
                    ),
                  ),
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  _ExperienceTimeline(
                    compact: _isCompact,
                    expanded: _isExpanded,
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

class _ExperienceTimeline extends StatelessWidget {
  const _ExperienceTimeline({required this.compact, required this.expanded});

  final bool compact;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact) ...[
          SizedBox(
            width: 34,
            child: Column(
              children: [
                const SizedBox(height: 18),
                const _TimelineNode(),
                Container(
                  width: 1,
                  height: expanded ? 500 : 320,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.65),
                        AppColors.secondary.withValues(alpha: 0.28),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: _ExperienceCard(compact: compact, expanded: expanded),
        ),
      ],
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.34),
            blurRadius: 18,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: const SizedBox(
            width: 12,
            height: 12,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(width: 4, height: 4),
              ),
            ),
          ),
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
    final roleSummary = _RoleSummary(compact: compact);

    final responsibilities = _ResponsibilityGrid(compact: compact);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.20),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(top: 0, left: 24, right: 24, child: _TopAccent()),
          Padding(
            padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
            child: expanded
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: roleSummary),
                      const SizedBox(width: AppSpacing.xxl),
                      Container(
                        width: 1,
                        constraints: const BoxConstraints(minHeight: 500),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.borderStrong,
                              AppColors.border,
                              AppColors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxl),
                      Expanded(flex: 10, child: responsibilities),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      roleSummary,
                      SizedBox(
                        height: compact ? AppSpacing.lg : AppSpacing.xxl,
                      ),
                      const Divider(),
                      SizedBox(
                        height: compact ? AppSpacing.lg : AppSpacing.xxl,
                      ),
                      responsibilities,
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _RoleSummary extends StatelessWidget {
  const _RoleSummary({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: compact ? 46 : 52,
              height: compact ? 46 : 52,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: Image.asset(
                  'assets/medigeneit_logo.jpeg',
                  fit: BoxFit.contain,
                  semanticLabel: 'Medigene IT logo',
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
                      fontSize: compact ? 20 : 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return AppColors.brandGradient.createShader(bounds);
                    },
                    child: Text(
                      'Medigene IT',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: compact ? 14 : 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        const _CurrentRoleBadge(),
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
            height: 1.62,
          ),
        ),
        SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
        const _OwnershipBadge(),
      ],
    );
  }
}

class _CurrentRoleBadge extends StatelessWidget {
  const _CurrentRoleBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.20)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StatusDot(),
            SizedBox(width: AppSpacing.xs),
            Text(
              'CURRENT ROLE',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.40),
            blurRadius: 8,
          ),
        ],
      ),
      child: const SizedBox(width: 7, height: 7),
    );
  }
}

class _OwnershipBadge extends StatelessWidget {
  const _OwnershipBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.20)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_outlined, size: 19, color: AppColors.accent),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Flutter ownership includes architecture, UI, state, API '
                'integration, client logic, local storage, debugging, '
                'testing, maintenance, and release delivery.',
                style: TextStyle(
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

class _ResponsibilityGrid extends StatelessWidget {
  const _ResponsibilityGrid({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Core responsibilities',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.border),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                child: Text(
                  '06 AREAS',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 9,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final useTwoColumns = !compact && constraints.maxWidth >= 520;

            if (!useTwoColumns) {
              return const Column(
                children: [
                  _ResponsibilityCard(
                    index: '01',
                    icon: Icons.account_tree_outlined,
                    title: 'Flutter architecture',
                    description:
                        'Own application structure, feature organization, state management, and client-side implementation.',
                  ),
                  SizedBox(height: AppSpacing.xs),
                  _ResponsibilityCard(
                    index: '02',
                    icon: Icons.devices_rounded,
                    title: 'UI & responsive implementation',
                    description:
                        'Build production interfaces and responsive experiences for Flutter applications.',
                  ),
                  SizedBox(height: AppSpacing.xs),
                  _ResponsibilityCard(
                    index: '03',
                    icon: Icons.api_rounded,
                    title: 'API & application logic',
                    description:
                        'Integrate backend REST APIs and implement networking, state, and client-side business flows.',
                  ),
                  SizedBox(height: AppSpacing.xs),
                  _ResponsibilityCard(
                    index: '04',
                    icon: Icons.storage_rounded,
                    title: 'Local persistence',
                    description:
                        'Handle application-side local data, preferences, caching, and persistence requirements.',
                  ),
                  SizedBox(height: AppSpacing.xs),
                  _ResponsibilityCard(
                    index: '05',
                    icon: Icons.build_outlined,
                    title: 'Maintenance & debugging',
                    description:
                        'Investigate issues, maintain existing features, test on devices, and deliver production fixes.',
                  ),
                  SizedBox(height: AppSpacing.xs),
                  _ResponsibilityCard(
                    index: '06',
                    icon: Icons.rocket_launch_outlined,
                    title: 'Android & iOS releases',
                    description:
                        'Handle Flutter build and production release workflows for Android and iOS applications.',
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
                  child: const _ResponsibilityCard(
                    index: '01',
                    icon: Icons.account_tree_outlined,
                    title: 'Flutter architecture',
                    description:
                        'Own application structure, feature organization, state management, and client-side implementation.',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const _ResponsibilityCard(
                    index: '02',
                    icon: Icons.devices_rounded,
                    title: 'UI & responsive implementation',
                    description:
                        'Build production interfaces and responsive experiences for Flutter applications.',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const _ResponsibilityCard(
                    index: '03',
                    icon: Icons.api_rounded,
                    title: 'API & application logic',
                    description:
                        'Integrate backend REST APIs and implement networking, state, and client-side business flows.',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const _ResponsibilityCard(
                    index: '04',
                    icon: Icons.storage_rounded,
                    title: 'Local persistence',
                    description:
                        'Handle application-side local data, preferences, caching, and persistence requirements.',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const _ResponsibilityCard(
                    index: '05',
                    icon: Icons.build_outlined,
                    title: 'Maintenance & debugging',
                    description:
                        'Investigate issues, maintain existing features, test on devices, and deliver production fixes.',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const _ResponsibilityCard(
                    index: '06',
                    icon: Icons.rocket_launch_outlined,
                    title: 'Android & iOS releases',
                    description:
                        'Handle Flutter build and production release workflows for Android and iOS applications.',
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

class _ResponsibilityCard extends StatefulWidget {
  const _ResponsibilityCard({
    required this.index,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String index;
  final IconData icon;
  final String title;
  final String description;

  @override
  State<_ResponsibilityCard> createState() => _ResponsibilityCardState();
}

class _ResponsibilityCardState extends State<_ResponsibilityCard> {
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
              : AppColors.surface.withValues(alpha: 0.62),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered ? AppColors.borderAccent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: _hovered ? 0.18 : 0.10,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: _hovered ? 0.28 : 0.14,
                      ),
                    ),
                  ),
                  child: Icon(widget.icon, size: 17, color: AppColors.primary),
                ),
                const Spacer(),
                Text(
                  widget.index,
                  style: const TextStyle(
                    color: AppColors.textSubtle,
                    fontSize: 9.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.5,
                height: 1.46,
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
        color: AppColors.surface.withValues(alpha: 0.82),
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
            Icon(icon, size: 14, color: AppColors.primary),
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
        '03 / EXPERIENCE',
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
