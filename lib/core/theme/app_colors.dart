import 'package:flutter/material.dart';

abstract final class AppColors {
  const AppColors._();

  // Core surfaces
  static const Color background = Color(0xFF07111F);
  static const Color surface = Color(0xFF0D1828);
  static const Color surfaceElevated = Color(0xFF132033);
  static const Color surfaceSoft = Color(0xFF17263B);

  // Brand
  static const Color primary = Color(0xFF42C6FF);
  static const Color primaryStrong = Color(0xFF1BAAE8);
  static const Color secondary = Color(0xFF7C8CFF);
  static const Color accent = Color(0xFF55E6B5);

  // Typography
  static const Color textPrimary = Color(0xFFF5F8FC);
  static const Color textSecondary = Color(0xFFB7C2D2);
  static const Color textMuted = Color(0xFF8290A3);

  // Borders / dividers
  static const Color border = Color(0xFF22344B);
  static const Color borderStrong = Color(0xFF314763);

  // Semantic
  static const Color success = Color(0xFF55E6B5);
  static const Color warning = Color(0xFFFFC857);
  static const Color error = Color(0xFFFF6B7A);

  // Utility
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}
