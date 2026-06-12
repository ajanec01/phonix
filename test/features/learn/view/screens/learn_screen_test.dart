import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/data/repository/curriculum_repository.dart';
import 'package:phonix/features/learn/data/repository/progress_repository.dart';
import 'package:phonix/features/learn/data/service/local_curriculum_service.dart';
import 'package:phonix/features/learn/data/service/local_progress_service.dart';
import 'package:phonix/features/learn/data/service/remote_curriculum_service.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/domain/model/user_progress.dart';
import 'package:phonix/features/learn/view/screens/learn_screen.dart';
import 'package:phonix/features/learn/view/widgets/learn_content.dart';
import 'package:phonix/features/learn/view/widgets/learn_error.dart';
import 'package:phonix/features/learn/view/widgets/learn_skeleton.dart';
import 'package:phonix/features/learn/viewmodel/learn_state.dart';
import 'package:phonix/features/learn/viewmodel/learn_viewmodel.dart';
import 'package:phonix/theme/app_colors.dart';

// ---------------------------------------------------------------------------
// Fake repositories (no-op; never called — load() is overridden)
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

class _FakeProgressRepository extends ProgressRepository {
  _FakeProgressRepository() : super(local: LocalProgressService());

  @override
  Future<UserProgress> getProgress() async => const UserProgress();
}

// ---------------------------------------------------------------------------
// Fake ViewModel
// ---------------------------------------------------------------------------

class _FakeLearnViewModel extends LearnViewModel {
  _FakeLearnViewModel(LearnState seed)
      : super(
          curriculumRepository: _FakeCurriculumRepository(),
          progressRepository: _FakeProgressRepository(),
        ) {
    emit(seed);
  }

  @override
  Future<void> load() async {}
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Phase _phase(int id) => Phase(
      id: id,
      title: 'Phase $id',
      description: 'desc',
      about: 'about',
      learningGoals: const [],
      tipsForHome: const [],
    );

Widget _wrap(LearnViewModel vm,
        {Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: LearnScreen(viewModel: vm),
    );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('LearnScreen', () {
    testWidgets('LearnStateLoading shows LearnSkeleton', (tester) async {
      final vm = _FakeLearnViewModel(LearnStateLoading());
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(LearnSkeleton), findsOneWidget);
      expect(find.byType(LearnContent), findsNothing);
      expect(find.byType(LearnError), findsNothing);
    });

    testWidgets('LearnStateLoaded shows LearnContent with correct data', (tester) async {
      final phases = [_phase(1), _phase(2)];
      final currentPhase = phases[0];
      final vm = _FakeLearnViewModel(
        LearnStateLoaded(phases: phases, currentPhase: currentPhase),
      );
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(LearnContent), findsOneWidget);
      final widget = tester.widget<LearnContent>(find.byType(LearnContent));
      expect(widget.phases, phases);
      expect(widget.currentPhase, currentPhase);
      expect(find.byType(LearnSkeleton), findsNothing);
      expect(find.byType(LearnError), findsNothing);
    });

    testWidgets(
        'Brightness.dark: scaffold uses surfaceContainerLowDark',
        (tester) async {
      final vm = _FakeLearnViewModel(LearnStateLoading());
      await tester.pumpWidget(_wrap(vm, brightness: Brightness.dark));

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppColors.surfaceContainerLowDark);
    });

    testWidgets('LearnStateError shows LearnError with message', (tester) async {
      const message = 'Could not load content. Please try again.';
      final vm = _FakeLearnViewModel(LearnStateError(message: message));
      await tester.pumpWidget(_wrap(vm));

      expect(find.byType(LearnError), findsOneWidget);
      expect(find.text(message), findsOneWidget);
      expect(find.byType(LearnSkeleton), findsNothing);
      expect(find.byType(LearnContent), findsNothing);
    });
  });
}
