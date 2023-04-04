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
    // return ApiRepository.getDistricts({
    //   "stateCode": stateCode,
    // });
    return getMockedApiResponse({
      "stateCode": stateCode,
    });
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
}

Future<ApiResponse>? getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  print(args);

  final response = await http.post(
    // Uri.parse('https://demo4081726.mockable.io/districtslist'),
    Uri.parse(
        'https://0fe2-2405-201-e029-5bc9-2e08-8f82-fde-9131.in.ngrok.io/isp/feasiblity/getDistrictForState'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
    body: args,
  );

  print("Hellowww");
  print(response.body);

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
