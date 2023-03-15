import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

class UikBtsLocationFeasibilityScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    return actionList;
  }

  @override
  dynamic getData() {
    // return ApiRepository.btsLocationFeasibility;
    return getMockedApiResponse;
  }

  void onBtsLocationFeasibilityScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ON_TEXT_EDIT_COMPLETE:
        onEditingText(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onBtsLocationFeasibilityScreenTapAction;
  }

  @override
  getPageContext() {
    return UikBtsLocationFeasibilityScreen;
  }

  void onEditingText(UikAction uikAction) {}
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo9927160.mockable.io/btslocation'),
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