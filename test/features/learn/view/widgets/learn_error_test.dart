import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/learn_error.dart';
import 'package:phonix/theme/app_colors.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );

void main() {
  group('LearnError', () {
    testWidgets('displays the message string passed via constructor',
        (tester) async {
      const message = 'Something went wrong loading learn data.';
      await tester.pumpWidget(_wrap(const LearnError(message: message)));

      expect(find.text(message), findsOneWidget);
    });

    testWidgets('message text colour is AppColors.onSurfaceVariant',
        (tester) async {
      const message = 'Tap to retry.';
      await tester.pumpWidget(_wrap(const LearnError(message: message)));

      final text = tester.widget<Text>(find.text(message));
      expect(text.style?.color, equals(AppColors.onSurfaceVariant));
    });

    testWidgets('renders different message strings correctly',
        (tester) async {
      const messageA = 'First error message.';
      await tester.pumpWidget(_wrap(const LearnError(message: messageA)));
      expect(find.text(messageA), findsOneWidget);

      const messageB = 'A completely different error.';
      await tester.pumpWidget(_wrap(const LearnError(message: messageB)));
      expect(find.text(messageB), findsOneWidget);
      expect(find.text(messageA), findsNothing);
    });
  });
}
