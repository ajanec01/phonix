import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phonix/features/learn/data/repository/audio_repository.dart';
import 'package:phonix/features/learn/data/service/audio_service.dart';

class MockAudioService extends Mock implements AudioService {}

void main() {
  late MockAudioService service;
  late AudioRepository repository;

  setUp(() {
    service = MockAudioService();
    repository = AudioRepository(service: service);
  });

  group('AudioRepository.play', () {
    test('delegates to service.play with the given assetPath once', () async {
      const assetPath = 'assets/audio/rain.mp3';
      when(() => service.play(assetPath)).thenAnswer((_) async {});

      await repository.play(assetPath);

      verify(() => service.play(assetPath)).called(1);
      verifyNever(() => service.stop());
      verifyNever(() => service.dispose());
    });

    test('propagates exception thrown by service.play', () async {
      const assetPath = 'assets/audio/rain.mp3';
      final error = Exception('play failed');
      when(() => service.play(assetPath)).thenAnswer((_) async => throw error);

      await expectLater(
        repository.play(assetPath),
        throwsA(same(error)),
      );
      verify(() => service.play(assetPath)).called(1);
    });
  });

  group('AudioRepository.stop', () {
    test('delegates to service.stop once', () async {
      when(() => service.stop()).thenAnswer((_) async {});

      await repository.stop();

      verify(() => service.stop()).called(1);
      verifyNever(() => service.play(any()));
      verifyNever(() => service.dispose());
    });

    test('propagates exception thrown by service.stop', () async {
      final error = Exception('stop failed');
      when(() => service.stop()).thenAnswer((_) async => throw error);

      await expectLater(
        repository.stop(),
        throwsA(same(error)),
      );
      verify(() => service.stop()).called(1);
    });
  });

  group('AudioRepository.dispose', () {
    test('delegates to service.dispose once', () async {
      when(() => service.dispose()).thenAnswer((_) async {});

      await repository.dispose();

      verify(() => service.dispose()).called(1);
      verifyNever(() => service.play(any()));
      verifyNever(() => service.stop());
    });

    test('propagates exception thrown by service.dispose', () async {
      final error = Exception('dispose failed');
      when(() => service.dispose()).thenAnswer((_) async => throw error);

      await expectLater(
        repository.dispose(),
        throwsA(same(error)),
      );
      verify(() => service.dispose()).called(1);
    });
  });
}
