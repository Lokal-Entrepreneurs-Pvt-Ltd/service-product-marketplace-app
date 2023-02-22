import 'package:lokal/actions.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../utils/network/retrofit/api_client.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

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
// open order history
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants/json_constants.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/network/ApiRequestBody.dart';
import '../utils/network/retrofit/api_routes.dart';
import 'package:http/http.dart' as http;

class UikOrderHistoryScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_ORDER);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getOrderHistoryScreen;
  }

  void onOrderHistoryScrenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDER:
        openOrder(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onOrderHistoryScrenTapAction;
  }

  @override
  getPageContext() {
    return UikOrderHistoryScreen;
  }
}

void openOrder(UikAction uikAction) {

  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.myDetailsScreen);
  if(uikAction.tap.data.key == TAP_ACTION_TYPE_KEY_ORDER_NUMBER_ID) {
    Map<String, dynamic>? args = {
      ORDER_NUMBER_ID: uikAction.tap.data.value,
    };
    Navigator.pushNamed(
        context!, ScreenRoutes.orderScreen, arguments: args);
  }
}
