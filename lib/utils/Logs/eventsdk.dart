import 'package:lokal/utils/storage/user_data_handler.dart';

class EventSDK {
  static EventSDK? _instance;

  EventSDK._();

  factory EventSDK() {
    _instance ??= EventSDK._();
    return _instance!;
  }

  static String sessionId = "";
  static int? userId;

  void init() async {
    var deviceId = UserDataHandler.getDeviceId();
    userId = UserDataHandler.getUserId();
    sessionId = deviceId + DateTime.timestamp().toString();
  }
}
