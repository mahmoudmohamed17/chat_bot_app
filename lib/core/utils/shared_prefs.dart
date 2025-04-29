import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences instance;
  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await instance.setString(key, value);
  }
  static String getString(String key) {
    return instance.getString(key) ?? '';
  }
  static Future<void> setInt(String key, int value) async {
    await instance.setInt(key, value);
  }

  static int getInt(String key) {
    return instance.getInt(key) ?? 0;
  }

  static Future<void> setBool(String key, bool value) async {
    await instance.setBool(key, value);
  }

  static bool getBool(String value) {
    return instance.getBool(value) ?? false;
  }
}
