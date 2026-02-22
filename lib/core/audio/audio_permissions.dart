import 'package:shared_preferences/shared_preferences.dart';

import '../storage/shared_prefs_keys.dart';

class AudioPermissions {
  AudioPermissions._();

  static final AudioPermissions instance = AudioPermissions._();

  Future<bool> checkPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPrefsKeys.audioSoundEnabled) ?? true;
  }

  Future<void> setPermission(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPrefsKeys.audioSoundEnabled, enabled);
  }
}
