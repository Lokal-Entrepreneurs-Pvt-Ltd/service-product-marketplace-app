import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static late final SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async =>
      _prefsInstance = await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().

  static String getString(String key, [String? defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _prefsInstance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance.getBool(key) ?? defValue!;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _prefsInstance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance.getInt(key) ?? defValue!;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _prefsInstance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }

  static List<String> getStringList(String key, [List<String>? defValue]) {
    return _prefsInstance.getStringList(key) ?? [];
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    var prefs = await _prefsInstance;
    return prefs?.setStringList(key, value) ?? Future.value(false);
  }
}
