import '../storage/user_data_handler.dart';

abstract class NetworkUtils {
  static int HTTP_SUCCESS = 200;
  static int REQUEST_TIMEOUT = 300;
  static const String NETWORK_ERROR_USER_NOT_AUTHENTICATED =
      "user_not_authenticated";
  static const String PHONE_NUMBER_NOT_IN_SIGNUP =
      "phone_number_not_in_signup_error";
  static const String User_NOT_FOUND = "user_account_not_found";
  static Map<String, String> getRequestHeaders() {
    var authToken = UserDataHandler.getUserToken();
    var deviceId = UserDataHandler.getDeviceId();
    var appVersion = UserDataHandler.getAppVersion();
    return {
      "ngrok-skip-browser-warning": "value",
      "Accept": "*/*",
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
      "lk-device-id": deviceId,
      "lk-device-version": appVersion,
      "lk-device-type": "android",
    };
  }
}
