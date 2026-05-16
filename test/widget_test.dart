import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/main.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const PhonixApp());
    expect(find.text('Phonix'), findsOneWidget);
  });
}
