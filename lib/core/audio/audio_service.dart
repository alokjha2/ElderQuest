import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_permissions.dart';

class AudioService with WidgetsBindingObserver {
  AudioService._() {
    WidgetsBinding.instance.addObserver(this);
  }

  static final AudioService instance = AudioService._();
  static const double gameplayBackgroundVolume = 0.02;

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;
  String? _currentAsset;

  Future<void> playBackgroundMusic(
    String assetPath, {
    double volume = 0.2,
  }) async {
    if (!await AudioPermissions.instance.checkPermission()) {
      return;
    }

    await _ensureInitialized();

    if (_currentAsset != assetPath) {
      _currentAsset = assetPath;
      await _player.setAsset(assetPath);
    }

    await _player.setLoopMode(LoopMode.one);
    await _player.setVolume(volume);
    await _player.play();
  }

  Future<void> stopBackgroundMusic() async {
    await _player.stop();
  }

  Future<void> pauseBackgroundMusic() async {
    await _player.pause();
  }

  Future<void> resumeBackgroundMusic() async {
    if (!await AudioPermissions.instance.checkPermission()) {
      return;
    }
    await _player.play();
  }

  Future<void> setBackgroundVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _player.pause();
    }
  }

  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _player.dispose();
  }
}
