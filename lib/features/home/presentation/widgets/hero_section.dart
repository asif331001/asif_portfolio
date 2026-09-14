import 'package:flutter/material.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.windowSize,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    this.onViewProjectsPressed,
    this.onResumePressed,
    super.key,
  });

  final AppWindowSize windowSize;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback? onViewProjectsPressed;
  final VoidCallback? onResumePressed;

  bool get _isExpanded => windowSize == AppWindowSize.expanded;
  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final content = _isExpanded
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: _HeroContent(
                  windowSize: windowSize,
                  onViewProjectsPressed: onViewProjectsPressed,
                  onResumePressed: onResumePressed,
                  onLinkedInPressed: onLinkedInPressed,
                  onGitHubPressed: onGitHubPressed,
                  onWhatsAppPressed: onWhatsAppPressed,
                ),
              ),
              const SizedBox(width: AppSpacing.xxxl),
              const Expanded(flex: 4, child: _HeroPortrait()),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroContent(
                windowSize: windowSize,
                onViewProjectsPressed: onViewProjectsPressed,
                onResumePressed: onResumePressed,
                onLinkedInPressed: onLinkedInPressed,
                onGitHubPressed: onGitHubPressed,
                onWhatsAppPressed: onWhatsAppPressed,
              ),
              SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xxxl),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: _isCompact ? 230 : 430),
                  child: _HeroPortrait(compact: _isCompact),
                ),
              ),
            ],
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
            AppColors.surfaceElevated.withValues(alpha: 0.92),
            AppColors.background,
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -120,
            right: -80,
            child: _GlowOrb(size: 320, color: AppColors.primary),
          ),
          const Positioned(
            bottom: -140,
            left: -100,
            child: _GlowOrb(size: 300, color: AppColors.secondary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: switch (windowSize) {
                AppWindowSize.compact => AppSpacing.md,
                AppWindowSize.medium => AppSpacing.xl,
                AppWindowSize.expanded => AppSpacing.xxl,
              },
              vertical: switch (windowSize) {
                AppWindowSize.compact => AppSpacing.lg,
                AppWindowSize.medium => AppSpacing.xxxl,
                AppWindowSize.expanded => 80,
              },
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.windowSize,
    required this.onLinkedInPressed,
    required this.onGitHubPressed,
    required this.onWhatsAppPressed,
    required this.onViewProjectsPressed,
    required this.onResumePressed,
  });

  final AppWindowSize windowSize;
  final VoidCallback onLinkedInPressed;
  final VoidCallback onGitHubPressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback? onViewProjectsPressed;
  final VoidCallback? onResumePressed;

  bool get _isCompact => windowSize == AppWindowSize.compact;

  @override
  Widget build(BuildContext context) {
    final nameSize = switch (windowSize) {
      AppWindowSize.compact => 34.0,
      AppWindowSize.medium => 56.0,
      AppWindowSize.expanded => 68.0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AvailabilityBadge(compact: _isCompact),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.lg),
        Text(
          'MD. ASIF AHMED',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: nameSize,
            height: 0.98,
            letterSpacing: _isCompact ? -0.8 : -1.6,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.xs : AppSpacing.md),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Mobile Application Developer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: _isCompact ? 16 : null,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '  •  ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textMuted,
                  fontSize: _isCompact ? 16 : null,
                  height: 1.35,
                ),
              ),
              TextSpan(
                text: 'Flutter Developer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontSize: _isCompact ? 16 : null,
                  height: 1.35,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'Building production-ready Flutter applications '
            'for Android and iOS.',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: _isCompact ? 22 : 32,
              height: _isCompact ? 1.16 : 1.2,
              fontWeight: FontWeight.w700,
              letterSpacing: _isCompact ? -0.25 : -0.5,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.sm : AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 690),
          child: Text(
            _isCompact
                ? '3+ years building and shipping production Flutter apps '
                      'across architecture, APIs, local data, maintenance, '
                      'testing, and Android/iOS releases.'
                : '3+ years of professional experience owning Flutter '
                      'architecture, responsive UI, REST API integration, '
                      'local persistence, maintenance, device testing, and '
                      'Android/iOS production releases.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: _isCompact ? 1.45 : 1.65,
              fontSize: _isCompact ? 14 : 17,
            ),
          ),
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        Wrap(
          spacing: _isCompact ? AppSpacing.xs : AppSpacing.sm,
          runSpacing: _isCompact ? AppSpacing.xs : AppSpacing.sm,
          children: [
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.phone_android_rounded,
              label: 'Android & iOS',
            ),
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.rocket_launch_rounded,
              label: 'Production Releases',
            ),
            _CapabilityChip(
              compact: _isCompact,
              icon: Icons.account_tree_outlined,
              label: 'Flutter Architecture',
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.md : AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            FilledButton.icon(
              onPressed: onViewProjectsPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                disabledBackgroundColor: AppColors.surfaceSoft,
                disabledForegroundColor: AppColors.textMuted,
                padding: EdgeInsets.symmetric(
                  horizontal: _isCompact ? AppSpacing.md : AppSpacing.lg,
                  vertical: _isCompact ? AppSpacing.sm : AppSpacing.md,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
                ),
              ),
              icon: Icon(Icons.grid_view_rounded, size: _isCompact ? 17 : 19),
              label: Text(
                'View Projects',
                style: TextStyle(
                  fontSize: _isCompact ? 13 : null,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onResumePressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                disabledForegroundColor: AppColors.textMuted,
                side: const BorderSide(color: AppColors.borderStrong),
                padding: EdgeInsets.symmetric(
                  horizontal: _isCompact ? AppSpacing.md : AppSpacing.lg,
                  vertical: _isCompact ? AppSpacing.sm : AppSpacing.md,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
                ),
              ),
              icon: Icon(Icons.download_rounded, size: _isCompact ? 17 : 19),
              label: Text(
                'Download Resume',
                style: TextStyle(
                  fontSize: _isCompact ? 13 : null,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: _isCompact ? AppSpacing.xs : AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xxs,
          runSpacing: AppSpacing.xxs,
          children: [
            _SocialButton(
              compact: _isCompact,
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onPressed: onLinkedInPressed,
            ),
            _SocialButton(
              compact: _isCompact,
              icon: Icons.code_rounded,
              label: 'GitHub',
              onPressed: onGitHubPressed,
            ),
            _SocialButton(
              compact: _isCompact,
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onPressed: onWhatsAppPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: compact ? 6 : AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, size: 8, color: AppColors.accent),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '3+ YEARS • PRODUCTION FLUTTER',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 10.5 : 12,
                letterSpacing: compact ? 0.7 : 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CapabilityChip extends StatelessWidget {
  const _CapabilityChip({
    required this.compact,
    required this.icon,
    required this.label,
  });

  final bool compact;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
          vertical: compact ? 7 : AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: compact ? 15 : 17, color: AppColors.primary),
            SizedBox(width: compact ? AppSpacing.xxs : AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 11.5 : 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.compact,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final bool compact;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.xs : AppSpacing.md,
          vertical: compact ? 6 : AppSpacing.sm,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
        ),
      ),
      icon: Icon(icon, size: compact ? 16 : 18),
      label: Text(
        label,
        style: TextStyle(
          fontSize: compact ? 12 : null,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeroPortrait extends StatelessWidget {
  const _HeroPortrait({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: compact ? 0.92 : 0.84,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.lg : AppRadius.xl,
          ),
          border: Border.all(color: AppColors.borderStrong),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: compact ? 0.08 : 0.12),
              blurRadius: compact ? 28 : 48,
              spreadRadius: compact ? 0 : 2,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.surfaceSoft, AppColors.surface],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.lg - 1 : AppRadius.xl - 1,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/asif_ahmed_photo.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                semanticLabel: 'MD. Asif Ahmed',
              ),
              Positioned(
                left: compact ? AppSpacing.sm : AppSpacing.md,
                right: compact ? AppSpacing.sm : AppSpacing.md,
                bottom: compact ? AppSpacing.sm : AppSpacing.md,
                child: _PortraitInfoCard(compact: compact),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortraitInfoCard extends StatelessWidget {
  const _PortraitInfoCard({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.md : AppRadius.lg,
        ),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Row(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: compact ? 30 : 38,
                height: compact ? 30 : 38,
                child: Icon(
                  Icons.flutter_dash_rounded,
                  color: AppColors.background,
                  size: compact ? 17 : 21,
                ),
              ),
            ),
            SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: compact ? 12 : null,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 2),
                    const Text(
                      'Real products • Production ownership',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.14), color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
