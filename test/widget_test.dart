import 'package:asif_portfolio/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio app renders developer name', (tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('MD. ASIF AHMED'), findsOneWidget);
  });
}
