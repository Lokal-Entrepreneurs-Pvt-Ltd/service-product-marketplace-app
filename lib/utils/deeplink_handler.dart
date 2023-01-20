import 'package:flutter/material.dart';
import 'package:lokal/routes.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (url == 'https://localee.co.in/product/detail?skuId=MH01') {
      route = '/product/detail';
      args = {"skuId": 'MH01'};
    }

    print(baseUrl);
    print("laveshRoute ${route}");
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
          print("Lavesh Lvaesh");
          if (args["categoryId"] != null) {
            _pushScreen(context, MyRoutes.catalogueScreen, args);
          }
        }
        break;
      case MyRoutes.searchScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (args["skuId"] != null) {
            _pushScreen(context, MyRoutes.productScreen, args);
          }
        }
        break;
      default:
        launchUrl(Uri.parse(url));
    }
  }

  static void openPage(BuildContext context, String url) {
    print("__________________url____________________");
    print(url);
    if (url.startsWith("http")) {
      openDeeplink(context, url);
      return;
    }

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
            _pushScreen(context, MyRoutes.homeScreen);
          }
        }
        break;
      case MyRoutes.catalogueScreen:
        {
          print("lavesh lavesh");
          if (args["categoryId"] != null) {
            _pushScreen(context, MyRoutes.catalogueScreen, args);
          }
        }
        break;
      case MyRoutes.searchScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.searchScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (args["skuId"] != null) {
            _pushScreen(context, MyRoutes.productScreen, args);
          }
        }
        break;
      default:
        launchUrl(Uri.parse(url));
    }
  }

  static void _pushScreen(BuildContext context, String route,
      [Map<String, dynamic>? args]) {
    print("pushed route ${route}");
    Navigator.pushNamed(context, route, arguments: args);
  }
}
