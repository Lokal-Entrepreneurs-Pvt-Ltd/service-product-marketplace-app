import 'package:lokal/actions.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';

import '../main.dart';
// open order history

import '../constants/json_constants.dart';



class UikOrderHistoryScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
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

  @override
  getConstructorArgs() {
   return {};
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
        context, ScreenRoutes.orderScreen, arguments: args);
  }
}
