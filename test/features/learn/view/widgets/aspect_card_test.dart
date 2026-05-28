import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/view/screens/aspect_screen.dart';
import 'package:phonix/features/learn/view/widgets/aspect_card.dart';
import 'package:phonix/theme/app_colors.dart';

class _RecordingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushed = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route);
  }
}

Aspect _aspect({
  String iconKey = 'ear',
  String title = 'Listening Walk',
  String description = 'Tune into sounds around you.',
  String activityLabel = 'Activity',
}) =>
    Aspect(
      number: 1,
      title: title,
      description: description,
      activityLabel: activityLabel,
      iconKey: iconKey,
      parentGuide: 'guide',
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
  group('AspectCard', () {
    testWidgets('renders title, description, and activity label',
        (tester) async {
      final aspect = _aspect();
      await tester.pumpWidget(
        _wrap(AspectCard(aspect: aspect, color: AppColors.phase1)),
      );

      expect(find.text(aspect.title), findsOneWidget);
      expect(find.text(aspect.description), findsOneWidget);
      expect(find.text(aspect.activityLabel), findsOneWidget);
    });

    testWidgets('icon box background is supplied color at 12% opacity',
        (tester) async {
      const color = AppColors.phase3;
      await tester.pumpWidget(
        _wrap(AspectCard(aspect: _aspect(), color: color)),
      );

      final expectedColor = color.withValues(alpha: 0.12);
      final iconBox = tester.widget<Container>(
        find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.constraints?.maxWidth == 42 &&
              w.constraints?.maxHeight == 42,
        ),
      );
      final decoration = iconBox.decoration as BoxDecoration;
      expect(decoration.color, equals(expectedColor));
    });

    testWidgets('renders Icon for iconKey "ear"', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AspectCard(
            aspect: _aspect(iconKey: 'ear'),
            color: AppColors.phase1,
          ),
        ),
      );

      final icon = tester.widget<Icon>(
        find.descendant(
          of: find.byType(AspectCard),
          matching: find.byIcon(CupertinoIcons.ear),
        ),
      );
      expect(icon.icon, CupertinoIcons.ear);
    });

    testWidgets('renders Icon for iconKey "music_note"', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AspectCard(
            aspect: _aspect(iconKey: 'music_note'),
            color: AppColors.phase2,
          ),
        ),
      );

      final icon = tester.widget<Icon>(
        find.descendant(
          of: find.byType(AspectCard),
          matching: find.byIcon(CupertinoIcons.music_note),
        ),
      );
      expect(icon.icon, CupertinoIcons.music_note);
    });

    testWidgets('activity tag text is styled with the supplied color',
        (tester) async {
      const color = AppColors.phase4;
      const activityLabel = 'Game';
      await tester.pumpWidget(
        _wrap(
          AspectCard(
            aspect: _aspect(activityLabel: activityLabel),
            color: color,
          ),
        ),
      );

      final text = tester.widget<Text>(find.text(activityLabel));
      expect(text.style?.color, equals(color));
    });

    testWidgets('tapping pushes a CupertinoPageRoute to AspectScreen',
        (tester) async {
      final aspect = _aspect();
      const color = AppColors.phase1;
      final observer = _RecordingNavigatorObserver();
      await tester.pumpWidget(
        _wrap(
          AspectCard(aspect: aspect, color: color),
          observer: observer,
        ),
      );

      await tester.tap(find.byType(AspectCard));

      final routes = observer.pushed.whereType<CupertinoPageRoute>().toList();
      expect(routes, hasLength(1));

      final context = tester.element(find.byType(MaterialApp));
      final built = routes.single.builder(context);
      expect(built, isA<AspectScreen>());
      final screen = built as AspectScreen;
      expect(screen.aspect, same(aspect));
      expect(screen.color, equals(color));
    });

    testWidgets(
        'Semantics node is a button with a tap action and merges title, activity label, and description',
        (tester) async {
      final handle = tester.ensureSemantics();
      final aspect = _aspect(
        title: 'Rhyming Games',
        description: 'Play with rhymes.',
        activityLabel: 'Game',
      );
      await tester.pumpWidget(
        _wrap(AspectCard(aspect: aspect, color: AppColors.phase1)),
      );

      final node = tester.getSemantics(find.byType(AspectCard));
      expect(
        node,
        containsSemantics(isButton: true, hasTapAction: true),
      );
      expect(node, containsSemantics(label: aspect.title));
      expect(node, containsSemantics(label: aspect.activityLabel));
      expect(node, containsSemantics(label: aspect.description));

      handle.dispose();
    });
  });
}
