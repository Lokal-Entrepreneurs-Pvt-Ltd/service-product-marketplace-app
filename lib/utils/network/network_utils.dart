import '../storage/user_data_handler.dart';

abstract class NetworkUtils {
  static int HTTP_SUCCESS = 200;
  static int REQUEST_TIMEOUT = 20;
  static Map<String, String> getRequestHeaders() {
    return {
      "ngrok-skip-browser-warning": "value",
    "Accept": "*/*",
    "Authorization" : "Bearer " + UserDataHandler.getUserToken(),
    "Content-Type" : "application/json",
       };
  }
}


