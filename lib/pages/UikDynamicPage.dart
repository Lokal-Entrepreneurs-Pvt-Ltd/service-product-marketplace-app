import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/Logs/eventsdk.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/Logs/event.dart';
import 'package:lokal/utils/Logs/event_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';

class UikDynamicPage extends StandardPage {

  Map<String, dynamic>? args;

  UikDynamicPage({this.args});

  @override
  Set<String?> getActions() {

    return {};
  }
  @override
  dynamic getData() {
    return ApiRepository.getDynamicLandingPage;
  }

  void onJobsLandingPageTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
    ActionUtils.sendEventonActionForScreen(uikAction.tap.type.toString(),ScreenRoutes.dynamicPage);
  }

  @override
  getPageCallBackForAction() {
    return onJobsLandingPageTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.dynamicPage;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}
