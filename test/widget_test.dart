import 'package:asif_portfolio/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio hero renders primary professional identity', (
    tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('MD. ASIF AHMED'), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.textSpan?.toPlainText() ==
                'Mobile Application Developer  •  Flutter Developer',
      ),
      findsOneWidget,
    );

    expect(
      find.text(
        'Building production-ready Flutter applications '
        'for Android and iOS.',
      ),
      findsOneWidget,
    );

    expect(find.text('View Projects'), findsOneWidget);
    expect(find.text('View Resume'), findsWidgets);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
  });
}
