import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

typedef ResponsiveWidgetBuilder =
    Widget Function(
      BuildContext context,
      AppWindowSize windowSize,
      BoxConstraints constraints,
    );

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({required this.builder, super.key});

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSize = AppBreakpoints.sizeForWidth(constraints.maxWidth);

        return builder(context, windowSize, constraints);
      },
    );
  }
}
