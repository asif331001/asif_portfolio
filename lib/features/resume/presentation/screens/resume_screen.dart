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
          builder: (context, windowSize, constraints) {
            final isCompact = windowSize == AppWindowSize.compact;

            final horizontalPadding = switch (windowSize) {
              AppWindowSize.compact => AppSpacing.md,
              AppWindowSize.medium => AppSpacing.xl,
              AppWindowSize.expanded => AppSpacing.xxl,
            };

            return Column(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: AppBreakpoints.maxContentWidth,
                        ),
                        child: SizedBox(
                          height: isCompact ? 64 : 72,
                          child: Row(
                            children: [
                              IconButton(
                                tooltip: 'Back to portfolio',
                                onPressed: _goBack,
                                icon: const Icon(Icons.arrow_back_rounded),
                                color: AppColors.textPrimary,
                              ),
                              SizedBox(
                                width: isCompact
                                    ? AppSpacing.xs
                                    : AppSpacing.sm,
                              ),
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
                                        fontSize: isCompact ? 17 : 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (!isCompact)
                                      const Text(
                                        'MD. Asif Ahmed • Flutter Developer',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: isCompact
                                    ? AppSpacing.xs
                                    : AppSpacing.md,
                              ),
                              FilledButton.icon(
                                onPressed: _isDownloading
                                    ? null
                                    : _downloadResume,
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.background,
                                  disabledBackgroundColor:
                                      AppColors.surfaceSoft,
                                  disabledForegroundColor: AppColors.textMuted,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isCompact
                                        ? AppSpacing.sm
                                        : AppSpacing.md,
                                    vertical: AppSpacing.sm,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppRadius.sm),
                                    ),
                                  ),
                                ),
                                icon: _isDownloading
                                    ? SizedBox(
                                        width: isCompact ? 15 : 17,
                                        height: isCompact ? 15 : 17,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(
                                        Icons.download_rounded,
                                        size: isCompact ? 17 : 19,
                                      ),
                                label: Text(
                                  isCompact ? 'Download' : 'Download PDF',
                                  style: TextStyle(
                                    fontSize: isCompact ? 12 : 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        constraints: const BoxConstraints(maxWidth: 1050),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                              isCompact ? AppRadius.md : AppRadius.lg,
                            ),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              isCompact ? AppRadius.md - 1 : AppRadius.lg - 1,
                            ),
                            child: PdfViewer.asset(
                              ResumeDownloadService.assetPath,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
