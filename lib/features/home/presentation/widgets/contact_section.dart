import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.windowSize,
    required this.onEmailPressed,
    required this.onWhatsAppPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onEmailPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(
          icon: Icons.alternate_email_rounded,
          label: 'CONTACT',
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        Text(
          'Have a Flutter project or opportunity to discuss?',
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
          'You can reach me directly for Flutter development work, '
          'professional opportunities, product discussions, or '
          'collaboration.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: _isCompact ? 14 : 16,
            height: 1.65,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
        const _ContactInfo(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'asif.gub182@gmail.com',
        ),
        const SizedBox(height: AppSpacing.md),
        const _ContactInfo(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: '+880 1795-331001',
        ),
        const SizedBox(height: AppSpacing.md),
        const _ContactInfo(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Mirpur, Dhaka, Bangladesh',
        ),
      ],
    );

    final actions = _ContactActions(
      compact: _isCompact,
      onEmailPressed: onEmailPressed,
      onWhatsAppPressed: onWhatsAppPressed,
      onLinkedInPressed: onLinkedInPressed,
      onGitHubPressed: onGitHubPressed,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          _isCompact ? AppRadius.lg : AppRadius.xl,
        ),
        border: Border.all(color: AppColors.border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceElevated.withValues(alpha: 0.85),
            AppColors.background,
          ],
        ),
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
                  Expanded(flex: 10, child: introduction),
                  const SizedBox(width: AppSpacing.xxxl),
                  Expanded(flex: 8, child: actions),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  introduction,
                  SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xxl),
                  actions,
                ],
              ),
      ),
    );
  }
}

class _ContactActions extends StatelessWidget {
  const _ContactActions({
    required this.compact,
    required this.onEmailPressed,
    required this.onWhatsAppPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
  });

  final bool compact;
  final VoidCallback onEmailPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connect directly',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: compact ? 18 : 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Choose the channel that works best for you.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 12.5 : 14,
                height: 1.45,
              ),
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            _PrimaryContactButton(
              icon: Icons.email_outlined,
              label: 'Send an Email',
              onPressed: onEmailPressed,
            ),
            const SizedBox(height: AppSpacing.sm),
            _ContactButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onPressed: onWhatsAppPressed,
            ),
            const SizedBox(height: AppSpacing.sm),
            _ContactButton(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            const SizedBox(height: AppSpacing.sm),
            _ContactButton(
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            const Divider(height: 1, color: AppColors.border),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone_android_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Focused on Flutter application development, '
                    'production maintenance, and Android/iOS delivery.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryContactButton extends StatelessWidget {
  const _PrimaryContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
      ),
      icon: Icon(icon, size: 19),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.borderStrong),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
      ),
      icon: Icon(icon, size: 19, color: AppColors.primary),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: SizedBox(
            width: 38,
            height: 38,
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
                  color: AppColors.textMuted,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              SelectableText(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
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
