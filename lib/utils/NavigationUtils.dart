import 'package:go_router/go_router.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/props/UikAction.dart';
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

  // static Future showLoaderOnTop() {
  //   return showDialog(
  //     context: getCurrentContext()!,
  //     builder: (context) {
  //       return const Center(
  //           child: CircularProgressIndicator(
  //         color: Color(0xfffee440),
  //       ));
  //     },
  //   );
  // }

  static Future<void> showLoaderOnTop([bool? showLoader]) async {
    showLoader ??= true;
    if (showLoader) {
      LoadingOverlay.show(getCurrentContext()!);
    } else {
      LoadingOverlay.hide();
    }
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

  static Future<String?> openAsyncScreen(String routeName,
      [Map<String, dynamic>? args]) async {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    return await context?.push(routeName, extra: args);
  }

  static void popAllAndPush(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentState;
    while (context!.canPop()) {
      context.pop();
    }
    var contexts = AppRoutes.rootNavigatorKey.currentContext;
    contexts?.pushReplacement(routeName, extra: args);
  }

  static void pushAndPopUntil(String routeName, String? popName,
      [Map<String, dynamic>? args]) {
    if (popName != null) {
      AppRoutes.popUntilByName(popName);
    }
    var contexts = AppRoutes.rootNavigatorKey.currentContext;
    contexts?.pushReplacement(routeName, extra: args);
  }

  static void openScreenUntil(String routeName, [Map<String, dynamic>? args]) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    context?.push(routeName, extra: args);
  }
}

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xfffee440),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class TextOverlayDialog extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const TextOverlayDialog({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      actions: <Widget>[
        MaterialButton(
          color: Colors.amberAccent,
          textColor: Colors.black,
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class TextOverlay {
  static void show({
    required String text,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final context = NavigationUtils.getCurrentContext()!;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: TextOverlayDialog(
            text: text,
            buttonText: buttonText,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
