import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/core/widgets/semantic_button.dart';
import 'package:phonix/features/learn/view/widgets/parent_guide_card.dart';
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
  group('ParentGuideCard', () {
    testWidgets('renders the header text "For Parents"', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'Guide body.',
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('For Parents'), findsOneWidget);
    });

    testWidgets('collapsed: does not render the guide body', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'Guide body text.',
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('Guide body text.'), findsNothing);
    });

    testWidgets('expanded: renders the guide body', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'Guide body text.',
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('Guide body text.'), findsOneWidget);
    });

    testWidgets('chevron is chevron_down when collapsed', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(ParentGuideCard),
          matching: find.byIcon(CupertinoIcons.chevron_down),
        ),
        findsOneWidget,
      );
    });

    testWidgets('chevron is chevron_up when expanded', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(ParentGuideCard),
          matching: find.byIcon(CupertinoIcons.chevron_up),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Semantics label is "Expand For Parents" when collapsed',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(node, isSemantics(isButton: true));
      expect(
        node.getSemanticsData().label,
        contains('Expand For Parents'),
      );
      expect(
        node.getSemanticsData().label,
        isNot(contains('Collapse')),
      );

      handle.dispose();
    });

    testWidgets('Semantics label is "Collapse For Parents" when expanded',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(node, isSemantics(isButton: true));
      expect(
        node.getSemanticsData().label,
        contains('Collapse For Parents'),
      );
      expect(
        node.getSemanticsData().label,
        isNot(contains('Expand')),
      );

      handle.dispose();
    });

    testWidgets('tapping the header calls onToggle', (tester) async {
      int taps = 0;
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: false,
            onToggle: () => taps++,
          ),
        ),
      );

      await tester.tap(find.byType(SemanticButton));
      expect(taps, 1);
    });

    testWidgets(
        'keyboard: focusing the header and pressing Space invokes onToggle',
        (tester) async {
      int taps = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: false,
            onToggle: () => taps++,
            headerFocusNode: focusNode,
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

    testWidgets(
        'keyboard: focusing the header and pressing Enter invokes onToggle',
        (tester) async {
      int taps = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: true,
            onToggle: () => taps++,
            headerFocusNode: focusNode,
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
        'keyboard: Space then Enter toggles label between expand and collapse',
        (tester) async {
      final handle = tester.ensureSemantics();
      bool expanded = false;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => _wrap(
            ParentGuideCard(
              guide: 'g',
              expanded: expanded,
              onToggle: () => setState(() => expanded = !expanded),
              headerFocusNode: focusNode,
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      String label() => tester
          .getSemantics(find.byType(SemanticButton))
          .getSemanticsData()
          .label;

      expect(label(), contains('Expand For Parents'));

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(label(), contains('Collapse For Parents'));

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(label(), contains('Expand For Parents'));

      handle.dispose();
    });

    testWidgets('background uses AppColors.secondaryContainer',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          ParentGuideCard(
            guide: 'g',
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(ParentGuideCard),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.secondaryContainer);
    });
  });
}
