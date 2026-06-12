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

Widget _wrap(Widget child,
        {NavigatorObserver? observer,
        Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: ThemeData(brightness: brightness),
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

    group('Option B stripe colour rule', () {
      // All six phases use phaseNOnLight for the 4px decorative stripe — the
      // uniform-token rule applies to every phase regardless of whether the
      // original cleared 3:1.

      for (final id in [1, 2, 3, 4, 5, 6]) {
        testWidgets('phase $id stripe uses phase${id}OnLight', (tester) async {
          await tester.pumpWidget(_wrap(PhaseCard(phase: _phase(id))));
          expect(
            _stripeContainer(tester).color,
            equals(AppColors.phasesOnLight[id - 1]),
            reason:
                'phase $id stripe must use phaseNOnLight under Option B (uniform rule)',
          );
        });
      }
    });

    group('Brightness.dark — phase surface and foreground tokens', () {
      for (final id in [1, 2, 3, 4, 5, 6]) {
        testWidgets('phase $id stripe uses phasesOnDark[$id-1]',
            (tester) async {
          await tester.pumpWidget(
            _wrap(PhaseCard(phase: _phase(id)),
                brightness: Brightness.dark),
          );
          expect(
            _stripeContainer(tester).color,
            equals(AppColors.phasesOnDark[id - 1]),
            reason:
                'phase $id stripe must use phasesOnDark[$id-1] in Brightness.dark',
          );
        });
      }

      testWidgets('card face uses surfaceContainerLowestDark', (tester) async {
        await tester.pumpWidget(
          _wrap(PhaseCard(phase: _phase(1)), brightness: Brightness.dark),
        );
        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(PhaseCard),
            matching: find.byWidgetPredicate(
              (w) =>
                  w is Container &&
                  w.decoration is BoxDecoration &&
                  (w.decoration as BoxDecoration).color != null,
            ),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, AppColors.surfaceContainerLowestDark);
        expect(decoration.border, isA<Border>());
      });
    });
  });
}
