import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/storage/preference_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDataHandler {

  static void saveUserToken(String userToken) async {
    PreferenceUtils.setString(AUTH_TOKEN, userToken);
  }

  static void clearUserToken()  {
    PreferenceUtils.setString(AUTH_TOKEN, "");
  }

  static void saveEmailPassword(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static String getUserToken()  {
    return PreferenceUtils.getString(AUTH_TOKEN);
  }

  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("email") ?? "";
  }

  static Future<String> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("phone") ?? "";
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("name") ?? "";
  }

  static Future<String> getUserBirth() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("birth") ?? "";
  }

  static Future<String> getUserGST() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("GST") ?? "";
  }

  static Future<String> getUserPassword() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("password") ?? "";
  }
}
