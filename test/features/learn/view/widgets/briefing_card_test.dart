import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/core/widgets/semantic_button.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/view/widgets/briefing_card.dart';
import 'package:phonix/features/learn/view/widgets/tips_section.dart';
import 'package:phonix/theme/app_colors.dart';

Phase _phase({
  int id = 1,
  String title = 'Phase One',
  String about = 'About this phase.',
  List<String> learningGoals = const ['Goal A', 'Goal B'],
  List<String> tipsForHome = const ['Tip 1', 'Tip 2'],
}) =>
    Phase(
      id: id,
      title: title,
      description: 'Description',
      about: about,
      learningGoals: learningGoals,
      tipsForHome: tipsForHome,
    );

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('BriefingCard', () {
    testWidgets('renders the header text "About <title>"', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(title: 'Phase One'),
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('About Phase One'), findsOneWidget);
    });

    testWidgets('collapsed: does not render body content', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(about: 'Body content here.'),
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('Body content here.'), findsNothing);
      expect(find.byType(TipsSection), findsNothing);
    });

    testWidgets('expanded: renders body content, goals, and TipsSection',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(
              about: 'Body content here.',
              learningGoals: ['Goal A'],
              tipsForHome: ['Tip 1'],
            ),
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      expect(find.text('Body content here.'), findsOneWidget);
      expect(find.text('Goal A'), findsOneWidget);
      expect(find.byType(TipsSection), findsOneWidget);
    });

    testWidgets('chevron is chevron_down when collapsed', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(),
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(BriefingCard),
          matching: find.byIcon(CupertinoIcons.chevron_down),
        ),
        findsOneWidget,
      );
    });

    testWidgets('chevron is chevron_up when expanded', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(),
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(BriefingCard),
          matching: find.byIcon(CupertinoIcons.chevron_up),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Semantics label is "Expand About <title>" when collapsed',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(title: 'Phase One'),
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton).first);
      expect(node, isSemantics(isButton: true));
      expect(node.getSemanticsData().label, contains('Expand About Phase One'));
      expect(
        node.getSemanticsData().label,
        isNot(contains('Collapse')),
      );

      handle.dispose();
    });

    testWidgets('Semantics label is "Collapse About <title>" when expanded',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(title: 'Phase Two'),
            expanded: true,
            onToggle: () {},
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(SemanticButton).first);
      expect(node, isSemantics(isButton: true));
      expect(
        node.getSemanticsData().label,
        contains('Collapse About Phase Two'),
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
          BriefingCard(
            phase: _phase(),
            expanded: false,
            onToggle: () => taps++,
          ),
        ),
      );

      await tester.tap(find.byType(SemanticButton).first);
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
          BriefingCard(
            phase: _phase(),
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
          BriefingCard(
            phase: _phase(),
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
            BriefingCard(
              phase: _phase(title: 'Phase One'),
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
          .getSemantics(find.byType(SemanticButton).first)
          .getSemanticsData()
          .label;

      // Initially collapsed
      expect(label(), contains('Expand About Phase One'));

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(label(), contains('Collapse About Phase One'));

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(label(), contains('Expand About Phase One'));

      handle.dispose();
    });

    testWidgets('background uses phase color at 8% opacity', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BriefingCard(
            phase: _phase(id: 1),
            expanded: false,
            onToggle: () {},
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(BriefingCard),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.phases[0].withValues(alpha: 0.08));
    });

    group('foreground colour uses phaseNOnLight, not phaseN', () {
      // Option A: foreground (icon, heading, chevron) must use phaseNOnLight
      // — including for phase4 which reuses its original value via the
      // phasesOnLight[3] alias. This is the contract the criterion 7 stripe
      // and foreground assertions depend on.
      for (final id in [1, 2, 3, 4, 5, 6]) {
        testWidgets('phase $id header icon, heading, and chevron all use '
            'AppColors.phasesOnLight[\$id-1]', (tester) async {
          await tester.pumpWidget(
            _wrap(
              BriefingCard(
                phase: _phase(id: id, title: 'Phase $id'),
                expanded: true,
                onToggle: () {},
              ),
            ),
          );

          final expectedFg = AppColors.phasesOnLight[id - 1];

          // Info-circle icon
          final infoIcon = tester.widget<Icon>(
            find.descendant(
              of: find.byType(BriefingCard),
              matching: find.byIcon(CupertinoIcons.info_circle_fill),
            ),
          );
          expect(infoIcon.color, equals(expectedFg),
              reason: 'phase $id info icon should use phaseNOnLight');

          // Heading text
          final heading = tester.widget<Text>(find.text('About Phase $id'));
          expect(heading.style?.color, equals(expectedFg),
              reason: 'phase $id heading should use phaseNOnLight');

          // Chevron (expanded → chevron_up)
          final chevron = tester.widget<Icon>(
            find.descendant(
              of: find.byType(BriefingCard),
              matching: find.byIcon(CupertinoIcons.chevron_up),
            ),
          );
          expect(chevron.color, equals(expectedFg),
              reason: 'phase $id chevron should use phaseNOnLight');
        });
      }

      testWidgets('each phase heading uses the correct AppColors token',
          (tester) async {
        // Spot-check by exact token (Option A defines OnLight for 1,2,3,5,6
        // and aliases phase4 in the OnLight list).
        for (final entry in <int, Color>{
          1: AppColors.phase1OnLight,
          2: AppColors.phase2OnLight,
          3: AppColors.phase3OnLight,
          4: AppColors.phase4,
          5: AppColors.phase5OnLight,
          6: AppColors.phase6OnLight,
        }.entries) {
          await tester.pumpWidget(
            _wrap(
              BriefingCard(
                phase: _phase(id: entry.key, title: 'Phase ${entry.key}'),
                expanded: false,
                onToggle: () {},
              ),
            ),
          );
          final heading = tester.widget<Text>(
            find.text('About Phase ${entry.key}'),
          );
          expect(heading.style?.color, equals(entry.value),
              reason:
                  'phase ${entry.key} heading must use the corresponding OnLight token');
        }
      });
    });
  });
}
