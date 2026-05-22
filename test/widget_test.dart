import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/screens/learn_screen.dart';
import 'package:phonix/main.dart';

void main() {
  testWidgets('AppShell displays LearnScreen by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PhonixApp());
    expect(find.byType(LearnScreen), findsOneWidget);
  });
}
