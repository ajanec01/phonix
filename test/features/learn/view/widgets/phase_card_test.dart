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

Container _stripeContainer(WidgetTester tester) => tester.widget<Container>(
      find.byWidgetPredicate(
        (w) => w is Container && w.constraints?.maxWidth == 4,
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

    group('Option A stripe colour rule', () {
      // Phases 1–3: original phaseN falls below 3:1 → use phaseNOnLight.
      // Phases 4–6: original phaseN already clears 3:1 → keep phaseN.

      testWidgets('phase 1 stripe uses phase1OnLight', (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(1))));
        expect(_stripeContainer(tester).color, AppColors.phase1OnLight);
      });

      testWidgets('phase 2 stripe uses phase2OnLight', (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(2))));
        expect(_stripeContainer(tester).color, AppColors.phase2OnLight);
      });

      testWidgets('phase 3 stripe uses phase3OnLight', (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(3))));
        expect(_stripeContainer(tester).color, AppColors.phase3OnLight);
      });

      testWidgets('phase 4 stripe uses original phase4 (already clears 3:1)',
          (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(4))));
        expect(_stripeContainer(tester).color, AppColors.phase4);
      });

      testWidgets('phase 5 stripe uses original phase5 (already clears 3:1)',
          (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(5))));
        expect(_stripeContainer(tester).color, AppColors.phase5);
      });

      testWidgets('phase 6 stripe uses original phase6 (already clears 3:1)',
          (tester) async {
        await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(6))));
        expect(_stripeContainer(tester).color, AppColors.phase6);
      });
    });
  });
}
