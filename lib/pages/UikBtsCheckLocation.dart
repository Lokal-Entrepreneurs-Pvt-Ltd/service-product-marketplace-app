import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../utils/network/ApiRepository.dart';

class UikBtsCheckLocationScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.SELECT_TOWER);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getNearestTowers;
    return getMockedApiResponse;
  }

  void onBtsCheckLocationScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.SELECT_TOWER:
        onSelectTower(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onBtsCheckLocationScreenTapAction;
  }

  @override
  getPageContext() {
    return UikBtsCheckLocationScreen;
  }

  void onSelectTower(UikAction uikAction) {}

  @override
  getConstructorArgs() {
    // TODO: implement getConstructorArgs
    return {};
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo2235403.mockable.io/checkFeasibility'),
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
