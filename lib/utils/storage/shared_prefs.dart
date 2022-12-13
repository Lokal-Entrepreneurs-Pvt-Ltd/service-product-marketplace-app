import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool isFetchingThemeData = true;

  DarkThemeProvider() {
    _getTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

  set setDarkTheme(bool value) {
    _isDarkTheme = value;

    DarkThemePreference.setTheme(value);

    notifyListeners();
  }

  void _getTheme() async {
    _isDarkTheme = await DarkThemePreference.getTheme();
    isFetchingThemeData = false;

    notifyListeners();
  }
}

class DarkThemePreference {
  static const String isDarkTheme = "isDarkTheme";

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool("isDarkTheme") ?? false;
    return prefs.getBool("isDarkTheme") ?? false;
  }

  static Future<void> setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isDarkTheme, value);
  }
}

class SharedPreferencesScreen extends StatelessWidget {
  const SharedPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DarkThemeProvider darkThemeProvider =
        context.watch<DarkThemeProvider>();

    return Scaffold(
      body: Center(
        child: Switch(
          value: darkThemeProvider.isDarkTheme,
          onChanged: (value) {
            darkThemeProvider.setDarkTheme = value;
          },
        ),
      ),
    );
  }
}
