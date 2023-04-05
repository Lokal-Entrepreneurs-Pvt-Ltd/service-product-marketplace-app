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
import '../utils/storage/cart_data_handler.dart';

class UikDistrictList extends StandardPage {
  int selectedValue = -1;

  UikDistrictList({
    required this.stateCode,
  });

  final int stateCode;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("SELECT_CITY");
    actionList.add("CITY_SELECTED");
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getDistricts;
    return getMockedApiResponse();
  }

  void onStateListScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case "SELECT_DISTRICT":
        {
          print("Inside Select City");
          print(uikAction.tap.data.value);
          selectedValue = int.parse(uikAction.tap.data.value!);
        }
        break;
      case "SUBMIT_FORM":
        {
          print(selectedValue);
          var context = NavigationService.navigatorKey.currentContext;
          Navigator.maybePop(context!, selectedValue);
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

  final response = await http.get(
    // Uri.parse('https://demo4081726.mockable.io/districtslist'),
    Uri.parse(
        'https://demo4081726.mockable.io/districtslist'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );


  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
