import 'package:just_audio/just_audio.dart';

import 'audio_permissions.dart';

class GameAudioPlayer {
  GameAudioPlayer() : _player = AudioPlayer();

  final AudioPlayer _player;
  String? _currentAsset;

  Future<void> playSfx(
    String assetPath, {
    double volume = 1.0,
    bool loop = false,
  }) async {
    if (!await AudioPermissions.instance.checkPermission()) {
      return;
    }

    if (_currentAsset != assetPath) {
      _currentAsset = assetPath;
      await _player.setAsset(assetPath);
    }

    await _player.seek(Duration.zero);
    await _player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
    await _player.setVolume(volume);
    await _player.play();
  }

  Future<void> stopSfx() async {
    await _player.stop();
  }

  Future<void> setSfxVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
