import 'dart:convert';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/pages/UikAddAddressScreen.dart';
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
  final BuildContext context;

  UikMyAddressScreen(this.context);
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMyAddressScreen;
  }

  void onMyAddressScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_ADDRESS:
        openAddAddressScreen(context);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return (UikAction uikAction) {
      onMyAddressScreenTapAction(uikAction);
    };
  }

  @override
  getPageContext() {
    return ScreenRoutes.myAddressScreen;
  }

  void openAddAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, ScreenRoutes.addAddressScreen);
  }

  @override
  getConstructorArgs() {
    return {};
  }
}
