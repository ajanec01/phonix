import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phonix/features/learn/data/repository/progress_repository.dart';
import 'package:phonix/features/learn/data/service/local_progress_service.dart';
import 'package:phonix/features/learn/domain/model/user_progress.dart';

class MockLocalProgressService extends Mock implements LocalProgressService {}

class _FakeUserProgress extends Fake implements UserProgress {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeUserProgress());
  });

  late MockLocalProgressService local;
  late ProgressRepository repository;

  setUp(() {
    local = MockLocalProgressService();
    repository = ProgressRepository(local: local);
  });

  group('ProgressRepository.getProgress', () {
    test('returns UserProgress from local.fetchProgress and calls it once',
        () async {
      const stored = UserProgress(currentPhaseId: 3);
      when(() => local.fetchProgress()).thenAnswer((_) async => stored);

      final result = await repository.getProgress();

      expect(result, same(stored));
      expect(result.currentPhaseId, 3);
      verify(() => local.fetchProgress()).called(1);
      verifyNever(() => local.saveProgress(any()));
    });

    test('propagates exception thrown by local.fetchProgress', () async {
      final error = Exception('fetch failed');
      when(() => local.fetchProgress()).thenAnswer((_) async => throw error);

      await expectLater(
        repository.getProgress(),
        throwsA(same(error)),
      );
      verify(() => local.fetchProgress()).called(1);
    });
  });

  group('ProgressRepository.saveProgress', () {
    test('delegates to local.saveProgress with the given UserProgress once',
        () async {
      const progress = UserProgress(currentPhaseId: 5);
      when(() => local.saveProgress(progress)).thenAnswer((_) async {});

      await repository.saveProgress(progress);

      verify(() => local.saveProgress(progress)).called(1);
      verifyNever(() => local.fetchProgress());
    });

    test('propagates exception thrown by local.saveProgress', () async {
      const progress = UserProgress(currentPhaseId: 2);
      final error = Exception('save failed');
      when(() => local.saveProgress(progress))
          .thenAnswer((_) async => throw error);

      await expectLater(
        repository.saveProgress(progress),
        throwsA(same(error)),
      );
      verify(() => local.saveProgress(progress)).called(1);
    });
  });
}
