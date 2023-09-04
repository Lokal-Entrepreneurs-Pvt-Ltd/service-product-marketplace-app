import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UikStateList extends StandardPage {
  List<dynamic> selectedValue = [-1, "state"];

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.SELECT_STATE);
    actionList.add(UIK_ACTION.CONFIRM_STATE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getStates;
    // return getMockedApiResponse;
  }

  void onStateListScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.SELECT_STATE:
        {
          print(uikAction.tap.values);
          selectedValue[0] = int.parse(uikAction.tap.data.value!);
          selectedValue[1] = uikAction.tap.values!["stateName"];

          var context = NavigationService.navigatorKey.currentContext;
        }
        break;
      case UIK_ACTION.CONFIRM_STATE:
        {
          var context = NavigationService.navigatorKey.currentContext!;

          Navigator.maybePop(context, selectedValue);
        }
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onStateListScreenTapAction;
  }

  @override
  getPageContext() {
    return UikStateList;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}

Future<ApiResponse>? getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    // Uri.parse('https://demo8009892.mockable.io/statelist'),
    Uri.parse('https://demo9060148.mockable.io/statelist'),
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
