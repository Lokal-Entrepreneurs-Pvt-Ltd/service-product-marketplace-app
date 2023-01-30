import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:http/http.dart' as http;
import '../actions.dart';
import '../main.dart';
import '../utils/deeplink_handler.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikEmptyCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    return actionList;
  }

  @override
  dynamic getData() {
    print("########################################################");
    return ApiRepository.getCartScreen;
  }

  void onEmptyCartScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onEmptyCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikEmptyCartScreen;
  }
}

class UikCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
  }

  void onCartScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ADDRESS:
        openAddress(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCartScreen;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo7181466.mockable.io/cartscreen'),
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

void openAddress(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}
