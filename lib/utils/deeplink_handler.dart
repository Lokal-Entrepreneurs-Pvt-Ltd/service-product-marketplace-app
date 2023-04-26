import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'storage/product_data_handler.dart';

abstract class DeeplinkHandler {
  static void openPage(BuildContext context, String url) async {
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
    if (args["cartId"] == "") args["cartId"] = null;
    print(args);

    // /checkout
    switch (route) {
      case ScreenRoutes.loginScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, ScreenRoutes.loginScreen);
          }
        }
        break;
      case ScreenRoutes.homeScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, ScreenRoutes.homeScreen);
          }
        }
        break;
      case ScreenRoutes.catalogueScreen:
        {
          if (args["categoryId"] != null) {
            _pushScreen(context, ScreenRoutes.catalogueScreen, args);
          }
        }
        break;
      case ScreenRoutes.searchScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, ScreenRoutes.searchScreen);
          }
        }
        break;
      case ScreenRoutes.productScreen:
        {
          if (args["skuId"] != null) {
            ProductDataHandler.saveProductSkuId(args['skuId']);
            _pushScreen(context, ScreenRoutes.productScreen, args);
          }
        }
        break;
      case ScreenRoutes.cartScreen:
        {
          print("!!!!!!!!!!!!!!!!args!!!!!!!!!!!!!!!!");
          print(args);
          String cartId = await CartDataHandler.getCartId();
          args = {"cartId": cartId};
          _pushScreen(context, ScreenRoutes.cartScreen, args);
        }
        break;

      case ScreenRoutes.addressBookScreen:
        {
          _pushScreen(context, ScreenRoutes.addressBookScreen, args);
        }
        break;

      case ScreenRoutes.couponScreen:
        {
          _pushScreen(context, ScreenRoutes.couponScreen, args);
        }
        break;
      case ScreenRoutes.isp:
        {
          _pushScreen(context, ScreenRoutes.ispHome, args);
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
