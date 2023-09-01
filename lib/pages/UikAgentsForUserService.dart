import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../actions.dart';

class UikAgentsForUserService extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAllCustomerForUserService;
  }

  void onAgentsForUserServiceTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onAgentsForUserServiceTapAction;
  }

  @override
  getPageContext() {
    return UikAgentsForUserService;
  }

  @override
  getConstructorArgs() {
    return {
      "serviceId": "16",
      "serviceCode": "b2b_commerce"
    };
  }
}
