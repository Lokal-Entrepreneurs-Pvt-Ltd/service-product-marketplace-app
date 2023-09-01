import '../storage/user_data_handler.dart';

abstract class NetworkUtils {
  static int HTTP_SUCCESS = 200;
  static int REQUEST_TIMEOUT = 300;
  static const String NETWORK_ERROR_USER_NOT_AUTHENTICATED = "user_not_authenticated";
  static Map<String, String> getRequestHeaders() {
    var authToken = UserDataHandler.getUserToken();
    var deviceId = UserDataHandler.getDeviceId();
    return {
      "ngrok-skip-browser-warning": "value",
      "Accept": "*/*",
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
      "lk-device-id": deviceId
    };
  }
}
