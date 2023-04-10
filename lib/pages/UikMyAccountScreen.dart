import 'dart:convert';
// import 'dart:js';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../constants/strings.dart';
import '../main.dart';


class UikMyAccountScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_ORDER_HISTORY);
    actionList.add(UIK_ACTION.OPEN_MY_DETAILS);
    actionList.add(UIK_ACTION.OPEN_WISHLIST);
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    actionList.add(UIK_ACTION.OPEN_PAYMENT);
    actionList.add(UIK_ACTION.OPEN_SIGN_OUT);
    actionList.add(UIK_ACTION.OPEN_LOG_IN);
    return actionList;
  }

  @override
  dynamic getData() {
     return ApiRepository.getMyAccountScreen;
  }

  void onMyAccountScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDER_HISTORY:
        openOrders(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_DETAILS:
        openDetails(uikAction);
        break;
      case UIK_ACTION.OPEN_WISHLIST:
        openWishlist(uikAction);
        break;
      case UIK_ACTION.OPEN_ADDRESS:
        openAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
        break;
      case UIK_ACTION.OPEN_SIGN_OUT:{
      UiUtils.showToast(LOG_OUT);
      clearDataAndMoveToOnboarding(uikAction);
       }
       break;
      case UIK_ACTION.OPEN_LOG_IN:{
        UiUtils.showToast(LOG_IN);
        clearDataAndMoveToOnboarding(uikAction);
      }
      break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onMyAccountScreenTapAction;
  }

  @override
  getPageContext() {
    return UikMyAccountScreen;
  }

  @override
  getConstructorArgs() {
   return {};
  }
}

void clearDataAndMoveToOnboarding(UikAction uikAction) {

  UserDataHandler.clearUserToken();
  Navigator.pushAndRemoveUntil(
    NavigationService.navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => OnboardingScreen(),
    ),
    // ModalRoute.withName(ScreenRoutes.homeScreen)
    (route) => false,
  );
  // todo mano recreate the main.dart by adding listners
}

void openPayment(UikAction uikAction) {
  UiUtils.showToast("PAYMENTS");
}

void openAddress(UikAction uikAction) {
  UiUtils.showToast("ADDRESS");

  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.addressBookScreen);
}

void openWishlist(UikAction uikAction) {
  UiUtils.showToast("WISHLIST");
}

void openDetails(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.myDetailsScreen);
}

void openOrders(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.orderHistoryScreen);
}

// Future<ApiResponse> getMockedApiResponse(args) async {
//   print("lavesh ${args}");
//   final response = await http.get(
//     Uri.parse('https://demo6536398.mockable.io/myAccount'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );
//
//   // StandardScreenResponse
//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
