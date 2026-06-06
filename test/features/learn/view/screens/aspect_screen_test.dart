import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/view/screens/aspect_screen.dart';
import 'package:phonix/theme/app_colors.dart';

Aspect _aspect({
  int number = 1,
  String iconKey = 'ear',
  String title = 'Listening Walk',
  String description = 'Tune into sounds around you.',
  String activityLabel = 'Game',
}) =>
    Aspect(
      number: number,
      title: title,
      description: description,
      activityLabel: activityLabel,
      iconKey: iconKey,
      parentGuide: 'guide',
    );

Widget _wrap(Widget child) => MaterialApp(home: child);

void main() {
  group('AspectScreen', () {
    testWidgets('renders title, description, and activity label',
        (tester) async {
      final aspect = _aspect();
      await tester.pumpWidget(
        _wrap(AspectScreen(
          aspect: aspect,
          color: AppColors.phase1,
          foregroundColor: AppColors.phase1OnLight,
        )),
      );

      // Description appears in both the header card and the placeholder.
      expect(find.text(aspect.description), findsWidgets);
      expect(find.text(aspect.activityLabel), findsOneWidget);
      expect(find.text('Activity'), findsOneWidget);
    });

    testWidgets('header icon box uses the supplied color at 12% opacity',
        (tester) async {
      await tester.pumpWidget(
        _wrap(AspectScreen(
          aspect: _aspect(),
          color: AppColors.phase3,
          foregroundColor: AppColors.phase3OnLight,
        )),
      );

      final iconBox = tester.widget<Container>(
        find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.constraints?.maxWidth == 52 &&
              w.constraints?.maxHeight == 52,
        ),
      );
      final decoration = iconBox.decoration as BoxDecoration;
      expect(
          decoration.color, equals(AppColors.phase3.withValues(alpha: 0.12)));
    });

    group('foreground colour uses phaseNOnLight, not phaseN', () {
      for (final entry in <int, Color>{
        1: AppColors.phase1OnLight,
        2: AppColors.phase2OnLight,
        3: AppColors.phase3OnLight,
        4: AppColors.phase4,
        5: AppColors.phase5OnLight,
        6: AppColors.phase6OnLight,
      }.entries) {
        testWidgets(
            'phase ${entry.key}: header icon, activity tag text, and large placeholder icon use phaseNOnLight',
            (tester) async {
          final phaseIdx = entry.key - 1;
          final aspect = _aspect(activityLabel: 'Game');
          await tester.pumpWidget(
            _wrap(AspectScreen(
              aspect: aspect,
              color: AppColors.phases[phaseIdx],
              foregroundColor: AppColors.phasesOnLight[phaseIdx],
            )),
          );

          // Header icon (size 26)
          final headerIcon = tester.widget<Icon>(
            find.byWidgetPredicate((w) => w is Icon && w.size == 26),
          );
          expect(headerIcon.color, equals(entry.value),
              reason: 'phase ${entry.key} header icon must use phaseNOnLight');

          // Activity tag label text
          final tagText = tester.widget<Text>(find.text('Game'));
          expect(tagText.style?.color, equals(entry.value),
              reason: 'phase ${entry.key} activity tag must use phaseNOnLight');

          // Large placeholder icon (size 48)
          final placeholderIcon = tester.widget<Icon>(
            find.byWidgetPredicate((w) => w is Icon && w.size == 48),
          );
          expect(placeholderIcon.color, equals(entry.value),
              reason:
                  'phase ${entry.key} large placeholder icon must use phaseNOnLight');
        });
      }
    });

    testWidgets('renders the parent guide section header', (tester) async {
      await tester.pumpWidget(
        _wrap(AspectScreen(
          aspect: _aspect(),
          color: AppColors.phase1,
          foregroundColor: AppColors.phase1OnLight,
        )),
      );

      expect(find.text('For Parents'), findsOneWidget);
    });

    testWidgets('tapping the parent guide header toggles its expanded state',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _wrap(AspectScreen(
          aspect: _aspect(),
          color: AppColors.phase1,
          foregroundColor: AppColors.phase1OnLight,
        )),
      );
      await tester.pumpAndSettle();

      expect(find.text('guide'), findsNothing);

      await tester.tap(find.text('For Parents'));
      await tester.pumpAndSettle();

      expect(find.text('guide'), findsOneWidget);

      await tester.tap(find.text('For Parents'));
      await tester.pumpAndSettle();

      expect(find.text('guide'), findsNothing);
    });

    testWidgets('renders Cupertino ear icon for iconKey "ear"',
        (tester) async {
      await tester.pumpWidget(
        _wrap(AspectScreen(
          aspect: _aspect(iconKey: 'ear'),
          color: AppColors.phase1,
          foregroundColor: AppColors.phase1OnLight,
        )),
      );
      expect(find.byIcon(CupertinoIcons.ear), findsWidgets);
    });
  });
}
