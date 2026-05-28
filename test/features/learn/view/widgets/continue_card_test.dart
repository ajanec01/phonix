import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/view/screens/phase_screen.dart';
import 'package:phonix/features/learn/view/widgets/continue_card.dart';
import 'package:phonix/theme/app_colors.dart';

class _RecordingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushed = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route);
  }
}

Phase _phase({int id = 1}) => Phase(
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
  group('ContinueCard', () {
    testWidgets('renders the literal text "Continue"', (tester) async {
      await tester.pumpWidget(_wrap(ContinueCard(phase: _phase())));

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders phase title and description', (tester) async {
      final phase = _phase(id: 2);
      await tester.pumpWidget(_wrap(ContinueCard(phase: phase)));

      expect(find.text(phase.title), findsOneWidget);
      expect(find.text(phase.description), findsOneWidget);
    });

    testWidgets('outer container background uses AppColors.secondary',
        (tester) async {
      await tester.pumpWidget(_wrap(ContinueCard(phase: _phase())));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ContinueCard),
          matching: find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).color == AppColors.secondary,
          ),
        ),
      );
      expect(
        (container.decoration as BoxDecoration).color,
        equals(AppColors.secondary),
      );
    });

    testWidgets(
        'Semantics node exposes "Continue <title>" label with description as hint and button: true',
        (tester) async {
      final handle = tester.ensureSemantics();
      final phase = _phase(id: 3);
      await tester.pumpWidget(_wrap(ContinueCard(phase: phase)));

      expect(
        tester.getSemantics(find.byType(ContinueCard)),
        matchesSemantics(
          label: 'Continue ${phase.title}',
          hint: phase.description,
          isButton: true,
          hasTapAction: true,
        ),
      );

      handle.dispose();
    });

    testWidgets('tapping pushes a CupertinoPageRoute to PhaseScreen',
        (tester) async {
      final phase = _phase();
      final observer = _RecordingNavigatorObserver();
      await tester
          .pumpWidget(_wrap(ContinueCard(phase: phase), observer: observer));

      await tester.tap(find.byType(ContinueCard));

      final routes = observer.pushed.whereType<CupertinoPageRoute>().toList();
      expect(routes, hasLength(1));

      final context = tester.element(find.byType(MaterialApp));
      final built = routes.single.builder(context);
      expect(built, isA<PhaseScreen>());
      expect((built as PhaseScreen).phase, same(phase));
    });
  });
}
