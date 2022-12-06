import 'package:flutter/material.dart';
import 'package:lokal/utils/routes.dart';

abstract class DeeplinkHandler {
  static void openDeeplink(BuildContext context, String url) {
    int slashCount = 0;

    int baseUrlEndIndex = -1;
    int hostEndIndex = -1;

    String baseUrl = "";
    String host = "";

    Map<String, dynamic> arguments = {};

    for (int i = 0; i < url.length; i++) {
      baseUrl += url[i];

      if (url[i] == "/") {
        slashCount++;

        if (slashCount == 3) {
          baseUrlEndIndex = i;
          break;
        }
      }
    }

    if (baseUrlEndIndex == -1) {
      host = "/";

      print(baseUrl);
      print(host);
      print(arguments);

      return;
    }

    for (int i = baseUrlEndIndex; i < url.length; i++) {
      if (url[i] == "?") {
        hostEndIndex = i;
        break;
      }

      host += url[i];
    }

    if (hostEndIndex == -1) {
      hostEndIndex = url.length;
    }

    String key = "";
    String value = "";
    bool isEqualSign = false;
    int andSignCount = 0;

    for (int i = hostEndIndex + 1; i < url.length; i++) {
      if (url[i] == "=") {
        isEqualSign = true;

        continue;
      } else if (url[i] == "&") {
        isEqualSign = false;

        andSignCount++;

        arguments[key] = value;

        key = "";
        value = "";

        continue;
      }

      if (!isEqualSign) {
        key += url[i];
      } else {
        value += url[i];
      }
    }

    if (andSignCount == arguments.length && andSignCount != 0) {
      arguments[key] = value;

      key = "";
      value = "";
    }

    if (key != "" && value != "" && arguments.isEmpty) {
      arguments[key] = value;

      key = "";
      value = "";
    }

    print(baseUrl);
    print(host);
    print(arguments);

    switch (host) {
      case MyRoutes.loginScreen:
        {
          if (arguments.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.homeScreen:
        {
          if (arguments.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.productsCatalogueScreen:
        {
          if (arguments["catalogueId"]) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.searchCatalogueScreen:
        {
          if (arguments.isEmpty) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      case MyRoutes.productScreen:
        {
          if (arguments["productId"]) {
            _pushScreen(context, MyRoutes.loginScreen);
          }
        }
        break;
      default:
    }

    return;
  }

  static void _pushScreen(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  /* void pushLoginScreen() {}

  static void homeScreenHandler(BuildContext context, String url) {}

  static void productsCatalogueScreenHandler(
      BuildContext context, String url) {}

  static void searchProductsCatalogueScreenHandler(
      BuildContext context, String url) {}

  static void productScreenHandler(BuildContext context, String url) {} */
}
