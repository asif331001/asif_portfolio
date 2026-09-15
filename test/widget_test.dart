import 'package:asif_portfolio/app/app.dart';
import 'package:asif_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio hero renders primary professional identity', (
    tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    final hero = find.byType(HeroSection);

    expect(hero, findsOneWidget);

    expect(
      find.descendant(of: hero, matching: find.text('MD. ASIF AHMED')),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: hero,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.textSpan?.toPlainText() ==
                  'Mobile Application Developer  •  Flutter Developer',
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: hero,
        matching: find.text(
          'Building production-ready Flutter applications '
          'for Android and iOS.',
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('View Projects')),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('View Resume')),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('LinkedIn')),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('GitHub')),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('WhatsApp')),
      findsOneWidget,
    );
  });
}
