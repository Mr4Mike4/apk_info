import 'package:shared_preferences/shared_preferences.dart';

import '../model/pref_keys.dart';

class PreferencesRepository {
  final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();

  Future<SharedPreferences> get prefsFuture => _prefsFuture;

  static void init() {
    SharedPreferences.setPrefix('apk');
  }

  Future<String?> getAaptPath() async {
    final prefs = await _prefsFuture;
    return prefs.getString(PrefKeys.aaptPath);
  }

  Future<bool> setAaptPath(String aaptPath) async {
    final prefs = await _prefsFuture;
    return prefs.setString(PrefKeys.aaptPath, aaptPath);
  }
}
