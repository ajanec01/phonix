import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phonix/features/learn/data/repository/curriculum_repository.dart';
import 'package:phonix/features/learn/data/service/local_curriculum_service.dart';
import 'package:phonix/features/learn/data/service/remote_curriculum_service.dart';
import 'package:phonix/features/learn/domain/model/aspect.dart';
import 'package:phonix/features/learn/domain/model/phase.dart';

class MockRemoteCurriculumService extends Mock
    implements RemoteCurriculumService {}

class MockLocalCurriculumService extends Mock
    implements LocalCurriculumService {}

Map<String, dynamic> _phaseJson(int id) => {
      'id': id,
      'title': 'Phase $id title',
      'description': 'Phase $id description',
      'about': 'Phase $id about',
      'learningGoals': ['goal ${id}a', 'goal ${id}b'],
      'tipsForHome': ['tip ${id}a', 'tip ${id}b'],
    };

Map<String, dynamic> _aspectJson(int number) => {
      'number': number,
      'title': 'Aspect $number title',
      'description': 'Aspect $number description',
      'activityLabel': 'Aspect $number activity',
      'icon': 'icon_$number',
      'parentGuide': 'Aspect $number guide',
    };

void main() {
  late MockRemoteCurriculumService remote;
  late MockLocalCurriculumService local;
  late CurriculumRepository repository;

  setUp(() {
    remote = MockRemoteCurriculumService();
    local = MockLocalCurriculumService();
    repository = CurriculumRepository(remote: remote, local: local);
  });

  group('CurriculumRepository.getPhases', () {
    test('returns mapped phases from remote when remote succeeds', () async {
      final remoteData = [_phaseJson(1), _phaseJson(2)];
      when(() => remote.fetchPhases()).thenAnswer((_) async => remoteData);

      final phases = await repository.getPhases();

      expect(phases, hasLength(2));
      expect(phases[0].id, 1);
      expect(phases[0].title, 'Phase 1 title');
      expect(phases[1].id, 2);
      verify(() => remote.fetchPhases()).called(1);
      verifyNever(() => local.fetchPhases());
    });

    test('falls back to local when remote throws', () async {
      when(() => remote.fetchPhases())
          .thenThrow(Exception('remote unavailable'));
      final localData = [_phaseJson(3)];
      when(() => local.fetchPhases()).thenAnswer((_) async => localData);

      final phases = await repository.getPhases();

      expect(phases, hasLength(1));
      expect(phases.single.id, 3);
      expect(phases.single.title, 'Phase 3 title');
      verify(() => remote.fetchPhases()).called(1);
      verify(() => local.fetchPhases()).called(1);
    });

    test('propagates exception when both remote and local throw', () async {
      when(() => remote.fetchPhases()).thenThrow(Exception('remote down'));
      final localError = Exception('local missing');
      when(() => local.fetchPhases()).thenThrow(localError);

      await expectLater(
        repository.getPhases(),
        throwsA(same(localError)),
      );
      verify(() => remote.fetchPhases()).called(1);
      verify(() => local.fetchPhases()).called(1);
    });
  });

  group('CurriculumRepository.getAspects', () {
    test('returns mapped aspects from remote when remote succeeds', () async {
      final remoteData = [_aspectJson(1), _aspectJson(2)];
      when(() => remote.fetchAspects(1)).thenAnswer((_) async => remoteData);

      final aspects = await repository.getAspects(1);

      expect(aspects, hasLength(2));
      expect(aspects[0].number, 1);
      expect(aspects[0].iconKey, 'icon_1');
      expect(aspects[1].number, 2);
      verify(() => remote.fetchAspects(1)).called(1);
      verifyNever(() => local.fetchAspects(any()));
    });

    test(
        'falls back to local with the same phaseNumber when remote throws',
        () async {
      when(() => remote.fetchAspects(2))
          .thenThrow(Exception('remote unavailable'));
      final localData = [_aspectJson(7)];
      when(() => local.fetchAspects(2)).thenAnswer((_) async => localData);

      final aspects = await repository.getAspects(2);

      expect(aspects, hasLength(1));
      expect(aspects.single.number, 7);
      expect(aspects.single.iconKey, 'icon_7');
      verify(() => remote.fetchAspects(2)).called(1);
      verify(() => local.fetchAspects(2)).called(1);
      verifyNever(() => local.fetchAspects(any(that: isNot(2))));
    });

    test('propagates exception when both remote and local throw', () async {
      when(() => remote.fetchAspects(4)).thenThrow(Exception('remote down'));
      final localError = Exception('local missing');
      when(() => local.fetchAspects(4)).thenThrow(localError);

      await expectLater(
        repository.getAspects(4),
        throwsA(same(localError)),
      );
      verify(() => remote.fetchAspects(4)).called(1);
      verify(() => local.fetchAspects(4)).called(1);
    });
  });

  group('JSON mapping fidelity', () {
    test('Phase.fromJson maps all six fields from a single remote payload',
        () async {
      when(() => remote.fetchPhases()).thenAnswer((_) async => [
            {
              'id': 42,
              'title': 'Phase title',
              'description': 'Phase description',
              'about': 'Phase about',
              'learningGoals': ['goal a', 'goal b', 'goal c'],
              'tipsForHome': ['tip a', 'tip b'],
            },
          ]);

      final phase = (await repository.getPhases()).single;

      expect(phase, isA<Phase>());
      expect(phase.id, 42);
      expect(phase.title, 'Phase title');
      expect(phase.description, 'Phase description');
      expect(phase.about, 'Phase about');
      expect(phase.learningGoals, ['goal a', 'goal b', 'goal c']);
      expect(phase.tipsForHome, ['tip a', 'tip b']);
    });

    test(
        'Aspect.fromJson maps all six fields and renames json[icon] to iconKey',
        () async {
      when(() => remote.fetchAspects(1)).thenAnswer((_) async => [
            {
              'number': 9,
              'title': 'Aspect title',
              'description': 'Aspect description',
              'activityLabel': 'Activity label',
              'icon': 'icon_value',
              'parentGuide': 'Parent guide',
            },
          ]);

      final aspect = (await repository.getAspects(1)).single;

      expect(aspect, isA<Aspect>());
      expect(aspect.number, 9);
      expect(aspect.title, 'Aspect title');
      expect(aspect.description, 'Aspect description');
      expect(aspect.activityLabel, 'Activity label');
      expect(aspect.iconKey, 'icon_value');
      expect(aspect.parentGuide, 'Parent guide');
    });
  });
}
