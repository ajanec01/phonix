import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/stats_row.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('StatsRow', () {
    testWidgets('renders exactly three stat chips', (tester) async {
      await tester.pumpWidget(_wrap(const StatsRow()));

      expect(
        find.descendant(
          of: find.byType(StatsRow),
          matching: find.byType(Expanded),
        ),
        findsNWidgets(3),
      );
    });

    testWidgets('first chip shows value "0" and label "Sounds"', (tester) async {
      await tester.pumpWidget(_wrap(const StatsRow()));

      expect(find.text('Sounds'), findsOneWidget);
      final soundsValue = find.descendant(
        of: find.ancestor(
          of: find.text('Sounds'),
          matching: find.byType(Column),
        ),
        matching: find.text('0'),
      );
      expect(soundsValue, findsWidgets);
    });

    testWidgets('second chip shows value "—" and label "Accuracy"',
        (tester) async {
      await tester.pumpWidget(_wrap(const StatsRow()));

      expect(find.text('Accuracy'), findsOneWidget);
      expect(find.text('—'), findsOneWidget);
    });

    testWidgets('third chip shows value "0" and label "Stars"', (tester) async {
      await tester.pumpWidget(_wrap(const StatsRow()));

      expect(find.text('Stars'), findsOneWidget);
      final starsValue = find.descendant(
        of: find.ancestor(
          of: find.text('Stars'),
          matching: find.byType(Column),
        ),
        matching: find.text('0'),
      );
      expect(starsValue, findsWidgets);
    });

    testWidgets('renders both "0" chips (Sounds and Stars)', (tester) async {
      await tester.pumpWidget(_wrap(const StatsRow()));

      expect(find.text('0'), findsNWidgets(2));
    });
  });
}
