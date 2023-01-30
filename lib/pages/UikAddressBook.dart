import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/network/retrofit/api_routes.dart';

// add adress
// remove add
// delete address

class UikAddressBook extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();

    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAddressScreen;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_ADDRESS:
//        addAddress(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onAddressBookTapAction;
  }

  @override
  getPageContext() {
    return UikAddressBook;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('http://demo2913052.mockable.io/addressbook'),
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
