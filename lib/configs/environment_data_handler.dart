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
  static String  getLocalBaseUrl() {
    return PreferenceUtils.getString(
        LOCAL_BASE_URL,"https://9f7a-2401-4900-5aad-9130-4874-7ccc-75b7-4b71.ngrok-free.app");
  }
}
