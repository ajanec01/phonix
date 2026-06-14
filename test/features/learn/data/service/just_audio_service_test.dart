import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phonix/features/learn/data/service/audio_service.dart';
import 'package:phonix/features/learn/data/service/just_audio_service.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockAudioPlayer player;
  late JustAudioService service;

  setUp(() {
    player = MockAudioPlayer();
    service = JustAudioService(player: player);
  });

  test('JustAudioService implements AudioService', () {
    expect(service, isA<AudioService>());
  });

  test('default constructor uses a new AudioPlayer when none is provided', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    runZonedGuarded(
      () {
        final defaultService = JustAudioService();
        expect(defaultService, isA<AudioService>());
      },
      (_, __) {},
    );
  });

  group('play', () {
    test('calls setAsset then play on the player in order', () async {
      when(() => player.setAsset(any())).thenAnswer((_) async => null);
      when(() => player.play()).thenAnswer((_) async {});

      await service.play('assets/audio/rain.mp3');

      verifyInOrder([
        () => player.setAsset('assets/audio/rain.mp3'),
        () => player.play(),
      ]);
    });
  });

  group('stop', () {
    test('calls stop on the player', () async {
      when(() => player.stop()).thenAnswer((_) async {});

      await service.stop();

      verify(() => player.stop()).called(1);
    });
  });

  group('dispose', () {
    test('calls dispose on the player', () async {
      when(() => player.dispose()).thenAnswer((_) async {});

      await service.dispose();

      verify(() => player.dispose()).called(1);
    });
  });
}
