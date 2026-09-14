import 'package:asif_portfolio/core/responsive/app_breakpoints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBreakpoints.sizeForWidth', () {
    test('returns compact below 700 logical pixels', () {
      expect(AppBreakpoints.sizeForWidth(375), AppWindowSize.compact);

      expect(AppBreakpoints.sizeForWidth(699), AppWindowSize.compact);
    });

    test('returns medium from 700 to below 1100 logical pixels', () {
      expect(AppBreakpoints.sizeForWidth(700), AppWindowSize.medium);

      expect(AppBreakpoints.sizeForWidth(1099), AppWindowSize.medium);
    });

    test('returns expanded from 1100 logical pixels', () {
      expect(AppBreakpoints.sizeForWidth(1100), AppWindowSize.expanded);

      expect(AppBreakpoints.sizeForWidth(1440), AppWindowSize.expanded);
    });
  });
}
