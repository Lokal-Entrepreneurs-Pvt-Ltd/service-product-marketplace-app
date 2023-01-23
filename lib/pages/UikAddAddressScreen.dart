import 'dart:convert';

import 'package:flutter/material.dart';
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

class UikAddAddressScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();

    return actionList;
  }

  @override
  dynamic getData() {
    return fetchAlbum;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onAddressBookTapAction;
  }

  @override
  getPageContext() {
    return UikAddAddressScreen;
  }
}

Future<ApiResponse> fetchAlbum(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/address'),
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
