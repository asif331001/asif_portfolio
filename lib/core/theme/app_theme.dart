import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.surfaceSoft,
      onPrimaryContainer: AppColors.textPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.surfaceElevated,
      onSecondaryContainer: AppColors.textPrimary,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
      outlineVariant: AppColors.dividerSoft,
      shadow: AppColors.black,
      scrim: AppColors.black,
    );

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      visualDensity: VisualDensity.standard,
    );

    final baseTextTheme = baseTheme.textTheme;

    return baseTheme.copyWith(
      canvasColor: AppColors.background,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.border,
      disabledColor: AppColors.textSubtle,

      splashColor: AppColors.primary.withValues(alpha: 0.07),
      highlightColor: AppColors.primary.withValues(alpha: 0.04),
      hoverColor: AppColors.primary.withValues(alpha: 0.055),
      focusColor: AppColors.primary.withValues(alpha: 0.10),

      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.2,
          height: 1.02,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.8,
          height: 1.04,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.4,
          height: 1.06,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.9,
          height: 1.12,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.7,
          height: 1.15,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          height: 1.18,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          height: 1.55,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: AppColors.textMuted,
          height: 1.5,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),

      cardTheme: const CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
          side: BorderSide(color: AppColors.border),
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 46)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
          ),
          foregroundColor: const WidgetStatePropertyAll(AppColors.background),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.surfaceSoft;
            }

            if (states.contains(WidgetState.hovered)) {
              return AppColors.primaryStrong;
            }

            return AppColors.primary;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.white.withValues(alpha: 0.08),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 46)),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textSubtle;
            }

            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }

            return AppColors.textPrimary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return const BorderSide(color: AppColors.borderAccent);
            }

            return const BorderSide(color: AppColors.borderStrong);
          }),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
          ),
          overlayColor: WidgetStatePropertyAll(
            AppColors.primary.withValues(alpha: 0.06),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textSubtle;
            }

            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }

            return AppColors.textSecondary;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.primary.withValues(alpha: 0.055),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
            ),
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.dividerSoft,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.textSecondary),

      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.borderStrong),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.30),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        textStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.24),
        selectionHandleColor: AppColors.primary,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceSoft,
        circularTrackColor: AppColors.surfaceSoft,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withValues(alpha: 0.70);
          }

          return AppColors.borderStrong;
        }),
        trackColor: const WidgetStatePropertyAll(AppColors.transparent),
        radius: const Radius.circular(AppRadius.pill),
        thickness: const WidgetStatePropertyAll(6),
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: TextStyle(color: AppColors.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
          side: BorderSide(color: AppColors.borderStrong),
        ),
      ),
    );
  }
}
