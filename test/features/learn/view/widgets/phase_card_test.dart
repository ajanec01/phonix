import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/view/screens/phase_screen.dart';
import 'package:phonix/features/learn/view/widgets/phase_card.dart';
import 'package:phonix/theme/app_colors.dart';

class _RecordingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushed = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route);
  }
}

Phase _phase(int id) => Phase(
      id: id,
      title: 'Phase $id Title',
      description: 'Phase $id description',
      about: 'about',
      learningGoals: const [],
      tipsForHome: const [],
    );

Widget _wrap(Widget child, {NavigatorObserver? observer}) => MaterialApp(
      navigatorObservers: observer == null ? const [] : [observer],
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('PhaseCard', () {
    testWidgets('renders phase title and description', (tester) async {
      final phase = _phase(2);
      await tester.pumpWidget(_wrap(PhaseCard(phase: phase)));

      expect(find.text(phase.title), findsOneWidget);
      expect(find.text(phase.description), findsOneWidget);
    });

    testWidgets('left border uses AppColors.phases[phase.id - 1] for phase 1',
        (tester) async {
      final phase = _phase(1);
      await tester.pumpWidget(_wrap(PhaseCard(phase: phase)));

      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.color == AppColors.phases[0] &&
              w.constraints?.maxWidth == 4,
        ),
        findsOneWidget,
      );
    });

    testWidgets('left border uses AppColors.phases[phase.id - 1] for phase 4',
        (tester) async {
      final phase = _phase(4);
      await tester.pumpWidget(_wrap(PhaseCard(phase: phase)));

      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.color == AppColors.phases[3] &&
              w.constraints?.maxWidth == 4,
        ),
        findsOneWidget,
      );
    });

    testWidgets('tapping pushes a CupertinoPageRoute to PhaseScreen',
        (tester) async {
      final phase = _phase(1);
      final observer = _RecordingNavigatorObserver();
      await tester
          .pumpWidget(_wrap(PhaseCard(phase: phase), observer: observer));

      await tester.tap(find.byType(PhaseCard));

      final cupertinoRoutes =
          observer.pushed.whereType<CupertinoPageRoute>().toList();
      expect(cupertinoRoutes, hasLength(1));

      final context = tester.element(find.byType(MaterialApp));
      final built = cupertinoRoutes.single.builder(context);
      expect(built, isA<PhaseScreen>());
      expect((built as PhaseScreen).phase, same(phase));
    });

    testWidgets(
        'Semantics node is a button with a tap action and merges title and description',
        (tester) async {
      final handle = tester.ensureSemantics();
      final phase = _phase(3);
      await tester.pumpWidget(_wrap(PhaseCard(phase: phase)));

      final node = tester.getSemantics(find.byType(PhaseCard));
      expect(
        node,
        containsSemantics(isButton: true, hasTapAction: true),
      );
      expect(node, containsSemantics(label: phase.title));
      expect(node, containsSemantics(label: phase.description));

      handle.dispose();
    });
  });
}
