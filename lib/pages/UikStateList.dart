import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/Renderer.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../utils/NavigationUtils.dart';

class UikStateList extends StandardPage {
  int selectedValue = -1;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("SELECT_STATE");
    actionList.add("CONFIRM_STATE");
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getStates;
    // return getMockedApiResponse;
  }

  void onStateListScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case "SELECT_STATE":
        {
          selectedValue = int.parse(uikAction.tap.data.value!);

          var context = NavigationService.navigatorKey.currentContext;
          // Navigator.of(context!).pop(selectedValue);
        }
        break;
      case "CONFIRM_STATE":
        {
          var context = NavigationService.navigatorKey.currentContext!;
          // Navigator.of(context!).pop(selectedValue);
          // NavigationUtils.pop(selectedValue);
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
