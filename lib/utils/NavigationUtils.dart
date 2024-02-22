import 'package:go_router/go_router.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
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

  static void openWeb(UikAction uikAction) {
    DeeplinkHandler.openWeb(uikAction.tap.data.url!);
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
    var context = getCurrentContext();
    AppRoutes().popUntil(AppRoutes.uikBottomNavigationBar);
    // UiUtils.showToast(args.toString());
    context!.go(ScreenRoutes.orderScreen, extra: args);
  }

  static void openHomeScreen(Map<String, dynamic> args) {
    CartDataHandler.clearCart();
    var context = getCurrentContext();
    AppRoutes().popUntil(AppRoutes.uikBottomNavigationBar);
    context!.go(ScreenRoutes.homeScreen, extra: args);
  }

  static void pop() {
    getCurrentContext()!.pop();
  }

  static void openPage(UikAction uikAction) {
    DeeplinkHandler.openPage(getCurrentContext()!, uikAction.tap.data.url!);
  }

  static void openPageFromUrl(String url) {
    DeeplinkHandler.openPage(getCurrentContext()!, url);
  }

  static void openScreen(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    context?.push(routeName, extra: args);
  }

  static void popAllAndPush(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentState;
    while (context!.canPop()) {
      context.pop();
    }
    var contexts = AppRoutes.rootNavigatorKey.currentContext;
    contexts?.pushReplacement(routeName, extra: args);
  }

  static void openScreenUntil(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    context?.push(routeName, extra: args);
  }
}
