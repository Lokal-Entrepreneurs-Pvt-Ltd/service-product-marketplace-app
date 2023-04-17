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

class UikBlockList extends StandardPage {
  List<dynamic> selectedValue = [-1, "block"];

  UikBlockList({
    required this.districtCode,
  });

  final int? districtCode;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.SELECT_BLOCK);
    actionList.add(UIK_ACTION.CONFIRM_BLOCK);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getBlocks;
    // return getMockedApiResponse;
  }

  void onStateListScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.SELECT_BLOCK:
        {
          selectedValue[0] = int.parse(uikAction.tap.data.value!);
          selectedValue[1] = uikAction.tap.values!["blockName"];
        }
        break;
      case UIK_ACTION.CONFIRM_BLOCK:
        {
          var context = NavigationService.navigatorKey.currentContext;
          Navigator.maybePop(context!, selectedValue);
          // Navigator.of(context!).pop(selectedValue);
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
    return UikBlockList;
  }

  @override
  getConstructorArgs() {
    return {
      "districtCode": districtCode,
    };
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
