import 'package:flutter/material.dart';
import 'package:lokal/routes.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class DeeplinkHandler {
  static void openPage(BuildContext context, String url) {
    print("__________________url____________________");
    print(url);
    Map<String, dynamic>? args = {};
    int start = url.indexOf("://") + 2;
    int end = url.indexOf("?");
    String route = url.substring(start, end);
    String argsString = url.substring(end + 1);
    List<String> Params = argsString.split(RegExp(r'&'));
    for (int i = 0; i < Params.length; i++) {
      List<String> keyValuePair = Params[i].split(RegExp(r'='));
      args[keyValuePair[0]] = keyValuePair[1];
    }

    print(route);
    if (args["cartId"] == "") args["cartId"] = null;
    print(args);

    switch (route) {
      case MyRoutes.loginScreen:
        {
          if (args!.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.homeScreen:
        {
          if (args!.isEmpty) {
            _pushScreen(context, MyRoutes.homeScreen);
          }
        }
        break;
      case MyRoutes.catalogueScreen:
        {
          if (args!["categoryId"] != null) {
            _pushScreen(context, MyRoutes.catalogueScreen, args);
          }
        }
        break;
      case MyRoutes.searchScreen:
        {
          if (args!.isEmpty) {
            _pushScreen(context, MyRoutes.searchScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (args!["skuId"] != null) {
            _pushScreen(context, MyRoutes.productScreen, args);
          }
        }
        break;
      case MyRoutes.cartScreen:
        {
          _pushScreen(context, MyRoutes.cartScreen, args);
        }
        break;
      default:
        launchUrl(Uri.parse(url));
    }
  }

  static void _pushScreen(BuildContext context, String route,
      [Map<String, dynamic>? args]) {
    print("pushed route ${route}");
    print("pushed args ${args}");
    Navigator.pushNamed(context, route, arguments: args);
  }
}
