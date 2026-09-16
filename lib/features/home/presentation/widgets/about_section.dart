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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final introduction = _AboutIntroduction(windowSize: windowSize);

    final capabilityPanel = _CapabilityPanel(compact: _isCompact);

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
            Positioned.fill(
              child: AnimatedSectionBackground(
                compact: _isCompact,
                intensity: isDark ? 1.15 : 0.48,
              ),
            ),
            Positioned(
              top: 0,
              right: _isCompact ? 20 : 36,
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
                        Expanded(flex: 10, child: introduction),
                        const SizedBox(width: AppSpacing.xxxl),
                        Expanded(flex: 11, child: capabilityPanel),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        introduction,
                        SizedBox(
                          height: _isCompact ? AppSpacing.lg : AppSpacing.xxl,
                        ),
                        capabilityPanel,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutIntroduction extends StatelessWidget {
  const _AboutIntroduction({required this.windowSize});

  final AppWindowSize windowSize;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.person_outline_rounded,
          label: 'ABOUT / PROFILE',
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'Flutter ownership from product interface to production release.',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: switch (windowSize) {
              AppWindowSize.compact => 28,
              AppWindowSize.medium => 35,
              AppWindowSize.expanded => 42,
            },
            height: 1.11,
            letterSpacing: -0.9,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'I am a Mobile Application Developer specializing in Flutter, '
          'with 3+ years of professional experience building and maintaining '
          'real-world applications for Android and iOS.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.70),
            fontSize: _isCompact ? 14 : 16,
            height: 1.66,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'My work covers Flutter architecture, responsive UI, state '
          'management, REST API integration, local persistence, debugging, '
          'device testing, maintenance, and production release workflows. '
          'I collaborate with backend developers who build the APIs while '
          'I own the Flutter application layer and client-side delivery.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.62),
            fontSize: _isCompact ? 14 : 16,
            height: 1.66,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _ProfileSignals(),
      ],
    );
  }
}

class _ProfileSignals extends StatelessWidget {
  const _ProfileSignals();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;

        final items = const [
          _ProfileSignalData(
            icon: Icons.layers_outlined,
            value: 'Flutter',
            label: 'Application ownership',
          ),
          _ProfileSignalData(
            icon: Icons.devices_outlined,
            value: 'Android + iOS',
            label: 'Production delivery',
          ),
          _ProfileSignalData(
            icon: Icons.schedule_rounded,
            value: '3+ Years',
            label: 'Professional experience',
          ),
        ];

        if (compact) {
          return Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                _ProfileSignal(data: items[index]),
                if (index != items.length - 1)
                  const SizedBox(height: AppSpacing.xs),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              Expanded(child: _ProfileSignal(data: items[index])),
              if (index != items.length - 1)
                const SizedBox(width: AppSpacing.xs),
            ],
          ],
        );
      },
    );
  }
}

class _ProfileSignalData {
  const _ProfileSignalData({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

class _ProfileSignal extends StatefulWidget {
  const _ProfileSignal({required this.data});

  final _ProfileSignalData data;

  @override
  State<_ProfileSignal> createState() => _ProfileSignalState();
}

class _ProfileSignalState extends State<_ProfileSignal> {
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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.08)
              : colors.surface.withValues(alpha: 0.56),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.42)
                : colors.outline.withValues(alpha: 0.70),
          ),
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SizedBox(
                width: 38,
                height: 38,
                child: Icon(
                  widget.data.icon,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.value,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.data.label,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.48),
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

class _CapabilityPanel extends StatelessWidget {
  const _CapabilityPanel({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: isDark ? 0.74 : 0.88),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outline.withValues(alpha: 0.82)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.18 : 0.06),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CapabilityHeader(compact: compact),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            const _OwnershipPipeline(),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final twoColumns = !compact && constraints.maxWidth >= 460;

                const items = [
                  _CapabilityData(
                    icon: Icons.account_tree_outlined,
                    title: 'Architecture & State',
                    description:
                        'Application structure, feature organization, and state management.',
                  ),
                  _CapabilityData(
                    icon: Icons.devices_rounded,
                    title: 'Responsive UI',
                    description:
                        'Adaptive Flutter interfaces across screen sizes and platforms.',
                  ),
                  _CapabilityData(
                    icon: Icons.api_rounded,
                    title: 'API Integration',
                    description:
                        'REST APIs, authentication, networking, and client-side workflows.',
                  ),
                  _CapabilityData(
                    icon: Icons.storage_rounded,
                    title: 'Local Data',
                    description:
                        'Persistence, caching, preferences, and offline-oriented data.',
                  ),
                  _CapabilityData(
                    icon: Icons.bug_report_outlined,
                    title: 'Quality & Maintenance',
                    description:
                        'Debugging, device testing, production fixes, and ongoing maintenance.',
                  ),
                  _CapabilityData(
                    icon: Icons.rocket_launch_outlined,
                    title: 'Production Releases',
                    description:
                        'Android and iOS build, signing, store submission, and release workflows.',
                  ),
                ];

                if (!twoColumns) {
                  return Column(
                    children: [
                      for (var index = 0; index < items.length; index++) ...[
                        _CapabilityCard(data: items[index]),
                        if (index != items.length - 1)
                          const SizedBox(height: AppSpacing.xs),
                      ],
                    ],
                  );
                }

                const gap = AppSpacing.xs;

                final width = (constraints.maxWidth - gap) / 2;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final item in items)
                      SizedBox(
                        width: width,
                        child: _CapabilityCard(data: item),
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

class _CapabilityHeader extends StatelessWidget {
  const _CapabilityHeader({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.16),
                blurRadius: 18,
              ),
            ],
          ),
          child: const SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              Icons.developer_board_outlined,
              size: 21,
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
                'Application ownership map',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: compact ? 17 : 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'The Flutter-side systems I own across product delivery.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.50),
                  fontSize: compact ? 11.5 : 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OwnershipPipeline extends StatelessWidget {
  const _OwnershipPipeline();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    const labels = ['UI', 'STATE', 'API', 'DATA', 'RELEASE'];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var index = 0; index < labels.length; index++) ...[
              _PipelineNode(
                label: labels[index],
                emphasized: index == 0 || index == labels.length - 1,
              ),
              if (index != labels.length - 1)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 15,
                  color: colors.onSurface.withValues(alpha: 0.28),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PipelineNode extends StatelessWidget {
  const _PipelineNode({required this.label, required this.emphasized});

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized
            ? AppColors.primary.withValues(alpha: 0.12)
            : colors.surface.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: emphasized
              ? AppColors.primary.withValues(alpha: 0.28)
              : colors.outline.withValues(alpha: 0.60),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: emphasized
                ? AppColors.primary
                : colors.onSurface.withValues(alpha: 0.62),
            fontSize: 9.5,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _CapabilityData {
  const _CapabilityData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _CapabilityCard extends StatefulWidget {
  const _CapabilityCard({required this.data});

  final _CapabilityData data;

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
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
      child: AnimatedScale(
        scale: _hovered ? 1.012 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.075)
                : colors.surface.withValues(alpha: 0.58),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.46)
                  : colors.outline.withValues(alpha: 0.68),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.09),
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
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: _hovered ? 0.18 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                    color: AppColors.primary.withValues(
                      alpha: _hovered ? 0.34 : 0.16,
                    ),
                  ),
                ),
                child: Icon(
                  widget.data.icon,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 13,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.data.description,
                      style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.56),
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
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '02 / PROFILE',
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
