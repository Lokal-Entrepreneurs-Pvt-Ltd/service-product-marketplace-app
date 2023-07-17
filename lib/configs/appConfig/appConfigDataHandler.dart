import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfigDataHandler {
  static Map<String, dynamic>? appConfig;
  static Map<String, dynamic>? savedUserParams;
  static Map<String, dynamic>? savedBottomTabs;
  static Map<String, dynamic>? savedUserTabs;
  late String userType;

  Future<void> init() async {
    try {
      final configString =
          await rootBundle.loadString('lib/configs/appConfig/appConfig.json');
      final parsedConfig = jsonDecode(configString);
      appConfig = parsedConfig as Map<String, dynamic>;
      if (appConfig != null) {
        await saveUserParams(appConfig!['userParams']);
        await saveUserTabs(appConfig!['userParams']['bottomTabs']);
      }
    } catch (e) {
      print('Failed to load appConfig.json: $e');
      appConfig = null;
    }
  }

  saveUserParams(Map<String, dynamic>? userParams) {
    try {
      if (userParams != null) {
        savedUserParams = userParams;
      }
    } catch (e) {
      print('Error in saveUserParams: $e');
    }
  }

  getSavedUserParams() {
    return savedUserParams;
  }

  saveUserTabs(Map<String, dynamic>? userTabs) {
    try {
      if (userTabs != null) {
        savedUserTabs = userTabs;
      }
    } catch (e) {
      print('Error in saveUserTabs: $e');
    }
  }

  getUserTabs(String userType) {
    if (savedUserTabs != null) {
      return savedUserTabs![userType];
    }
  }
}
