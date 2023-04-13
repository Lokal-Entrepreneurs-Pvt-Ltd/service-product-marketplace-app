import 'dart:convert';
// import 'dart:js';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikMyAddressScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMyAddressScreen;
  }

  void onMyAddressScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      // case UIK_ACTION.OPEN_WITHDRAW:
      //   openWithdraw(uikAction);
      //   break;
      //   break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onMyAddressScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.myAddressScreen;
  }
  @override
  getConstructorArgs() {
   return {};
  }
}

