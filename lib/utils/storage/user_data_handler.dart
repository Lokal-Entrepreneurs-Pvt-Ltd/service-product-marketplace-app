import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDataHandler {
  static void saveUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userToken", userToken);
  }

  static void saveEmailPassword(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static Future<String> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken') ?? "";
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
