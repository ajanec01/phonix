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
    testWidgets('renders one row per item with item text displayed',
        (tester) async {
      const items = ['First goal', 'Second goal', 'Third goal'];
      await tester.pumpWidget(_wrap(const BulletList(items: items)));

      for (final item in items) {
        expect(find.text(item), findsOneWidget);
      }

      final rows = find.descendant(
        of: find.byType(BulletList),
        matching: find.byType(Row),
      );
      expect(rows, findsNWidgets(items.length));
    });

    testWidgets('renders a "· " bullet before each item', (tester) async {
      const items = ['Alpha', 'Beta'];
      await tester.pumpWidget(_wrap(const BulletList(items: items)));

      expect(find.text('· '), findsNWidgets(items.length));
    });

    testWidgets('renders no item children when items list is empty',
        (tester) async {
      await tester.pumpWidget(_wrap(const BulletList(items: [])));

      expect(
        find.descendant(
          of: find.byType(BulletList),
          matching: find.byType(Row),
        ),
        findsNothing,
      );
      expect(find.text('· '), findsNothing);
    });

    testWidgets('bullet character uses AppColors.onSurfaceVariant',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const BulletList(items: ['only item'])),
      );

      final bullet = tester.widget<Text>(find.text('· '));
      expect(bullet.style?.color, equals(AppColors.onSurfaceVariant));
    });
  });
}
