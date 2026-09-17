import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import 'animated_section_background.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final tier = AppBreakpoints.tierForWidth(viewportWidth);

    final ultraNarrow = tier == AppViewportTier.ultraNarrow;
    final narrow =
        tier == AppViewportTier.ultraNarrow || tier == AppViewportTier.narrow;
    final compact = viewportWidth < AppBreakpoints.medium;

    final radius = compact ? AppRadius.lg : AppRadius.xl;

    final sectionPadding = switch (tier) {
      AppViewportTier.ultraNarrow => 12.0,
      AppViewportTier.narrow => 14.0,
      AppViewportTier.compact => 20.0,
      AppViewportTier.medium => 32.0,
      AppViewportTier.expanded => 48.0,
      AppViewportTier.ultraWide => 48.0,
    };

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
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
              blurRadius: compact ? 24 : 36,
              offset: Offset(0, compact ? 10 : 16),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSectionBackground(
                compact: compact,
                intensity: isDark ? 1.12 : 0.46,
              ),
            ),
            if (!ultraNarrow)
              Positioned(
                top: 0,
                right: narrow ? 14 : 36,
                child: _SectionIndex(dense: narrow),
              ),
            Padding(
              padding: EdgeInsets.all(sectionPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(
                    icon: Icons.work_outline_rounded,
                    label: narrow ? 'EXPERIENCE' : 'EXPERIENCE / CAREER',
                    dense: narrow,
                  ),
                  SizedBox(
                    height: ultraNarrow
                        ? 12
                        : compact
                        ? AppSpacing.md
                        : AppSpacing.lg,
                  ),
                  Text(
                    'Professional Flutter ownership across real production products.',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: titleSize,
                      height: 1.12,
                      letterSpacing: ultraNarrow
                          ? -0.35
                          : compact
                          ? -0.55
                          : -0.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: ultraNarrow
                        ? 10
                        : compact
                        ? AppSpacing.md
                        : AppSpacing.lg,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Text(
                      'My professional work focuses on end-to-end Flutter '
                      'application delivery—from application structure and '
                      'responsive UI to API integration, local data, debugging, '
                      'device testing, maintenance, and Android/iOS releases.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.66),
                        fontSize: bodySize,
                        height: ultraNarrow ? 1.52 : 1.66,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ultraNarrow
                        ? 16
                        : compact
                        ? AppSpacing.lg
                        : AppSpacing.xxl,
                  ),
                  if (_isExpanded)
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 8, child: _RoleConsole()),
                        SizedBox(width: AppSpacing.lg),
                        Expanded(flex: 11, child: _OwnershipSystem()),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _RoleConsole(dense: ultraNarrow, narrow: narrow),
                        SizedBox(height: ultraNarrow ? 10 : AppSpacing.md),
                        _OwnershipSystem(dense: ultraNarrow, narrow: narrow),
                      ],
                    ),
                  SizedBox(
                    height: ultraNarrow
                        ? 10
                        : compact
                        ? AppSpacing.md
                        : AppSpacing.lg,
                  ),
                  _DeliveryScope(compact: compact, dense: ultraNarrow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleConsole extends StatelessWidget {
  const _RoleConsole({this.dense = false, this.narrow = false});

  final bool dense;
  final bool narrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final padding = dense
        ? 12.0
        : narrow
        ? 14.0
        : AppSpacing.lg;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: isDark ? 0.76 : 0.91),
        borderRadius: BorderRadius.circular(
          dense ? AppRadius.md : AppRadius.lg,
        ),
        border: Border.all(color: colors.outline.withValues(alpha: 0.80)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.18 : 0.06),
            blurRadius: dense ? 18 : 26,
            offset: Offset(0, dense ? 7 : 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ConsoleHeader(dense: dense),
            SizedBox(
              height: dense
                  ? 12
                  : narrow
                  ? 14
                  : AppSpacing.lg,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final stackIdentity = constraints.maxWidth < 180;

                if (stackIdentity) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CompanyLogo(size: dense ? 42 : 48),
                      const SizedBox(height: 10),
                      _RoleIdentity(dense: dense),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _CompanyLogo(
                      size: dense
                          ? 42
                          : narrow
                          ? 48
                          : 56,
                    ),
                    SizedBox(width: dense ? 8 : AppSpacing.sm),
                    Expanded(child: _RoleIdentity(dense: dense)),
                  ],
                );
              },
            ),
            SizedBox(height: dense ? 12 : AppSpacing.md),
            Wrap(
              spacing: dense ? 5 : AppSpacing.xs,
              runSpacing: dense ? 5 : AppSpacing.xs,
              children: [
                _MetaChip(
                  icon: Icons.calendar_month_outlined,
                  label: dense ? 'Feb 2023 — Present' : 'Feb 2023 — Present',
                  dense: dense,
                ),
                _MetaChip(
                  icon: Icons.flutter_dash_rounded,
                  label: 'Flutter',
                  dense: dense,
                ),
                _MetaChip(
                  icon: Icons.devices_outlined,
                  label: dense ? 'Android + iOS' : 'Android + iOS',
                  dense: dense,
                ),
              ],
            ),
            SizedBox(height: dense ? 14 : AppSpacing.lg),
            Text(
              'I serve as the Flutter developer responsible for the mobile '
              'application layer while collaborating with backend developers '
              'who build and provide the required APIs.',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.66),
                fontSize: dense
                    ? 11.5
                    : narrow
                    ? 12.5
                    : 14,
                height: dense ? 1.52 : 1.62,
              ),
            ),
            SizedBox(height: dense ? 14 : AppSpacing.lg),
            _RoleOwnershipCallout(dense: dense),
          ],
        ),
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size <= 44 ? 4 : 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.17),
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
    );
  }
}

