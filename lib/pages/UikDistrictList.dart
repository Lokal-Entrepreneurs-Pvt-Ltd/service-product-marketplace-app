import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UikDistrictList extends StandardPage {
  List<dynamic> selectedValue = [-1, "district"];

  UikDistrictList({
    required this.stateCode,
  });

  final int? stateCode;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.SELECT_DISTRICT);
    actionList.add(UIK_ACTION.CONFIRM_DISTRICT);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getDistricts;
    return getMockedApiResponse();
  }

  void onDistrictListScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.SELECT_DISTRICT:
        {
          selectedValue[0] = int.parse(uikAction.tap.data.value!);
          selectedValue[1] = uikAction.tap.values!["districtName"];
        }
        break;
      case UIK_ACTION.CONFIRM_DISTRICT:
        {
          var context = NavigationService.navigatorKey.currentContext;
          Navigator.maybePop(context!, selectedValue);
        }
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onDistrictListScreenTapAction;
  }

  @override
  getPageContext() {
    return UikDistrictList;
  }

  @override
  Map<String, dynamic>? getConstructorArgs() {
    return {
      "stateCode": stateCode,
    };
  }
}

Future<ApiResponse>? getMockedApiResponse() async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  // print(args);

  final response = await http.get(
    // Uri.parse('https://demo4081726.mockable.io/districtslist'),
    Uri.parse('https://demo4081726.mockable.io/districtslist'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
    // body: args,
  );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
