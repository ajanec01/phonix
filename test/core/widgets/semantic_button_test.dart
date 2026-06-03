import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/core/widgets/semantic_button.dart';

Widget _wrap(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme,
  home: Scaffold(body: Center(child: child)),
);

Container _outlineContainer(WidgetTester tester) {
  return tester.widget<Container>(
    find.descendant(
      of: find.byType(SemanticButton),
      matching: find.byType(Container),
    ),
  );
}

Border _outlineBorder(WidgetTester tester) {
  final decoration = _outlineContainer(tester).decoration as BoxDecoration;
  return decoration.border! as Border;
}

void main() {
  group('SemanticButton', () {
    setUp(() {
      // Force keyboard-style focus highlighting so `onShowFocusHighlight` fires
      // for programmatic focus requests in widget tests. Without this the
      // FocusManager stays in `touch` mode and never raises the highlight.
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
    });

    tearDown(() {
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.automatic;
    });

    testWidgets('renders its child', (tester) async {
      await tester.pumpWidget(
        _wrap(SemanticButton(onPressed: () {}, child: const Text('label'))),
      );

      expect(find.text('label'), findsOneWidget);
    });

    testWidgets('invokes onPressed on tap', (tester) async {
      int taps = 0;
      await tester.pumpWidget(
        _wrap(
          SemanticButton(onPressed: () => taps++, child: const Text('label')),
        ),
      );

      await tester.tap(find.byType(SemanticButton));
      expect(taps, 1);
    });

    testWidgets('invokes onPressed when focused and Space is pressed', (
      tester,
    ) async {
      int taps = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () => taps++,
            focusNode: focusNode,
            child: const Text('label'),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(taps, 1);
    });

    testWidgets('invokes onPressed when focused and Enter is pressed', (
      tester,
    ) async {
      int taps = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () => taps++,
            focusNode: focusNode,
            child: const Text('label'),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(taps, 1);
    });

    testWidgets(
      'Is semantically focusable, tappable, and can receive keyboard focus',
      (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          _wrap(SemanticButton(onPressed: () {}, child: const Text('child 1'))),
        );

        final node = tester.getSemantics(find.byType(SemanticButton));
        expect(
          node,
          matchesSemantics(
            label: 'child 1',
            isButton: true,
            hasTapAction: true,
            hasFocusAction: true,
            isFocusable: true,
          ),
        );

        handle.dispose();
      },
    );

    testWidgets('outline is transparent when not focused', (tester) async {
      await tester.pumpWidget(
        _wrap(SemanticButton(onPressed: () {}, child: const Text('label'))),
      );

      final border = _outlineBorder(tester);
      expect(border.top.color, Colors.transparent);
      expect(border.top.width, 2);
    });

    testWidgets('outline is black on a light theme when focused', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            focusNode: focusNode,
            child: const Text('label'),
          ),
          theme: ThemeData.light(),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final border = _outlineBorder(tester);
      expect(border.top.color, Colors.black);
      expect(border.top.width, 2);
    });

    testWidgets('outline is white on a dark theme when focused', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            focusNode: focusNode,
            child: const Text('label'),
          ),
          theme: ThemeData.dark(),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final border = _outlineBorder(tester);
      expect(border.top.color, Colors.white);
      expect(border.top.width, 2);
    });

    testWidgets('applies the supplied borderRadius to the outline', (
      tester,
    ) async {
      final radius = BorderRadius.circular(12);
      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            borderRadius: radius,
            child: const Text('label'),
          ),
        ),
      );

      final decoration = _outlineContainer(tester).decoration as BoxDecoration;
      expect(decoration.borderRadius, radius);
    });

    testWidgets('outline returns to transparent when focus is lost', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            focusNode: focusNode,
            child: const Text('label'),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(_outlineBorder(tester).top.color, Colors.black);

      focusNode.unfocus();
      await tester.pumpAndSettle();
      expect(_outlineBorder(tester).top.color, Colors.transparent);
    });

    testWidgets('semantic node is a button', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            semanticLabel: 'Toggle',
            child: const Text('child text'),
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(node, isSemantics(isButton: true));

      handle.dispose();
    });

    testWidgets(
      'when a semanticLabel is provided, child semantics are excluded',
      (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          _wrap(
            SemanticButton(
              onPressed: () {},
              semanticLabel: 'Override label',
              child: const Text('child text'),
            ),
          ),
        );

        final data = tester
            .getSemantics(find.byType(SemanticButton))
            .getSemanticsData();
        expect(data.label, 'Override label');
        expect(data.label, isNot(contains('child text')));

        handle.dispose();
      },
    );

    testWidgets(
      'when semanticLabel is null, descendant text contributes the label',
      (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          _wrap(
            SemanticButton(onPressed: () {}, child: const Text('child text')),
          ),
        );

        final data = tester
            .getSemantics(find.byType(SemanticButton))
            .getSemanticsData();
        expect(data.label, contains('child text'));

        handle.dispose();
      },
    );

    testWidgets(
      'when semanticLabel is an empty string, descendant text contributes the label',
      (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpWidget(
          _wrap(
            SemanticButton(
              onPressed: () {},
              semanticLabel: '',
              child: const Text('child text'),
            ),
          ),
        );

        final data = tester
            .getSemantics(find.byType(SemanticButton))
            .getSemanticsData();
        expect(data.label, contains('child text'));

        handle.dispose();
      },
    );

    testWidgets('semanticHint is applied to the semantic node', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            semanticLabel: 'Save',
            semanticHint: 'saves your progress',
            child: const Text('child'),
          ),
        ),
      );

      final data = tester
          .getSemantics(find.byType(SemanticButton))
          .getSemanticsData();
      expect(data.hint, 'saves your progress');

      handle.dispose();
    });

    testWidgets('merges descendants semantics when they can be merged', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          SemanticButton(
            onPressed: () {},
            child: Column(
              children: [
                const Text('child 1'),
                Semantics(container: true, child: const Text('child 2')),
              ],
            ),
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(
        node,
        matchesSemantics(
          label: 'child 1',
          isButton: true,
          hasTapAction: true,
          hasFocusAction: true,
          isFocusable: true,
        ),
      );

      handle.dispose();
    });

    testWidgets(
      'focus highlight does not toggle the state when value is unchanged',
      (tester) async {
        // Drives the early-return branch in onShowFocusHighlight where the
        // incoming value equals the current state.
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpWidget(
          _wrap(
            SemanticButton(
              onPressed: () {},
              focusNode: focusNode,
              child: const Text('label'),
            ),
          ),
        );

        // Already unfocused; request unfocus again — no state change, no rebuild
        // crash.
        focusNode.unfocus();
        await tester.pump();

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        // Re-requesting focus does not change the highlight state.
        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(_outlineBorder(tester).top.color, Colors.black);
      },
    );
  });
}
