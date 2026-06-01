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

Container _container(WidgetTester tester) => tester.widget<Container>(
      find.descendant(
        of: find.byType(ShimmerBox),
        matching: find.byType(Container),
      ),
    );

void main() {
  group('ShimmerBox', () {
    testWidgets('renders a Container with the specified height',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 42, radius: 8)),
      );

      final container = _container(tester);
      expect(container.constraints?.maxHeight, 42);
      expect(container.constraints?.minHeight, 42);
    });

    testWidgets('renders a Container with BorderRadius.circular(radius)',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 10, radius: 16)),
      );

      final decoration = _container(tester).decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(16));
    });

    testWidgets("Container's width matches the provided width",
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 20, radius: 4, width: 120)),
      );

      final container = _container(tester);
      expect(container.constraints?.maxWidth, 120);
      expect(container.constraints?.minWidth, 120);
    });

    testWidgets('omitting width leaves no fixed width constraint',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const ShimmerBox(height: 20, radius: 4)),
      );

      final container = _container(tester);
      expect(container.constraints?.hasBoundedWidth, isFalse);
    });
  });
}
