import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/bullet_list.dart';
import 'package:phonix/theme/app_colors.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('BulletList', () {
    testWidgets('renders one Padding row per item for a non-empty list',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const BulletList(items: ['alpha', 'beta', 'gamma'])),
      );

      expect(
        find.descendant(
          of: find.byType(BulletList),
          matching: find.byType(Padding),
        ),
        findsNWidgets(3),
      );
    });

    testWidgets('renders each item text', (tester) async {
      await tester.pumpWidget(
        _wrap(const BulletList(items: ['alpha', 'beta', 'gamma'])),
      );

      expect(find.text('alpha'), findsOneWidget);
      expect(find.text('beta'), findsOneWidget);
      expect(find.text('gamma'), findsOneWidget);
    });

    testWidgets('renders a "· " bullet before each item', (tester) async {
      await tester.pumpWidget(
        _wrap(const BulletList(items: ['alpha', 'beta', 'gamma'])),
      );

      expect(find.text('· '), findsNWidgets(3));
    });

    testWidgets('an empty list renders no Padding rows and no bullets',
        (tester) async {
      await tester.pumpWidget(_wrap(const BulletList(items: [])));

      expect(
        find.descendant(
          of: find.byType(BulletList),
          matching: find.byType(Padding),
        ),
        findsNothing,
      );
      expect(find.text('· '), findsNothing);
    });

    testWidgets('bullet uses AppColors.onSurfaceVariant as its text color',
        (tester) async {
      await tester.pumpWidget(_wrap(const BulletList(items: ['only'])));

      final bullet = tester.widget<Text>(find.text('· '));
      expect(bullet.style?.color, AppColors.onSurfaceVariant);
    });
  });
}
