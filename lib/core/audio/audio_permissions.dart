import 'package:shared_preferences/shared_preferences.dart';

class AudioPermissions {
  AudioPermissions._();

  static final AudioPermissions instance = AudioPermissions._();

  static const String _keySoundEnabled = 'audio_sound_enabled';

  Future<bool> checkPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySoundEnabled) ?? true;
  }

  Future<void> setPermission(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySoundEnabled, enabled);
  }
}
