
// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';


class UikMyAddressScreen extends StandardPage {
  final BuildContext context;

  UikMyAddressScreen(this.context, {this.args});


  Map<String, dynamic>? args;

  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMyAddressScreen;
  }

  void onMyAddressScreenTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
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


  @override
  getConstructorArgs() {
    return args;
  }
}
