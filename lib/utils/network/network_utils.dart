import '../storage/preference_util.dart';
import '../storage/user_data_handler.dart';

abstract class NetworkUtils {
  static int HTTP_SUCCESS = 200;
  static int REQUEST_TIMEOUT = 300;
  static Map<String, String> getRequestHeaders() {
    var authToken = UserDataHandler.getUserToken();
    var device_id = UserDataHandler.getDeviceId();

    return {
      "ngrok-skip-browser-warning": "value",
      "Accept": "*/*",
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
      "lk-device-id": device_id
    };
  }
}
