import '../service/audio_service.dart';

class AudioRepository {
  AudioRepository({required AudioService service}) : _service = service;

  final AudioService _service;

  Future<void> play(String assetPath) => _service.play(assetPath);
  Future<void> stop() => _service.stop();
  Future<void> dispose() => _service.dispose();
}
