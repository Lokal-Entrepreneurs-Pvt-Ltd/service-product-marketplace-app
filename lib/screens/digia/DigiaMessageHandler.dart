
import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import '../../pages/UikMyAccountScreen.dart';
import '../../utils/UiUtils/UiUtils.dart';
import 'package:go_router/go_router.dart';



enum DigiaMessageType {
  logout,
  openPage,
  executeAction,
}

extension DigiaMessageTypeExtension on DigiaMessageType {
  String get name {
    switch (this) {
      case DigiaMessageType.logout:
        return 'logout';
      case DigiaMessageType.openPage:
        return 'openPage';
      case DigiaMessageType.executeAction:
        return 'executeAction';
    }
  }
}


abstract class DigiaMessageHandler {
  static void logout(Message message) async {
    clearDataAndMoveToOnboarding();
  }

  static void executeAction(Message message) {
    print( message.payload);

  }

  static void openPage(Message message) {
    final context = message.getMountedContext();
    final payload = message.payload;

    if (context != null && payload is Map && payload['pageDeeplinkUrl'] is String) {
      openPageFromUrl(context, payload['pageDeeplinkUrl']);
    } else {
      print("Invalid or missing 'url' in message payload.");
    }
  }


  static void openPageFromUrl(BuildContext? context, String url) async {
    //https://localee.co.in/routName?args1=10&arg2=20
    print("__________________url____________________");
    print(url);
    Map<String, dynamic>? args = {};
    String route = "";
    try {
      int index = url.indexOf("://");
      String string = url.substring(index + 3);
      List<String> strList = string.split(RegExp(r'[/|?|&]'));
      route = "/${strList[1]}";
      for (int i = 2; i < strList.length; i++) {
        List<String> keyValuePair = strList[i].split("=");
        args[keyValuePair[0]] = keyValuePair[1];
      }
    } catch (e) {
      print(e);
    }
    print(route);
    print(args);
   // LokalEvents.logEvent('open_page_event', {'url': url});
    try {
      _pushScreen(context,route, args);
      //launchUrl(Uri.parse(url));
    } catch (e) {
      UiUtils.showToast(e.toString());
      // launchUrl(Uri.parse(url));
    }
  }

  static void _pushScreen(BuildContext? context, String route,
      [Map<String, dynamic>? args]) {
    print("pushed route $route");
    print("pushed args $args");
    //context?.push(route);
    context?.push(route, extra: args);
  }
}
