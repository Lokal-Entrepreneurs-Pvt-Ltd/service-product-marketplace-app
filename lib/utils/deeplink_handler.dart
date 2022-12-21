import 'package:flutter/material.dart';
import 'package:lokal/routes.dart';

abstract class DeeplinkHandler {
  static void openDeeplink(BuildContext context, String url) {
    // Url formatl -> https://localee.co.in/productscreen?categoryid=1&productid=1
    String baseUrl = "";
    String route = "";
    Map<String, String> args = {};

    List<String> urlSplits = url.split(RegExp(r'/'));

    if (urlSplits.length >= 4) {
      baseUrl = "${urlSplits[0]}//${urlSplits[2]}";

      List<String> routeAndParams = urlSplits[3].split(RegExp(r'[?|&]'));

      route = "/${routeAndParams[0]}";

      if (routeAndParams.length > 1) {
        for (int i = 1; i < routeAndParams.length; i++) {
          List<String> keyValuePair = routeAndParams[i].split(RegExp(r'='));

          args[keyValuePair[0]] = keyValuePair[1];
        }
      }
    } else {
      baseUrl = url;
      route = "/";
    }

    print(baseUrl);
    print(route);
    print(args);

    switch (route) {
      case MyRoutes.loginScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.homeScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.catalogueScreen:
        {
          if (args["catalogueId"] != null) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.search:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (args["productId"] != null) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      default:
    }
  }

  static void openPage(BuildContext context, String url) {
    // Url formatl -> lokal://productscreen?categoryid=1&productid=1
    String route = "";
    Map<String, String> args = {};

    List<String> urlSplits = url.split(RegExp(r'/'));

    List<String> routeAndParams = urlSplits[2].split(RegExp(r'[?|&]'));

    route = "/${routeAndParams[0]}";

    if (routeAndParams.length > 1) {
      for (int i = 1; i < routeAndParams.length; i++) {
        List<String> keyValuePair = routeAndParams[i].split(RegExp(r'='));

        args[keyValuePair[0]] = keyValuePair[1];
      }
    }

    print(route);
    print(args);

    switch (route) {
      case MyRoutes.loginScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.homeScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.catalogueScreen:
        {
          if (args["catalogueId"] != null) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.search:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (args["productId"] != null) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      default:
    }
  }

  static void _pushScreen(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}