import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/learn_error.dart';
import 'package:phonix/theme/app_colors.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );

void main() {
  group('LearnError', () {
    testWidgets('displays the message passed via constructor', (tester) async {
      await tester.pumpWidget(
        _wrap(const LearnError(message: 'Something went wrong')),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('message text color is AppColors.onSurfaceVariant',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const LearnError(message: 'Anything')),
      );

      final text = tester.widget<Text>(find.text('Anything'));
      expect(text.style?.color, AppColors.onSurfaceVariant);
    });

    testWidgets('renders the correct text for different messages',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const LearnError(message: 'First message')),
      );
      expect(find.text('First message'), findsOneWidget);

      await tester.pumpWidget(
        _wrap(const LearnError(message: 'Second message')),
      );
      expect(find.text('Second message'), findsOneWidget);
      expect(find.text('First message'), findsNothing);
    });
  });
}
