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
        LOCAL_BASE_URL, "https://236b-2401-4900-1c30-7647-dd0b-fb1a-d24c-6053.ngrok-free.app");
  }
}
