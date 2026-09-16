import 'package:flutter/material.dart';

abstract final class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------------
  // Core canvas — deep masculine navy
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF030712);
  static const Color backgroundSoft = Color(0xFF070D1A);

  static const Color surface = Color(0xFF0A1222);
  static const Color surfaceElevated = Color(0xFF0F1930);
  static const Color surfaceSoft = Color(0xFF17233D);

  static const Color surfaceGlass = Color(0xE60B1426);
  static const Color glassHighlight = Color(0x14FFFFFF);

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
  // Typography
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF4F6FB);
  static const Color textSecondary = Color(0xFFB7C0D0);
  static const Color textMuted = Color(0xFF7F8AA0);
  static const Color textSubtle = Color(0xFF56627A);

  // ---------------------------------------------------------------------------
  // Borders
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFF1A2942);
  static const Color borderStrong = Color(0xFF2A3A59);
  static const Color borderAccent = Color(0x665874E8);
  static const Color dividerSoft = Color(0xFF111D32);

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
