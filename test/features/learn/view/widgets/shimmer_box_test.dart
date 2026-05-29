import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/view/widgets/shimmer_box.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('ShimmerBox', () {
    testWidgets('renders a Container with the specified height',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 80, radius: 8)),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ShimmerBox),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, equals(80));
      expect(container.constraints?.minHeight, equals(80));
    });

    testWidgets('Container decoration uses BorderRadius.circular(radius)',
        (tester) async {
      const radius = 14.0;
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 40, radius: radius)),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ShimmerBox),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, equals(BorderRadius.circular(radius)));
    });

    testWidgets('Container width matches the supplied width when provided',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 20, radius: 4, width: 56)),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ShimmerBox),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxWidth, equals(56));
      expect(container.constraints?.minWidth, equals(56));
    });

    testWidgets(
        'renders without a fixed width constraint when width is omitted',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 30, radius: 6)),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ShimmerBox),
          matching: find.byType(Container),
        ),
      );
      // When width is null, Container has only a height constraint —
      // there is no min/max width pinning the box.
      final constraints = container.constraints!;
      expect(constraints.minWidth, equals(0));
      expect(constraints.maxWidth, equals(double.infinity));
    });
  });
}
