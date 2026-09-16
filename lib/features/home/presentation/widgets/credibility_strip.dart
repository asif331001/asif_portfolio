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
            for (var index = 0; index < _items.length; index++)
              SizedBox(
                width: itemWidth,
                child: _CredibilityCard(
                  index: index,
                  item: _items[index],
                  compact: windowSize == AppWindowSize.compact,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CredibilityCard extends StatefulWidget {
  const _CredibilityCard({
    required this.index,
    required this.item,
    required this.compact,
  });

  final int index;
  final _CredibilityItem item;
  final bool compact;

  @override
  State<_CredibilityCard> createState() => _CredibilityCardState();
}

class _CredibilityCardState extends State<_CredibilityCard> {
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
      child: AnimatedScale(
        scale: _hovered ? 1.015 : 1,
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
                    : AppColors.surface.withValues(alpha: 0.92),
                AppColors.backgroundSoft,
              ],
            ),
            borderRadius: BorderRadius.circular(
              widget.compact ? AppRadius.md : AppRadius.lg,
            ),
            border: Border.all(
              color: _hovered ? AppColors.borderAccent : AppColors.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      blurRadius: 26,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      blurRadius: 36,
                      offset: const Offset(0, 16),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.16),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: widget.compact ? 14 : 18,
                right: widget.compact ? 14 : 18,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(
                          alpha: _hovered ? 0.95 : 0.42,
                        ),
                        AppColors.secondary.withValues(
                          alpha: _hovered ? 0.95 : 0.42,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  widget.compact ? AppSpacing.md : AppSpacing.lg,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.18),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: widget.compact ? 38 : 44,
                        height: widget.compact ? 38 : 44,
                        child: Icon(
                          widget.item.icon,
                          size: widget.compact ? 18 : 21,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget.compact ? AppSpacing.xs : AppSpacing.sm,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.value,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: widget.compact ? 15 : 18,
                                    height: 1.15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Text(
                                '0${widget.index + 1}',
                                style: TextStyle(
                                  color: AppColors.textSubtle.withValues(
                                    alpha: 0.80,
                                  ),
                                  fontSize: widget.compact ? 9 : 10,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            widget.item.label,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: widget.compact ? 11.5 : 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
