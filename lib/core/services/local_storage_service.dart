import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  static String userKey = 'user_data';

  LocalStorageService(this._prefs);

  Future<void> saveKeyValue(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getKeyValue(String key) {
    return _prefs.getString(key);
  }

  Future<void> deleteKey(String key) async {
    await _prefs.remove(key);
  }
}