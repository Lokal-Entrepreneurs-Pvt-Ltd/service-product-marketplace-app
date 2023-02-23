import '../storage/user_data_handler.dart';

abstract class NetworkUtils {

  static Map<String, String> getRequestHeaders() {
    return {
      "ngrok-skip-browser-warning": "value",
    "Accept": "*/*",
    "Authorization" : "Bearer " + UserDataHandler.getUserToken(),
    "Content-Type" : "application/json",
       };
  }

}


