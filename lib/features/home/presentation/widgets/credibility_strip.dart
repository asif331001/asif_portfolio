import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class CredibilityStrip extends StatelessWidget {
  const CredibilityStrip({required this.windowSize, super.key});

  final AppWindowSize windowSize;

  @override
  Widget build(BuildContext context) {
    final compact = windowSize == AppWindowSize.compact;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = switch (windowSize) {
          AppWindowSize.expanded => 4,
          AppWindowSize.medium => 2,
          AppWindowSize.compact => constraints.maxWidth >= 340 ? 2 : 1,
        };

        final spacing = compact ? AppSpacing.xs : AppSpacing.sm;

        final itemWidth =
            (constraints.maxWidth - (spacing * (columnCount - 1))) /
            columnCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var index = 0; index < _items.length; index++)
              SizedBox(
                width: itemWidth,
                child: _CredibilitySignal(
                  index: index,
                  item: _items[index],
                  compact: compact,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CredibilitySignal extends StatefulWidget {
  const _CredibilitySignal({
    required this.index,
    required this.item,
    required this.compact,
  });

  final int index;
  final _CredibilityItem item;
  final bool compact;

  @override
  State<_CredibilitySignal> createState() => _CredibilitySignalState();
}

class _CredibilitySignalState extends State<_CredibilitySignal> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: EdgeInsets.all(widget.compact ? AppSpacing.sm : AppSpacing.md),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: isDark ? 0.075 : 0.055)
              : colors.surface.withValues(alpha: isDark ? 0.78 : 0.92),
          borderRadius: BorderRadius.circular(
            widget.compact ? AppRadius.md : AppRadius.lg,
          ),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.42)
                : colors.outline.withValues(alpha: 0.68),
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: isDark ? 0.09 : 0.06)
                  : AppColors.black.withValues(alpha: isDark ? 0.12 : 0.035),
              blurRadius: _hovered ? 22 : 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SignalIcon(
                  icon: widget.item.icon,
                  compact: widget.compact,
                  active: _hovered,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'SIGNAL $indexLabel',
                      style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.30),
                        fontSize: widget.compact ? 8 : 8.5,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const _SignalStatus(),
                  ],
                ),
              ],
            ),
            SizedBox(height: widget.compact ? AppSpacing.sm : AppSpacing.md),
            Text(
              widget.item.value,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: widget.compact ? 16 : 19,
                height: 1.12,
                letterSpacing: -0.25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.item.label,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.55),
                fontSize: widget.compact ? 11 : 12.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignalIcon extends StatelessWidget {
  const _SignalIcon({
    required this.icon,
    required this.compact,
    required this.active,
  });

  final IconData icon;
  final bool compact;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: compact ? 38 : 44,
      height: compact ? 38 : 44,
      decoration: BoxDecoration(
        gradient: active ? AppColors.brandGradient : null,
        color: active ? null : AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: active
              ? AppColors.transparent
              : AppColors.primary.withValues(alpha: 0.16),
        ),
      ),
      child: Icon(
        icon,
        size: compact ? 18 : 20,
        color: active ? AppColors.white : AppColors.primary,
      ),
    );
  }
}

class _SignalStatus extends StatelessWidget {
  const _SignalStatus();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'VERIFIED',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.38),
            fontSize: 8,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _CredibilityItem {
  const _CredibilityItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

const List<_CredibilityItem> _items = [
  _CredibilityItem(
    icon: Icons.timeline_rounded,
    value: '3+ Years',
    label: 'Professional Flutter experience',
  ),
  _CredibilityItem(
    icon: Icons.devices_rounded,
    value: 'Android + iOS',
    label: 'Production mobile delivery',
  ),
  _CredibilityItem(
    icon: Icons.apps_rounded,
    value: '8 Projects',
    label: 'Real-world Flutter product work',
  ),
  _CredibilityItem(
    icon: Icons.verified_rounded,
    value: 'Store Releases',
    label: 'Play Store & App Store workflows',
  ),
];
