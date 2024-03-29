import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../actions.dart';

class UikSamhitaHome extends StandardPage {

  Map<String, dynamic>? args;

  UikSamhitaHome({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_PAGE);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getSamhitaHomescreen;
    // return getMockedApiResponse;
  }

  void ispHomeScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        BuildContext context = AppRoutes.rootNavigatorKey.currentContext!;
        NavigationUtils.openScreen(ScreenRoutes.uikBottomNavigationBar);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return ispHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.samhitaLandingPage;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}

// void onClickCampionButton(UikAction uikAction) async {
//   // NavigationUtils.openPage(uikAction);
//   final BuildContext context = NavigationService.navigatorKey.currentContext!;

//   Navigator.pushNamed(
//     context,
//     ScreenRoutes.samhitaDataCollector,
//   );
// }

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('http://demo7588460.mockable.io/samhitaHome'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
