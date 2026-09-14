enum AppWindowSize { compact, medium, expanded }

abstract final class AppBreakpoints {
  const AppBreakpoints._();

  /// Compact:
  /// Phones, narrow mobile browsers, and very narrow desktop windows.
  static const double medium = 700;

  /// Expanded:
  /// Laptops, desktop browsers, and wider native desktop windows.
  static const double expanded = 1100;

  /// Prevents content from becoming excessively wide on large displays.
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
}
