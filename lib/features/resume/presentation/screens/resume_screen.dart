import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/services/resume_download_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  bool _isDownloading = false;

  Future<void> _downloadResume() async {
    if (_isDownloading) {
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    final saved = await ResumeDownloadService.download();

    if (!mounted) {
      return;
    }

    setState(() {
      _isDownloading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          saved
              ? 'Resume download started.'
              : 'Could not download the resume. Please try again.',
        ),
      ),
    );
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveLayout(
          builder: (context, windowSize, _) {
            final isCompact = windowSize == AppWindowSize.compact;

            final horizontalPadding = switch (windowSize) {
              AppWindowSize.compact => AppSpacing.md,
              AppWindowSize.medium => AppSpacing.xl,
              AppWindowSize.expanded => AppSpacing.xxl,
            };

            return Stack(
              children: [
                const Positioned(
                  top: -180,
                  right: -150,
                  child: _AmbientOrb(
                    size: 420,
                    color: AppColors.secondary,
                    opacity: 0.06,
                  ),
                ),
                const Positioned(
                  left: -190,
                  bottom: -210,
                  child: _AmbientOrb(
                    size: 440,
                    color: AppColors.primary,
                    opacity: 0.05,
                  ),
                ),
                Column(
                  children: [
                    _ResumeHeader(
                      compact: isCompact,
                      horizontalPadding: horizontalPadding,
                      downloading: _isDownloading,
                      onBackPressed: _goBack,
                      onDownloadPressed: _downloadResume,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          isCompact ? AppSpacing.sm : AppSpacing.lg,
                          horizontalPadding,
                          isCompact ? AppSpacing.sm : AppSpacing.lg,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1080),
                            child: _ResumeViewerFrame(compact: isCompact),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ResumeHeader extends StatelessWidget {
  const _ResumeHeader({
    required this.compact,
    required this.horizontalPadding,
    required this.downloading,
    required this.onBackPressed,
    required this.onDownloadPressed,
  });

  final bool compact;
  final double horizontalPadding;
  final bool downloading;
  final VoidCallback onBackPressed;
  final VoidCallback onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.96),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: SizedBox(
              height: compact ? 66 : 76,
              child: Row(
                children: [
                  _BackButton(compact: compact, onPressed: onBackPressed),
                  SizedBox(width: compact ? AppSpacing.sm : AppSpacing.md),
                  Expanded(child: _ResumeIdentity(compact: compact)),
                  SizedBox(width: compact ? AppSpacing.xs : AppSpacing.md),
                  _DownloadButton(
                    compact: compact,
                    downloading: downloading,
                    onPressed: onDownloadPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeIdentity extends StatelessWidget {
  const _ResumeIdentity({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!compact) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 14,
                ),
              ],
            ),
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Icon(
                Icons.description_outlined,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resume',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: compact ? 17 : 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 2),
                const Text(
                  'MD. Asif Ahmed • Flutter Developer',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _BackButton extends StatefulWidget {
  const _BackButton({required this.compact, required this.onPressed});

  final bool compact;
  final VoidCallback onPressed;

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.10)
            : AppColors.surface.withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: _active ? AppColors.borderAccent : AppColors.border,
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) {
            setState(() {
              _hovered = value;
            });
          },
          onFocusChange: (value) {
            setState(() {
              _focused = value;
            });
          },
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          highlightColor: AppColors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.xs : AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  offset: _active ? const Offset(-0.10, 0) : Offset.zero,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                if (!widget.compact) ...[
                  const SizedBox(width: AppSpacing.xs),
                  const Text(
                    'Portfolio',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({
    required this.compact,
    required this.downloading,
    required this.onPressed,
  });

  final bool compact;
  final bool downloading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: downloading ? null : AppColors.brandGradient,
        color: downloading ? AppColors.surfaceSoft : null,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        boxShadow: downloading
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
      ),
      child: FilledButton.icon(
        onPressed: downloading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.transparent,
          disabledBackgroundColor: AppColors.transparent,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.textMuted,
          shadowColor: AppColors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.sm : AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
          ),
        ),
        icon: downloading
            ? SizedBox(
                width: compact ? 15 : 17,
                height: compact ? 15 : 17,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textMuted,
                  ),
                ),
              )
            : Icon(
                Icons.download_rounded,
                size: compact ? 17 : 19,
                color: AppColors.white,
              ),
        label: Text(
          compact ? 'Download' : 'Download PDF',
          style: TextStyle(
            fontSize: compact ? 11.5 : 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ResumeViewerFrame extends StatelessWidget {
  const _ResumeViewerFrame({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        compact ? AppRadius.md : AppRadius.lg,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.md : AppRadius.lg,
          ),
          border: Border.all(color: AppColors.borderStrong),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D172A), Color(0xFF080F1D), Color(0xFF050A15)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.28),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          children: [
            _ViewerToolbar(compact: compact),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  compact ? 6 : AppSpacing.sm,
                  0,
                  compact ? 6 : AppSpacing.sm,
                  compact ? 6 : AppSpacing.sm,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    compact ? AppRadius.sm : AppRadius.md,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: PdfViewer.asset(ResumeDownloadService.assetPath),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewerToolbar extends StatelessWidget {
  const _ViewerToolbar({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 48 : 54,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.30),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'RESUME PREVIEW',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? 9.5 : 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            if (!compact)
              const Text(
                'PDF DOCUMENT',
                style: TextStyle(
                  color: AppColors.textSubtle,
                  fontSize: 9,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            if (!compact) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(width: 1, height: 18, color: AppColors.border),
              const SizedBox(width: AppSpacing.sm),
            ],
            const Icon(
              Icons.picture_as_pdf_outlined,
              color: AppColors.accent,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbientOrb extends StatelessWidget {
  const _AmbientOrb({
    required this.size,
    required this.color,
    required this.opacity,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
