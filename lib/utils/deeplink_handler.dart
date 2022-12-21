import 'package:flutter/material.dart';
import 'package:lokal/routes.dart';

abstract class DeeplinkHandler {
  static void openDeeplink(BuildContext context, String url) {
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

    print(baseUrl); // lokal://search
    //  route = "/searchcataloguescreen";
    print("laveshRoute ${route}"); // /
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
      case MyRoutes.searchScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, MyRoutes.searchScreen);
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
    print("pushed route ${route}");
    Navigator.pushNamed(context, route);
  }
}
