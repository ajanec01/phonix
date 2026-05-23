import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:phonix/features/learn/data/repository/curriculum_repository.dart';
import 'package:phonix/features/learn/data/service/local_curriculum_service.dart';
import 'package:phonix/features/learn/data/service/remote_curriculum_service.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/view/screens/phase_screen.dart';
import 'package:phonix/features/learn/view/widgets/aspect_card.dart';
import 'package:phonix/features/learn/view/widgets/bullet_list.dart';
import 'package:phonix/features/learn/viewmodel/aspect_state.dart';
import 'package:phonix/features/learn/viewmodel/aspect_viewmodel.dart';

// ---------------------------------------------------------------------------
// Fake repository (no-op; never called — load() is overridden)
// ---------------------------------------------------------------------------

class _FakeCurriculumRepository extends CurriculumRepository {
  _FakeCurriculumRepository()
      : super(
          remote: RemoteCurriculumService(),
          local: LocalCurriculumService(),
        );

  @override
  Future<List<Phase>> getPhases() async => const [];

  @override
  Future<List<Aspect>> getAspects(int phaseNumber) async => const [];
}

// ---------------------------------------------------------------------------
// Fake ViewModel
// ---------------------------------------------------------------------------

class _FakeAspectViewModel extends AspectViewModel {
  _FakeAspectViewModel(AspectState seed)
      : super(
          repository: _FakeCurriculumRepository(),
          phaseNumber: 1,
        ) {
    emit(seed);
  }

  @override
  Future<void> load() async {}
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

final _testPhase = Phase(
  id: 1,
  title: 'Phase 1',
  description: 'Rhyme and alliteration',
  about: 'Phase 1 develops listening skills.',
  learningGoals: const ['Goal 1'],
  tipsForHome: const ['Tip 1'],
);

Aspect _aspect(int n) => Aspect(
      number: n,
      title: 'Aspect $n',
      description: 'desc',
      activityLabel: 'activity',
      iconKey: 'rhyme',
      parentGuide: 'guide',
    );

Widget _wrap(AspectViewModel vm) => MaterialApp(
      home: PhaseScreen(phase: _testPhase, viewModel: vm),
    );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('PhaseScreen', () {
    testWidgets('AspectStateLoading shows shimmer loading widget', (tester) async {
      final vm = _FakeAspectViewModel(AspectStateLoading());
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(Shimmer), findsWidgets);
    });

    testWidgets('AspectStateLoaded with empty list renders no AspectCards', (tester) async {
      final vm = _FakeAspectViewModel(AspectStateLoaded(aspects: const []));
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(AspectCard), findsNothing);
      expect(find.byType(Shimmer), findsNothing);
    });

    testWidgets('AspectStateLoaded with non-empty list renders AspectCards', (tester) async {
      final aspects = [_aspect(1), _aspect(2), _aspect(3)];
      final vm = _FakeAspectViewModel(AspectStateLoaded(aspects: aspects));
      await tester.pumpWidget(_wrap(vm));
      await tester.pump();

      expect(find.byType(AspectCard), findsNWidgets(aspects.length));
    });

    testWidgets('AspectStateError renders no AspectCards', (tester) async {
      final vm = _FakeAspectViewModel(
        AspectStateError(message: 'Could not load activities. Please try again.'),
      );
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(AspectCard), findsNothing);
      expect(find.byType(Shimmer), findsNothing);
    });

    testWidgets('briefing card collapses when header is tapped', (tester) async {
      final vm = _FakeAspectViewModel(AspectStateLoading());
      await tester.pumpWidget(_wrap(vm));

      // Briefing content is visible initially (expanded = true).
      expect(find.text(_testPhase.about), findsOneWidget);

      // Tap the About header to collapse.
      await tester.tap(find.text('About ${_testPhase.title}'));
      await tester.pumpAndSettle();

      // Briefing content is now hidden (expanded = false).
      expect(find.text(_testPhase.about), findsNothing);
    });

    testWidgets('tips section expands when tapped and shows bullet list', (tester) async {
      final vm = _FakeAspectViewModel(AspectStateLoading());
      await tester.pumpWidget(_wrap(vm));

      // Tips content is hidden initially (_expanded = false).
      expect(find.byType(BulletList), findsOneWidget); // learningGoals BulletList
      expect(find.text('Tip 1'), findsNothing);

      // Tap the tips header to expand.
      await tester.tap(find.text('Tips for home'));
      await tester.pumpAndSettle();

      // Tips bullet list is now visible.
      expect(find.text('Tip 1'), findsOneWidget);
    });
  });
}
