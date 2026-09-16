import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _build(brightness: Brightness.dark);

  static ThemeData get light => _build(brightness: Brightness.light);

  static ThemeData _build({required Brightness brightness}) {
    final isDark = brightness == Brightness.dark;

    final background = isDark
        ? AppColors.background
        : AppColors.lightBackground;

    final surface = isDark ? AppColors.surface : AppColors.lightSurface;

    final surfaceElevated = isDark
        ? AppColors.surfaceElevated
        : AppColors.lightSurfaceElevated;

    final surfaceSoft = isDark
        ? AppColors.surfaceSoft
        : AppColors.lightSurfaceSoft;

    final textPrimary = isDark
        ? AppColors.textPrimary
        : AppColors.lightTextPrimary;

    final textSecondary = isDark
        ? AppColors.textSecondary
        : AppColors.lightTextSecondary;

    final textMuted = isDark ? AppColors.textMuted : AppColors.lightTextMuted;

    final textSubtle = isDark
        ? AppColors.textSubtle
        : AppColors.lightTextSubtle;

    final border = isDark ? AppColors.border : AppColors.lightBorder;

    final borderStrong = isDark
        ? AppColors.borderStrong
        : AppColors.lightBorderStrong;

    final borderAccent = isDark
        ? AppColors.borderAccent
        : AppColors.lightBorderAccent;

    final dividerSoft = isDark
        ? AppColors.dividerSoft
        : AppColors.lightDividerSoft;

    final colorScheme = isDark
        ? ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            primaryContainer: surfaceSoft,
            onPrimaryContainer: textPrimary,
            secondary: AppColors.secondary,
            onSecondary: AppColors.white,
            secondaryContainer: surfaceElevated,
            onSecondaryContainer: textPrimary,
            tertiary: AppColors.tertiary,
            onTertiary: AppColors.white,
            error: AppColors.error,
            onError: AppColors.white,
            surface: surface,
            onSurface: textPrimary,
            outline: border,
            outlineVariant: dividerSoft,
            shadow: AppColors.black,
            scrim: AppColors.black,
          )
        : ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            primaryContainer: const Color(0xFFE3E8FF),
            onPrimaryContainer: const Color(0xFF1E2C63),
            secondary: AppColors.secondary,
            onSecondary: AppColors.white,
            secondaryContainer: const Color(0xFFEDE6FF),
            onSecondaryContainer: const Color(0xFF33235E),
            tertiary: AppColors.tertiary,
            onTertiary: AppColors.white,
            error: AppColors.error,
            onError: AppColors.white,
            surface: surface,
            onSurface: textPrimary,
            outline: border,
            outlineVariant: dividerSoft,
            shadow: AppColors.black,
            scrim: AppColors.black,
          );

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      visualDensity: VisualDensity.standard,
    );

    final baseTextTheme = baseTheme.textTheme;

    return baseTheme.copyWith(
      canvasColor: background,
      scaffoldBackgroundColor: background,
      dividerColor: border,
      disabledColor: textSubtle,

      splashColor: AppColors.primary.withValues(alpha: 0.07),
      highlightColor: AppColors.primary.withValues(alpha: 0.04),
      hoverColor: AppColors.primary.withValues(alpha: 0.055),
      focusColor: AppColors.primary.withValues(alpha: 0.10),

      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.2,
          height: 1.02,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.8,
          height: 1.04,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.4,
          height: 1.06,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.9,
          height: 1.12,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.7,
          height: 1.15,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          height: 1.18,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: textSecondary,
          height: 1.6,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: textSecondary,
          height: 1.55,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: textMuted,
          height: 1.5,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),

      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.lg)),
          side: BorderSide(color: border),
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
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
          foregroundColor: const WidgetStatePropertyAll(AppColors.white),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return surfaceSoft;
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
              return textSubtle;
            }

            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }

            return textPrimary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return BorderSide(color: borderAccent);
            }

            return BorderSide(color: borderStrong);
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
              return textSubtle;
            }

            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }

            return textSecondary;
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

      dividerTheme: DividerThemeData(
        color: dividerSoft,
        thickness: 1,
        space: 1,
      ),

      iconTheme: IconThemeData(color: textSecondary),

      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: surfaceElevated,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: borderStrong),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.30 : 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        textStyle: TextStyle(
          color: textPrimary,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.24),
        selectionHandleColor: AppColors.primary,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: surfaceSoft,
        circularTrackColor: surfaceSoft,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withValues(alpha: 0.70);
          }

          return borderStrong;
        }),
        trackColor: const WidgetStatePropertyAll(AppColors.transparent),
        radius: const Radius.circular(AppRadius.pill),
        thickness: const WidgetStatePropertyAll(6),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceElevated,
        contentTextStyle: TextStyle(color: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
          side: BorderSide(color: borderStrong),
        ),
      ),
    );
  }
}
