import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/lokal_events.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'storage/product_data_handler.dart';

abstract class DeeplinkHandler {
  static void openPage(BuildContext? context, String url) async {
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
    LokalEvents.logEvent('open_page_event', {'url': url});
    try{
      _pushScreen(context,route, args);
    }
    catch(e){
      launchUrl(Uri.parse(url));
    }

  }

  static void _pushScreen(BuildContext? context, String route,
      [Map<String, dynamic>? args]) {
    print("pushed route $route");
    print("pushed args $args");
    context?.push(route,extra: args);
  }
}
