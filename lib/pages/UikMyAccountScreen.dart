import 'dart:convert';
// import 'dart:js';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../constants/strings.dart';
import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikMyAccountScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_ORDERS);
    actionList.add(UIK_ACTION.OPEN_DETAILS);
    actionList.add(UIK_ACTION.OPEN_WISHLIST);
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    actionList.add(UIK_ACTION.OPEN_PAYMENT);
    actionList.add(UIK_ACTION.OPEN_SIGN_OUT);
    return actionList;
  }

  @override
  dynamic getData() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    return ApiRepository.getMyAccountScreen;
  }

  void onMyAccountScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDERS:
        openOrders(uikAction);
        break;
      case UIK_ACTION.OPEN_DETAILS:
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
      case UIK_ACTION.OPEN_SIGN_OUT:
        singOut(uikAction);
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
}

void singOut(UikAction uikAction) {
  UiUtils.showToast(LOG_OUT);
  UserDataHandler.clearUserToken();
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
  UiUtils.showToast("DETAILS");
}

void openOrders(UikAction uikAction) {
  UiUtils.showToast("ORDERS");

  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ApiRoutes.orderScreen);
}

Future<ApiResponse> getMockedApiResponse(args) async {
  print("lavesh ${args}");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/myAccount'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
