import 'package:flutter/foundation.dart';
import 'package:lokal/configs/environment.dart';
import '../utils/storage/preference_constants.dart';
import '../utils/storage/preference_util.dart';

class EnvironmentDataHandler {
  static void setDefaultEnvironment(String environment) {
    PreferenceUtils.setString(DEFAULT_ENVIRONMENT, environment);
  }

  static String getDefaultEnvironment() {
    return PreferenceUtils.getString(
        DEFAULT_ENVIRONMENT, kDebugMode ? Environment.LOCAL : Environment.PROD);
  }

  static void setLocalBaseUrl(String localBaseUrl) {
    PreferenceUtils.setString(LOCAL_BASE_URL, localBaseUrl);
  }

// Set your url here
  static String getLocalBaseUrl() {
    return PreferenceUtils.getString(
        LOCAL_BASE_URL, "https://5072-2401-4900-1c31-307d-e5a6-a6c2-3b3a-6775.ngrok-free.app");
  }
}
