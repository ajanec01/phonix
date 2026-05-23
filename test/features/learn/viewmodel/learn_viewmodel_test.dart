import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/data/repository/curriculum_repository.dart';
import 'package:phonix/features/learn/data/repository/progress_repository.dart';
import 'package:phonix/features/learn/data/service/local_curriculum_service.dart';
import 'package:phonix/features/learn/data/service/local_progress_service.dart';
import 'package:phonix/features/learn/data/service/remote_curriculum_service.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';
import 'package:phonix/features/learn/domain/model/user_progress.dart';
import 'package:phonix/features/learn/viewmodel/learn_state.dart';
import 'package:phonix/features/learn/viewmodel/learn_viewmodel.dart';

// ---------------------------------------------------------------------------
// Fake repositories
// ---------------------------------------------------------------------------

class _FakeCurriculumRepository extends CurriculumRepository {
  _FakeCurriculumRepository({
    List<Phase>? phases,
    bool throws = false,
  })  : _phases = phases ?? const [],
        _throws = throws,
        super(
          remote: RemoteCurriculumService(),
          local: LocalCurriculumService(),
        );

  final List<Phase> _phases;
  final bool _throws;

  @override
  Future<List<Phase>> getPhases() async {
    if (_throws) throw Exception('network failure');
    return _phases;
  }

  @override
  Future<List<Aspect>> getAspects(int phaseNumber) async => const [];
}

class _FakeProgressRepository extends ProgressRepository {
  _FakeProgressRepository(this._progress)
      : super(local: LocalProgressService());

  final UserProgress _progress;

  @override
  Future<UserProgress> getProgress() async => _progress;
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Phase _phase(int id) => Phase(
      id: id,
      title: 'Phase $id',
      description: 'desc $id',
      about: 'about $id',
      learningGoals: const [],
      tipsForHome: const [],
    );

LearnViewModel _makeViewModel({
  List<Phase>? phases,
  UserProgress progress = const UserProgress(),
  bool throws = false,
}) {
  return LearnViewModel(
    curriculumRepository: _FakeCurriculumRepository(
      phases: phases,
      throws: throws,
    ),
    progressRepository: _FakeProgressRepository(progress),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('LearnViewModel', () {
    test('initial state is LearnStateLoading before load() is called', () {
      final vm = _makeViewModel();
      expect(vm.state, isA<LearnStateLoading>());
      vm.dispose();
    });

    test('load() — success, currentPhaseId null: final state has currentPhase null', () async {
      final phases = [_phase(1), _phase(2)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: null),
      );

      final states = <LearnState>[];
      vm.addListener(() => states.add(vm.state));

      await vm.load();

      expect(states.length, 2);
      expect(states[0], isA<LearnStateLoading>());
      final loaded = states[1] as LearnStateLoaded;
      expect(loaded.phases, phases);
      expect(loaded.currentPhase, isNull);
      expect(vm.state, isA<LearnStateLoaded>());
      vm.dispose();
    });

    test('load() — success, currentPhaseId matches: currentPhase is that phase', () async {
      final phases = [_phase(1), _phase(2), _phase(3)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: 2),
      );

      await vm.load();

      final state = vm.state as LearnStateLoaded;
      expect(state.currentPhase, phases[1]);
      vm.dispose();
    });

    test('load() — success, currentPhaseId set but no match: currentPhase falls back to phases.first', () async {
      final phases = [_phase(1), _phase(2)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: 99),
      );

      await vm.load();

      final state = vm.state as LearnStateLoaded;
      expect(state.currentPhase, phases.first);
      vm.dispose();
    });

    test('load() — repository throws: final state is LearnStateError with correct message', () async {
      final vm = _makeViewModel(throws: true);

      await vm.load();

      final state = vm.state as LearnStateError;
      expect(state.message, 'Could not load content. Please try again.');
      vm.dispose();
    });

    test('state getter reflects last emitted state after load()', () async {
      final phases = [_phase(1)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: 1),
      );
      expect(vm.state, isA<LearnStateLoading>());

      await vm.load();

      expect(vm.state, isA<LearnStateLoaded>());
      vm.dispose();
    });

    test('second load() call re-emits LearnStateLoading before next outcome', () async {
      final phases = [_phase(1)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: null),
      );

      await vm.load();
      expect(vm.state, isA<LearnStateLoaded>());

      final states = <LearnState>[];
      vm.addListener(() => states.add(vm.state));

      await vm.load();

      expect(states.first, isA<LearnStateLoading>());
      expect(states.last, isA<LearnStateLoaded>());
      vm.dispose();
    });

    test('listener is notified twice per successful load() call', () async {
      final phases = [_phase(1)];
      final vm = _makeViewModel(
        phases: phases,
        progress: const UserProgress(currentPhaseId: null),
      );
      int count = 0;
      vm.addListener(() => count++);

      await vm.load();

      expect(count, 2);
      vm.dispose();
    });
  });
}
