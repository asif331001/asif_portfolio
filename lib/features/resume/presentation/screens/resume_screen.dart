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
import '../../../../core/theme/theme_controller.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  bool _isDownloading = false;
  bool _isPdfReady = false;
  bool _pdfLoadFailed = false;
  int _viewerGeneration = 0;

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

  void _handlePdfReady() {
    if (!mounted || _isPdfReady) {
      return;
    }

    setState(() {
      _isPdfReady = true;
      _pdfLoadFailed = false;
    });
  }

  void _handlePdfLoadFailed() {
    if (!mounted) {
      return;
    }

    setState(() {
      _isPdfReady = false;
      _pdfLoadFailed = true;
    });
  }

  void _retryPdf() {
    setState(() {
      _isPdfReady = false;
      _pdfLoadFailed = false;
      _viewerGeneration++;
    });
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
                    AppColors.background,
                    AppColors.backgroundSoft,
                    AppColors.background,
                  ]
                : const [
                    AppColors.lightBackground,
                    AppColors.lightBackgroundSoft,
                    AppColors.lightBackground,
                  ],
          ),
        ),
        child: SafeArea(
          child: ResponsiveLayout(
            builder: (context, windowSize, _) {
              final compact = windowSize == AppWindowSize.compact;

              final horizontalPadding = switch (windowSize) {
                AppWindowSize.compact => AppSpacing.md,
                AppWindowSize.medium => AppSpacing.xl,
                AppWindowSize.expanded => AppSpacing.xxl,
              };

              return Stack(
                children: [
                  Positioned(
                    top: -180,
                    right: -150,
                    child: _AmbientOrb(
                      size: 420,
                      color: AppColors.secondary,
                      opacity: isDark ? 0.055 : 0.025,
                    ),
                  ),
                  Positioned(
                    left: -190,
                    bottom: -210,
                    child: _AmbientOrb(
                      size: 440,
                      color: AppColors.primary,
                      opacity: isDark ? 0.045 : 0.025,
                    ),
                  ),
                  Column(
                    children: [
                      _ResumeHeader(
                        compact: compact,
                        horizontalPadding: horizontalPadding,
                        downloading: _isDownloading,
                        onBackPressed: _goBack,
                        onDownloadPressed: _downloadResume,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            compact ? AppSpacing.sm : AppSpacing.lg,
                            horizontalPadding,
                            compact ? AppSpacing.sm : AppSpacing.lg,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1080),
                              child: _ResumeViewerFrame(
                                compact: compact,
                                ready: _isPdfReady,
                                failed: _pdfLoadFailed,
                                viewerGeneration: _viewerGeneration,
                                onReady: _handlePdfReady,
                                onLoadFailed: _handlePdfLoadFailed,
                                onRetry: _retryPdf,
                              ),
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(
          alpha: isDark ? 0.94 : 0.96,
        ),
        border: Border(
          bottom: BorderSide(color: colors.outline.withValues(alpha: 0.58)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.14 : 0.04),
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
                  SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
                  const _ThemeToggle(),
                  SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
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
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        if (!compact) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.16),
                  blurRadius: 14,
                ),
              ],
            ),
            child: const SizedBox(
              width: 38,
              height: 38,
              child: Icon(
                Icons.description_outlined,
                color: AppColors.white,
                size: 19,
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
                  color: colors.onSurface,
                  fontSize: compact ? 17 : 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 2),
                Text(
                  'MD. Asif Ahmed • Flutter Developer',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.52),
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
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(_active ? -2 : 0, 0, 0),
      decoration: BoxDecoration(
        color: _active
            ? AppColors.primary.withValues(alpha: 0.09)
            : colors.surface.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _active
              ? AppColors.primary.withValues(alpha: 0.38)
              : colors.outline.withValues(alpha: 0.62),
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
          borderRadius: BorderRadius.circular(AppRadius.md),
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.06),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.xs : AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                if (!widget.compact) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.68),
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

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle();

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final targetLabel = isDark
        ? 'Switch to light theme'
        : 'Switch to dark theme';

    return Tooltip(
      message: targetLabel,
      child: Semantics(
        button: true,
        label: targetLabel,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
            scale: _hovered ? 1.045 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: () {
                  ThemeController.instance.toggleTheme();
                },
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.09)
                        : colors.surface.withValues(alpha: 0.60),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.primary.withValues(alpha: 0.38)
                          : colors.outline.withValues(alpha: 0.62),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween<double>(
                          begin: 0.75,
                          end: 1,
                        ).animate(animation),
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      key: ValueKey(isDark),
                      size: 19,
                      color: isDark
                          ? const Color(0xFFFFD66B)
                          : AppColors.secondary,
                    ),
                  ),
                ),
              ),
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
    final colors = Theme.of(context).colorScheme;

    if (compact) {
      return Tooltip(
        message: downloading ? 'Downloading...' : 'Download Resume',
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: downloading ? null : AppColors.brandGradient,
            color: downloading ? colors.surface : null,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: downloading
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.16),
                      blurRadius: 16,
                    ),
                  ],
          ),
          child: SizedBox(
            width: 42,
            height: 42,
            child: IconButton(
              onPressed: downloading ? null : onPressed,
              icon: downloading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : const Icon(Icons.download_rounded, size: 18),
              color: AppColors.white,
              disabledColor: colors.onSurface.withValues(alpha: 0.42),
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: downloading ? null : AppColors.brandGradient,
        color: downloading ? colors.surface : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
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
          disabledForegroundColor: colors.onSurface.withValues(alpha: 0.42),
          shadowColor: AppColors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
          ),
        ),
        icon: downloading
            ? const SizedBox(
                width: 17,
                height: 17,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            : const Icon(
                Icons.download_rounded,
                size: 19,
                color: AppColors.white,
              ),
        label: const Text(
          'Download PDF',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _ResumeViewerFrame extends StatelessWidget {
  const _ResumeViewerFrame({
    required this.compact,
    required this.ready,
    required this.failed,
    required this.viewerGeneration,
    required this.onReady,
    required this.onLoadFailed,
    required this.onRetry,
  });

  final bool compact;
  final bool ready;
  final bool failed;
  final int viewerGeneration;
  final VoidCallback onReady;
  final VoidCallback onLoadFailed;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        compact ? AppRadius.md : AppRadius.lg,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            compact ? AppRadius.md : AppRadius.lg,
          ),
          border: Border.all(
            color: colors.outline.withValues(alpha: isDark ? 0.84 : 0.68),
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
              color: AppColors.black.withValues(alpha: isDark ? 0.22 : 0.06),
              blurRadius: 32,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          children: [
            _ViewerToolbar(compact: compact, ready: ready, failed: failed),
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
                      color: colors.surface,
                      border: Border.all(
                        color: colors.outline.withValues(alpha: 0.58),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PdfViewer.asset(
                          ResumeDownloadService.assetPath,
                          key: ValueKey(viewerGeneration),
                          params: PdfViewerParams(
                            backgroundColor: colors.surface,
                            margin: compact ? 6 : 12,
                            onViewerReady: (_, _) {
                              onReady();
                            },
                            onDocumentLoadFinished: (_, succeeded) {
                              if (!succeeded) {
                                onLoadFailed();
                              }
                            },
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          child: failed
                              ? _PdfErrorOverlay(
                                  key: const ValueKey('pdf-error'),
                                  compact: compact,
                                  onRetry: onRetry,
                                )
                              : !ready
                              ? _PdfLoadingOverlay(
                                  key: const ValueKey('pdf-loading'),
                                  compact: compact,
                                )
                              : const SizedBox.shrink(
                                  key: ValueKey('pdf-ready'),
                                ),
                        ),
                      ],
                    ),
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
  const _ViewerToolbar({
    required this.compact,
    required this.ready,
    required this.failed,
  });

  final bool compact;
  final bool ready;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final statusLabel = failed
        ? 'ERROR'
        : ready
        ? 'READY'
        : 'LOADING';

    final statusColor = failed
        ? Colors.redAccent
        : ready
        ? AppColors.success
        : AppColors.primary;

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
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'RESUME PREVIEW',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.62),
                fontSize: compact ? 9.5 : 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Text(
              statusLabel,
              style: TextStyle(
                color: statusColor,
                fontSize: 8.5,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (!compact) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 1,
                height: 18,
                color: colors.outline.withValues(alpha: 0.56),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.picture_as_pdf_outlined,
                color: colors.onSurface.withValues(alpha: 0.48),
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PdfLoadingOverlay extends StatelessWidget {
  const _PdfLoadingOverlay({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ColoredBox(
      color: colors.surface.withValues(alpha: isDark ? 0.96 : 0.98),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: SizedBox(
                    width: compact ? 58 : 66,
                    height: compact ? 58 : 66,
                    child: const Center(
                      child: Icon(
                        Icons.description_outlined,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.6,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Preparing resume preview',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: compact ? 16 : 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Loading and rendering the PDF document...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.50),
                    fontSize: compact ? 11.5 : 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PdfErrorOverlay extends StatelessWidget {
  const _PdfErrorOverlay({
    required this.compact,
    required this.onRetry,
    super.key,
  });

  final bool compact;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colors.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.20),
                    ),
                  ),
                  child: SizedBox(
                    width: compact ? 58 : 66,
                    height: compact ? 58 : 66,
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Could not load the resume',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: compact ? 16 : 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The PDF preview could not be prepared. You can retry the viewer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.50),
                    fontSize: compact ? 11.5 : 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                FilledButton.icon(
                  onPressed: onRetry,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.refresh_rounded, size: 17),
                  label: const Text(
                    'Retry',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
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
