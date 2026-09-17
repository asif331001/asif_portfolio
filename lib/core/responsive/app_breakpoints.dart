enum AppWindowSize { compact, medium, expanded }

enum AppViewportTier {
  ultraNarrow,
  narrow,
  compact,
  medium,
  expanded,
  ultraWide,
}

abstract final class AppBreakpoints {
  const AppBreakpoints._();

  static const double ultraNarrowMax = 320;
  static const double narrow = 375;
  static const double medium = 700;
  static const double expanded = 1100;
  static const double ultraWide = 1600;

  static const double maxContentWidth = 1280;

  static AppWindowSize sizeForWidth(double width) {
    if (width < medium) {
      return AppWindowSize.compact;
    }

    if (width < expanded) {
      return AppWindowSize.medium;
    }

    return AppWindowSize.expanded;
  }

  static AppViewportTier tierForWidth(double width) {
    if (width <= ultraNarrowMax) {
      return AppViewportTier.ultraNarrow;
    }

    if (width < narrow) {
      return AppViewportTier.narrow;
    }

    if (width < medium) {
      return AppViewportTier.compact;
    }

    if (width < expanded) {
      return AppViewportTier.medium;
    }

    if (width < ultraWide) {
      return AppViewportTier.expanded;
    }

    return AppViewportTier.ultraWide;
  }

  static bool isUltraNarrow(double width) {
    return tierForWidth(width) == AppViewportTier.ultraNarrow;
  }

  static bool isNarrowOrSmaller(double width) {
    final tier = tierForWidth(width);

    return tier == AppViewportTier.ultraNarrow ||
        tier == AppViewportTier.narrow;
  }
}
