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
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = switch (windowSize) {
          AppWindowSize.expanded => 4,
          AppWindowSize.medium => 2,
          AppWindowSize.compact => constraints.maxWidth >= 340 ? 2 : 1,
        };

        final spacing = windowSize == AppWindowSize.compact
            ? AppSpacing.xs
            : AppSpacing.sm;

        final itemWidth =
            (constraints.maxWidth - (spacing * (columnCount - 1))) /
            columnCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in _items)
              SizedBox(
                width: itemWidth,
                child: _CredibilityCard(
                  item: item,
                  compact: windowSize == AppWindowSize.compact,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CredibilityCard extends StatelessWidget {
  const _CredibilityCard({required this.item, required this.compact});

  final _CredibilityItem item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.md : AppRadius.lg,
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                width: compact ? 36 : 42,
                height: compact ? 36 : 42,
                child: Icon(
                  item.icon,
                  size: compact ? 18 : 21,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 15 : 18,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: compact ? 11.5 : 13,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
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
    value: 'Android & iOS',
    label: 'Production mobile delivery',
  ),
  _CredibilityItem(
    icon: Icons.apps_rounded,
    value: 'Production Apps',
    label: 'Real-world Flutter products',
  ),
  _CredibilityItem(
    icon: Icons.verified_rounded,
    value: 'Store Releases',
    label: 'Play Store & App Store',
  ),
];
