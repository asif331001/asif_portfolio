import 'package:asif_portfolio/app/app.dart';
import 'package:asif_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio hero renders primary professional identity', (
    tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    final hero = find.byType(HeroSection);

    expect(hero, findsOneWidget);

    expect(
      find.descendant(of: hero, matching: find.text('MD. ASIF')),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('AHMED')),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: hero,
        matching: find.text('Mobile Application Developer'),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('Flutter Developer')),
      findsAtLeastNWidgets(1),
    );

    expect(
      find.descendant(
        of: hero,
        matching: find.text(
          'I turn product ideas into polished, '
          'production-ready Flutter experiences.',
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(of: hero, matching: find.text('Explore Projects')),
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
