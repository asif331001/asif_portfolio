import 'app_breakpoints.dart';

abstract final class ResponsiveMetrics {
  const ResponsiveMetrics._();

  static double pageHorizontalPadding(double width) {
    return switch (AppBreakpoints.tierForWidth(width)) {
      AppViewportTier.ultraNarrow => 10,
      AppViewportTier.narrow => 12,
      AppViewportTier.compact => 16,
      AppViewportTier.medium => 32,
      AppViewportTier.expanded => 48,
      AppViewportTier.ultraWide => 56,
    };
  }

  static double pageVerticalPadding(double width) {
    return switch (AppBreakpoints.tierForWidth(width)) {
      AppViewportTier.ultraNarrow => 12,
      AppViewportTier.narrow => 14,
      AppViewportTier.compact => 16,
      AppViewportTier.medium => 32,
      AppViewportTier.expanded => 48,
      AppViewportTier.ultraWide => 52,
    };
  }

  static double sectionGap(double width) {
    return switch (AppBreakpoints.tierForWidth(width)) {
      AppViewportTier.ultraNarrow => 20,
      AppViewportTier.narrow => 22,
      AppViewportTier.compact => 24,
      AppViewportTier.medium => 32,
      AppViewportTier.expanded => 48,
      AppViewportTier.ultraWide => 52,
    };
  }

  static double navbarHeight(double width) {
    return switch (AppBreakpoints.tierForWidth(width)) {
      AppViewportTier.ultraNarrow => 64,
      AppViewportTier.narrow => 68,
      AppViewportTier.compact => 72,
      AppViewportTier.medium => 76,
      AppViewportTier.expanded => 78,
      AppViewportTier.ultraWide => 78,
    };
  }
}
