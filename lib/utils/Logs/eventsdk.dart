// import 'package:device_info/device_info.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';

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

  // Future<String> _getDeviceID() async {
  //   // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   // return androidInfo.androidId;
  //   //  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  //   //  var build = await deviceInfoPlugin.deviceInfo;
  //   //  String id=bui
  //   // final PlatformDeviceId platformDeviceId = PlatformDeviceId();
  //   var deviceId = await PlatformDeviceId.getDeviceId;

  //   return PlatformDeviceId.getDeviceId;
  // }
}
