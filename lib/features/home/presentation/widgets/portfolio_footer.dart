import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({
    required this.windowSize,
    required this.onEmailPressed,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    required this.onBackToTopPressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onEmailPressed;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onBackToTopPressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;
  bool get _isExpanded => windowSize == AppWindowSize.expanded;

  @override
  Widget build(BuildContext context) {
    final brand = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'ASIF',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              TextSpan(
                text: '.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'MD. Asif Ahmed',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Mobile Application Developer • Flutter Developer',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 470),
          child: const Text(
            'Building and maintaining production Flutter applications '
            'with a focus on responsive UI, architecture, integrations, '
            'local data, and Android/iOS delivery.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12.5,
              height: 1.6,
            ),
          ),
        ),
      ],
    );

    final connections = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _FooterAction(
              icon: Icons.email_outlined,
              label: 'Email',
              onPressed: onEmailPressed,
            ),
            _FooterAction(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            _FooterAction(
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            _FooterAction(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onPressed: onWhatsAppPressed,
            ),
          ],
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.56),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isExpanded)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: brand),
                  const SizedBox(width: AppSpacing.xxxl),
                  Expanded(flex: 5, child: connections),
                  const SizedBox(width: AppSpacing.xxl),
                  _BackToTopButton(onPressed: onBackToTopPressed),
                ],
              )
            else ...[
              brand,
              SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
              connections,
              SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
              Align(
                alignment: Alignment.centerLeft,
                child: _BackToTopButton(onPressed: onBackToTopPressed),
              ),
            ],
            SizedBox(height: _isCompact ? AppSpacing.lg : AppSpacing.xl),
            const Divider(height: 1, color: AppColors.border),
            SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
            if (_isCompact)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '© 2026 MD. Asif Ahmed',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Built with Flutter.',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              )
            else
              const Row(
                children: [
                  Text(
                    '© 2026 MD. Asif Ahmed',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Built with Flutter.',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
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

class _FooterAction extends StatelessWidget {
  const _FooterAction({
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
        foregroundColor: AppColors.textSecondary,
        side: const BorderSide(color: AppColors.borderStrong),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
        ),
      ),
      icon: Icon(icon, size: 16, color: AppColors.primary),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _BackToTopButton extends StatelessWidget {
  const _BackToTopButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
        ),
      ),
      icon: const Icon(Icons.arrow_upward_rounded, size: 17),
      label: const Text(
        'Back to top',
        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
      ),
    );
  }
}
