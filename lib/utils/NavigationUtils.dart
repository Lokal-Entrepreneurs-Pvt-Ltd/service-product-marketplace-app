import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import 'deeplink_handler.dart';
import 'package:flutter/material.dart';
import '../screen_routes.dart';


abstract class NavigationUtils {
  static void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  print(
      "_____________________________Catalogue call___________________________");
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
 }

 static void openOrderScreen(Map<String, dynamic> args) {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushNamedAndRemoveUntil(context!, ScreenRoutes.orderScreen, ModalRoute.withName('/'), arguments: args);
  }

  static void pop() {
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.maybePop(context!);
  }
}