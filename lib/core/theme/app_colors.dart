import 'package:flutter/material.dart';

abstract final class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------------
  // Dark canvas — deep masculine navy
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF030712);
  static const Color backgroundSoft = Color(0xFF070D1A);

  static const Color surface = Color(0xFF0A1222);
  static const Color surfaceElevated = Color(0xFF0F1930);
  static const Color surfaceSoft = Color(0xFF17233D);

  static const Color surfaceGlass = Color(0xE60B1426);
  static const Color glassHighlight = Color(0x14FFFFFF);

  // ---------------------------------------------------------------------------
  // Light canvas — cool technical neutral
  // ---------------------------------------------------------------------------

  static const Color lightBackground = Color(0xFFF5F7FC);
  static const Color lightBackgroundSoft = Color(0xFFEDF1F8);

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF8FAFF);
  static const Color lightSurfaceSoft = Color(0xFFE9EEF8);

  static const Color lightSurfaceGlass = Color(0xEFFFFFFF);
  static const Color lightGlassHighlight = Color(0xA6FFFFFF);

  // ---------------------------------------------------------------------------
  // Brand — royal blue + dark violet
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF5874E8);
  static const Color primaryStrong = Color(0xFF465FD0);

  static const Color secondary = Color(0xFF6549B8);
  static const Color accent = Color(0xFF8068D8);

  static const Color tertiary = Color(0xFF402C73);

  // ---------------------------------------------------------------------------
  // Controlled glow
  // ---------------------------------------------------------------------------

  static const Color primaryGlow = Color(0x405874E8);
  static const Color secondaryGlow = Color(0x406549B8);
  static const Color tertiaryGlow = Color(0x30402C73);

  // ---------------------------------------------------------------------------
  // Dark typography
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF4F6FB);
  static const Color textSecondary = Color(0xFFB7C0D0);
  static const Color textMuted = Color(0xFF7F8AA0);
  static const Color textSubtle = Color(0xFF56627A);

  // ---------------------------------------------------------------------------
  // Light typography
  // ---------------------------------------------------------------------------

  static const Color lightTextPrimary = Color(0xFF10182A);
  static const Color lightTextSecondary = Color(0xFF45516A);
  static const Color lightTextMuted = Color(0xFF6E7890);
  static const Color lightTextSubtle = Color(0xFF8E98AA);

  // ---------------------------------------------------------------------------
  // Dark borders
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFF1A2942);
  static const Color borderStrong = Color(0xFF2A3A59);
  static const Color borderAccent = Color(0x665874E8);
  static const Color dividerSoft = Color(0xFF111D32);

  // ---------------------------------------------------------------------------
  // Light borders
  // ---------------------------------------------------------------------------

  static const Color lightBorder = Color(0xFFDCE3EF);
  static const Color lightBorderStrong = Color(0xFFC8D2E3);
  static const Color lightBorderAccent = Color(0x665874E8);
  static const Color lightDividerSoft = Color(0xFFE7ECF4);

  // ---------------------------------------------------------------------------
  // Semantic
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF58C9A6);
  static const Color warning = Color(0xFFD9A84E);
  static const Color error = Color(0xFFE36574);

  // ---------------------------------------------------------------------------
  // Utility
  // ---------------------------------------------------------------------------

  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Gradients
  // ---------------------------------------------------------------------------

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5874E8), Color(0xFF6549B8)],
  );

  static const LinearGradient futuristicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5874E8), Color(0xFF5946A4), Color(0xFF402C73)],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF111C32), Color(0xFF080E1C)],
  );

  static const RadialGradient ambientGlow = RadialGradient(
    colors: [Color(0x305874E8), Color(0x226549B8), Color(0x00030712)],
    stops: [0, 0.50, 1],
  );
}