class _RoleIdentity extends StatelessWidget {
  const _RoleIdentity({required this.dense});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Developer',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: dense ? 17 : 22,
            height: 1.15,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: dense ? 2 : 3),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return AppColors.brandGradient.createShader(bounds);
          },
          child: Text(
            'Medigene IT',
            style: TextStyle(
              color: AppColors.white,
              fontSize: dense ? 12.5 : 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsoleHeader extends StatelessWidget {
  const _ConsoleHeader({required this.dense});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        _ConsoleDot(color: AppColors.error, size: dense ? 6 : 7),
        const SizedBox(width: 4),
        _ConsoleDot(color: AppColors.warning, size: dense ? 6 : 7),
        const SizedBox(width: 4),
        _ConsoleDot(color: AppColors.success, size: dense ? 6 : 7),
        const Spacer(),
        Flexible(
          child: Text(
            dense ? 'CURRENT ROLE' : 'CAREER / CURRENT ROLE',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.34),
              fontSize: dense ? 7.5 : 9,
              letterSpacing: dense ? 0.8 : 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsoleDot extends StatelessWidget {
  const _ConsoleDot({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _RoleOwnershipCallout extends StatelessWidget {
  const _RoleOwnershipCallout({required this.dense});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.secondary.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(dense ? 10 : AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.verified_outlined,
              size: dense ? 17 : 19,
              color: AppColors.primary,
            ),
            SizedBox(width: dense ? 7 : AppSpacing.sm),
            Expanded(
              child: Text(
                'Flutter ownership covers architecture, responsive UI, state, '
                'API integration, client-side logic, local persistence, '
                'debugging, testing, maintenance, and release delivery.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.66),
                  fontSize: dense ? 10.8 : 12.5,
                  height: dense ? 1.47 : 1.52,
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

class _OwnershipSystem extends StatelessWidget {
  const _OwnershipSystem({this.dense = false, this.narrow = false});

  final bool dense;
  final bool narrow;

  static const List<_ResponsibilityData> _items = [
    _ResponsibilityData(
      index: '01',
      icon: Icons.account_tree_outlined,
      title: 'Architecture & State',
      description:
          'Application structure, feature organization, state management, and client implementation.',
    ),
    _ResponsibilityData(
      index: '02',
      icon: Icons.devices_rounded,
      title: 'Responsive UI',
      description:
          'Production Flutter interfaces that adapt across mobile screen sizes and platforms.',
    ),
    _ResponsibilityData(
      index: '03',
      icon: Icons.api_rounded,
      title: 'API & Client Logic',
      description:
          'REST API integration, authentication flows, networking, state, and application logic.',
    ),
    _ResponsibilityData(
      index: '04',
      icon: Icons.storage_rounded,
      title: 'Local Persistence',
      description:
          'Preferences, local data, caching, database-backed workflows, and client-side persistence.',
    ),
    _ResponsibilityData(
      index: '05',
      icon: Icons.bug_report_outlined,
      title: 'Debug & Maintain',
      description:
          'Issue investigation, device testing, production fixes, compatibility, and maintenance.',
    ),
    _ResponsibilityData(
      index: '06',
      icon: Icons.rocket_launch_outlined,
      title: 'Release Delivery',
      description:
          'Android and iOS builds, signing, store workflows, submissions, and production updates.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final padding = dense
        ? 12.0
        : narrow
        ? 14.0
        : AppSpacing.lg;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: isDark ? 0.70 : 0.88),
        borderRadius: BorderRadius.circular(
          dense ? AppRadius.md : AppRadius.lg,
        ),
        border: Border.all(color: colors.outline.withValues(alpha: 0.80)),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dense) ...[
              Row(
                children: [
                  const _OwnershipIcon(size: 38),
                  const Spacer(),
                  const _AreaCounter(dense: true),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Flutter ownership system',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 16,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'The application-side responsibilities I handle in production.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.48),
                  fontSize: 10.5,
                  height: 1.4,
                ),
              ),
            ] else
              Row(
                children: [
                  const _OwnershipIcon(size: 44),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flutter ownership system',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontSize: narrow ? 16 : 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'The application-side responsibilities I handle in production.',
                          style: TextStyle(
                            color: colors.onSurface.withValues(alpha: 0.48),
                            fontSize: narrow ? 11 : 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const _AreaCounter(),
                ],
              ),
            SizedBox(height: dense ? 12 : AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final useTwoColumns = constraints.maxWidth >= 540;

                if (!useTwoColumns) {
                  return Column(
                    children: [
                      for (var index = 0; index < _items.length; index++) ...[
                        _ResponsibilityCard(data: _items[index], dense: dense),
                        if (index != _items.length - 1)
                          SizedBox(height: dense ? 6 : AppSpacing.xs),
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
                    for (final item in _items)
                      SizedBox(
                        width: width,
                        child: _ResponsibilityCard(data: item),
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

class _OwnershipIcon extends StatelessWidget {
  const _OwnershipIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          Icons.developer_board_outlined,
          size: size * 0.48,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _AreaCounter extends StatelessWidget {
  const _AreaCounter({this.dense = false});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 7 : 9,
          vertical: dense ? 5 : 6,
        ),
        child: Text(
          '06',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: dense ? 9 : 10,
            letterSpacing: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _ResponsibilityData {
  const _ResponsibilityData({
    required this.index,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String index;
  final IconData icon;
  final String title;
  final String description;
}

class _ResponsibilityCard extends StatefulWidget {
  const _ResponsibilityCard({required this.data, this.dense = false});

  final _ResponsibilityData data;
  final bool dense;

  @override
  State<_ResponsibilityCard> createState() => _ResponsibilityCardState();
}

class _ResponsibilityCardState extends State<_ResponsibilityCard> {
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
        padding: EdgeInsets.all(widget.dense ? 10 : AppSpacing.sm),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.075)
              : colors.surface.withValues(alpha: 0.56),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.44)
                : colors.outline.withValues(alpha: 0.66),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: widget.dense ? 34 : 38,
                  height: widget.dense ? 34 : 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: _hovered ? 0.18 : 0.10,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: _hovered ? 0.32 : 0.15,
                      ),
                    ),
                  ),
                  child: Icon(
                    widget.data.icon,
                    size: widget.dense ? 16 : 18,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.data.index,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.28),
                    fontSize: widget.dense ? 8.5 : 9.5,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.dense ? 8 : AppSpacing.sm),
            Text(
              widget.data.title,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: widget.dense ? 12 : 13,
                height: 1.28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.data.description,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.54),
                fontSize: widget.dense ? 10.3 : 11.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryScope extends StatelessWidget {
  const _DeliveryScope({required this.compact, required this.dense});

  final bool compact;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    const items = [
      _DeliveryData(
        icon: Icons.phone_android_rounded,
        value: 'Android',
        label: 'Production delivery',
      ),
      _DeliveryData(
        icon: Icons.phone_iphone_rounded,
        value: 'iOS',
        label: 'Production delivery',
      ),
      _DeliveryData(
        icon: Icons.groups_2_outlined,
        value: 'Backend',
        label: 'API collaboration',
      ),
      _DeliveryData(
        icon: Icons.system_update_alt_rounded,
        value: 'Stores',
        label: 'Release workflows',
      ),
    ];

    if (compact) {
      return Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _DeliveryCard(data: items[index], dense: dense),
            if (index != items.length - 1)
              SizedBox(height: dense ? 6 : AppSpacing.xs),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          Expanded(child: _DeliveryCard(data: items[index])),
          if (index != items.length - 1) const SizedBox(width: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _DeliveryData {
  const _DeliveryData({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

class _DeliveryCard extends StatefulWidget {
  const _DeliveryCard({required this.data, this.dense = false});

  final _DeliveryData data;
  final bool dense;

  @override
  State<_DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<_DeliveryCard> {
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
        padding: EdgeInsets.all(widget.dense ? 10 : AppSpacing.sm),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.secondary.withValues(alpha: 0.075)
              : colors.surface.withValues(alpha: 0.54),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovered
                ? AppColors.secondary.withValues(alpha: 0.38)
                : colors.outline.withValues(alpha: 0.62),
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.data.icon,
              size: widget.dense ? 16 : 18,
              color: AppColors.primary,
            ),
            SizedBox(width: widget.dense ? 8 : AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.value,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: widget.dense ? 11.5 : 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.data.label,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.46),
                      fontSize: widget.dense ? 9.5 : 10.5,
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

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.dense,
  });

  final IconData icon;
  final String label;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.66),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.outline.withValues(alpha: 0.62)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 7 : AppSpacing.sm,
          vertical: dense ? 5 : 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: dense ? 12 : 14, color: AppColors.primary),
            SizedBox(width: dense ? 4 : AppSpacing.xxs),
            Text(
              label,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.66),
                fontSize: dense ? 9.5 : 11.5,
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
  const _SectionLabel({
    required this.icon,
    required this.label,
    required this.dense,
  });

  final IconData icon;
  final String label;
  final bool dense;

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
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 8 : AppSpacing.sm,
          vertical: dense ? 6 : 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: dense ? 13 : 15, color: AppColors.white),
            SizedBox(width: dense ? 5 : AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: dense ? 8.5 : 10.5,
                letterSpacing: dense ? 0.9 : 1.4,
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
  const _SectionIndex({required this.dense});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        dense ? '03' : '03 / EXPERIENCE',
        style: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.30),
          fontSize: dense ? 8 : 9.5,
          letterSpacing: dense ? 1 : 1.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
