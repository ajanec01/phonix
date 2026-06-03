import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/core/widgets/semantic_button.dart';
import 'package:phonix/features/learn/view/widgets/bullet_list.dart';
import 'package:phonix/features/learn/view/widgets/tips_section.dart';
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
  group('TipsSection', () {
    testWidgets('renders the header text "Tips for home"', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud'],
          ),
        ),
      );

      expect(find.text('Tips for home'), findsOneWidget);
    });

    testWidgets('starts collapsed: tips are not visible', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud', 'Play sound games'],
          ),
        ),
      );

      expect(find.text('Read aloud'), findsNothing);
      expect(find.text('Play sound games'), findsNothing);
      expect(find.byType(BulletList), findsNothing);
    });

    testWidgets('tapping the header toggles tips visibility', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud'],
          ),
        ),
      );

      await tester.tap(find.text('Tips for home'));
      await tester.pump();

      expect(find.text('Read aloud'), findsOneWidget);
      expect(find.byType(BulletList), findsOneWidget);

      await tester.tap(find.text('Tips for home'));
      await tester.pump();

      expect(find.text('Read aloud'), findsNothing);
    });

    testWidgets('chevron toggles between chevron_down and chevron_up',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud'],
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(TipsSection),
          matching: find.byIcon(CupertinoIcons.chevron_down),
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Tips for home'));
      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(TipsSection),
          matching: find.byIcon(CupertinoIcons.chevron_up),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Semantics label is "Expand tips for home" when collapsed',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud'],
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(node, isSemantics(isButton: true));
      expect(
        node.getSemanticsData().label,
        contains('Expand tips for home'),
      );
      expect(
        node.getSemanticsData().label,
        isNot(contains('Collapse')),
      );

      handle.dispose();
    });

    testWidgets('Semantics label is "Collapse tips for home" when expanded',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase1,
            tips: ['Read aloud'],
          ),
        ),
      );

      await tester.tap(find.text('Tips for home'));
      await tester.pump();

      final node = tester.getSemantics(find.byType(SemanticButton));
      expect(node, isSemantics(isButton: true));
      expect(
        node.getSemanticsData().label,
        contains('Collapse tips for home'),
      );
      expect(
        node.getSemanticsData().label,
        isNot(contains('Expand')),
      );

      handle.dispose();
    });

    testWidgets(
        'keyboard: focusing the header and pressing Space toggles tips',
        (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          TipsSection(
            color: AppColors.phase1,
            tips: const ['Read aloud'],
            focusNode: focusNode,
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(find.text('Read aloud'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(find.text('Read aloud'), findsNothing);
    });

    testWidgets(
        'keyboard: focusing the header and pressing Enter toggles tips',
        (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          TipsSection(
            color: AppColors.phase1,
            tips: const ['Read aloud'],
            focusNode: focusNode,
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(find.text('Read aloud'), findsOneWidget);
    });

    testWidgets(
        'keyboard: Space toggles label between expand and collapse',
        (tester) async {
      final handle = tester.ensureSemantics();
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          TipsSection(
            color: AppColors.phase1,
            tips: const ['Read aloud'],
            focusNode: focusNode,
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      String label() => tester
          .getSemantics(find.byType(SemanticButton))
          .getSemanticsData()
          .label;

      expect(label(), contains('Expand tips for home'));

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(label(), contains('Collapse tips for home'));

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(label(), contains('Expand tips for home'));

      handle.dispose();
    });

    testWidgets('renders all tips when expanded', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: AppColors.phase2,
            tips: ['Alpha', 'Beta', 'Gamma'],
          ),
        ),
      );

      await tester.tap(find.text('Tips for home'));
      await tester.pump();

      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);
    });

    testWidgets('header icon uses supplied color', (tester) async {
      const color = AppColors.phase3;
      await tester.pumpWidget(
        _wrap(
          const TipsSection(
            color: color,
            tips: ['Read aloud'],
          ),
        ),
      );

      final icon = tester.widget<Icon>(
        find.descendant(
          of: find.byType(TipsSection),
          matching: find.byIcon(CupertinoIcons.lightbulb),
        ),
      );
      expect(icon.color, color);
    });
  });
}
