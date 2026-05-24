import 'package:flutter_test/flutter_test.dart';
import 'package:phonix/features/learn/data/repository/curriculum_repository.dart';
import 'package:phonix/features/learn/data/service/local_curriculum_service.dart';
import 'package:phonix/features/learn/data/service/remote_curriculum_service.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/viewmodel/aspect_state.dart';
import 'package:phonix/features/learn/viewmodel/aspect_viewmodel.dart';

// ---------------------------------------------------------------------------
// Fake repository
// ---------------------------------------------------------------------------

class _FakeCurriculumRepository extends CurriculumRepository {
  _FakeCurriculumRepository({
    List<Aspect>? aspects,
    bool throws = false,
  })  : _aspects = aspects ?? const [],
        _throws = throws,
        super(
          remote: RemoteCurriculumService(),
          local: LocalCurriculumService(),
        );

  final List<Aspect> _aspects;
  final bool _throws;

  @override
  Future<List<Aspect>> getAspects(int phaseNumber) async {
    if (_throws) throw Exception('network failure');
    return _aspects;
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Aspect _aspect(int number) => Aspect(
      number: number,
      title: 'Aspect $number',
      description: 'desc $number',
      activityLabel: 'activity $number',
      iconKey: 'icon_$number',
      parentGuide: 'guide $number',
    );

AspectViewModel _makeViewModel({
  List<Aspect>? aspects,
  bool throws = false,
  int phaseNumber = 1,
}) {
  return AspectViewModel(
    repository: _FakeCurriculumRepository(
      aspects: aspects,
      throws: throws,
    ),
    phaseNumber: phaseNumber,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('AspectViewModel', () {
    test('initial state is AspectStateLoading before load() is called', () {
      final vm = _makeViewModel();
      expect(vm.state, isA<AspectStateLoading>());
      vm.dispose();
    });

    test('load() — success: emits Loading then Loaded with correct aspects', () async {
      final aspects = [_aspect(1), _aspect(2), _aspect(3)];
      final vm = _makeViewModel(aspects: aspects);

      final states = <AspectState>[];
      vm.addListener(() => states.add(vm.state));

      await vm.load();

      expect(states.length, 2);
      expect(states[0], isA<AspectStateLoading>());
      final loaded = states[1] as AspectStateLoaded;
      expect(loaded.aspects, aspects);
      expect(vm.state, isA<AspectStateLoaded>());
      vm.dispose();
    });

    test('load() — repository throws: emits Loading then Error with correct message', () async {
      final vm = _makeViewModel(throws: true);

      final states = <AspectState>[];
      vm.addListener(() => states.add(vm.state));

      await vm.load();

      expect(states.length, 2);
      expect(states[0], isA<AspectStateLoading>());
      final error = states[1] as AspectStateError;
      expect(error.message, 'Could not load activities. Please try again.');
      expect(vm.state, isA<AspectStateError>());
      vm.dispose();
    });

    test('state getter reflects last emitted state after load()', () async {
      final vm = _makeViewModel(aspects: [_aspect(1)]);
      expect(vm.state, isA<AspectStateLoading>());

      await vm.load();

      expect(vm.state, isA<AspectStateLoaded>());
      vm.dispose();
    });

    test('second load() call re-emits AspectStateLoading before next outcome', () async {
      final vm = _makeViewModel(aspects: [_aspect(1)]);

      await vm.load();
      expect(vm.state, isA<AspectStateLoaded>());

      final states = <AspectState>[];
      vm.addListener(() => states.add(vm.state));

      await vm.load();

      expect(states.first, isA<AspectStateLoading>());
      expect(states.last, isA<AspectStateLoaded>());
      vm.dispose();
    });

    test('listener is notified exactly twice per successful load() call', () async {
      final vm = _makeViewModel(aspects: [_aspect(1)]);
      int count = 0;
      vm.addListener(() => count++);

      await vm.load();

      expect(count, 2);
      vm.dispose();
    });

    test('listener is notified exactly twice per failed load() call', () async {
      final vm = _makeViewModel(throws: true);
      int count = 0;
      vm.addListener(() => count++);

      await vm.load();

      expect(count, 2);
      vm.dispose();
    });
  });
}
