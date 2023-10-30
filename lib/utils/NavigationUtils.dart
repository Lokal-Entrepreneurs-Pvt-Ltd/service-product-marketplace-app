import 'package:go_router/go_router.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import 'deeplink_handler.dart';
import 'package:flutter/material.dart';
import '../screen_routes.dart';

abstract class NavigationUtils {
  static void openCategory(UikAction uikAction) {
    //Navigation to the next screen through deepLink Handler
    var context = AppRoutes.rootNavigatorKey.currentContext;
    DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  }

  static BuildContext? getCurrentContext() {
    return AppRoutes.rootNavigatorKey.currentContext;
  }

  static Future showLoaderOnTop() {
    return showDialog(
      context: getCurrentContext()!,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Color(0xfffee440),
        ));
      },
    );
  }

  static void openOrderScreen(Map<String, dynamic> args) {
    CartDataHandler.clearCart();
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushNamedAndRemoveUntil(
        context!, ScreenRoutes.orderScreen, ModalRoute.withName('/'),
        arguments: args);
  }

  static void pop() {
    Navigator.maybePop(getCurrentContext()!);
  }

  static void openPage(UikAction uikAction) {
    DeeplinkHandler.openPage(getCurrentContext()!, uikAction.tap.data.url!);
  }

  static void openScreen(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    // Navigator.pushNamed(context!, routeName, arguments: args );
    context?.go(routeName,extra: args);
  }

  static void openScreenUntil(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    // Navigator.pushNamedAndRemoveUntil(
    //     context!,routeName, ModalRoute.withName('/'),
    //     arguments: args);
    context?.go(routeName,extra: args);
  }
}
