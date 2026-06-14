import 'package:just_audio/just_audio.dart';

import 'audio_service.dart';

class JustAudioService implements AudioService {
  JustAudioService({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  @override
  Future<void> play(String assetPath) async {
    await _player.setAsset(assetPath);
    await _player.play();
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() => _player.dispose();
}
