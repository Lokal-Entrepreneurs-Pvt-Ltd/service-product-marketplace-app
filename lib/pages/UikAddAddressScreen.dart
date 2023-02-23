import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/network/retrofit/api_routes.dart';
import '../utils/storage/user_data_handler.dart';

// add adress
// remove add
// delete address

class UikAddAddressScreen extends StandardPage {
  String name = "";
  String phone = "";
  String street = "";
  String houseNumber = "";
  String city = "";
  String postcode = "";

  String authToken = UserDataHandler.getUserToken();

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    actionList.add(UIK_ACTION.SUBMIT_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
    return getMockedApiResponse;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ON_TEXT_EDIT_COMPLETE:
        onTextEditComplete(uikAction);
        break;
      case UIK_ACTION.SUBMIT_ADDRESS:
        submitAddress(uikAction);
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
    return UikAddAddressScreen;
  }

  void onTextEditComplete(UikAction uikAction) {
    var key = uikAction.tap.data.key;
    var value = uikAction.tap.data.value;

    print(key);
    print(value);

    if (key == "Full Name") {
      name = value!;
    } else if (key == "Phone") {
      phone = value!;
    } else if (key == "Street") {
      street = value!;
    } else if (key == "House number") {
      houseNumber = value!;
    } else if (key == "City") {
      city = value!;
    } else if (key == "Postcode") {
      postcode = value!;
    }
  }

  void submitAddress(UikAction uikAction) {
    Map<String, dynamic> args = {
      ADDRESS: {
        FIRST_NAME: name,
        LAST_NAME: "",
        ADDRESS_LINE_1: houseNumber,
        ADDRESS_LINE_2: street,
        CITY: city,
        STATE: {
          "id": 578,
        },
        POSTCODE: postcode,
        TELEPHONE: phone,
      },
    };

    final BuildContext context = NavigationService.navigatorKey.currentContext!;
    Navigator.pushNamed(
      context,
      ScreenRoutes.paymentDetailsScreen,
      arguments: args,
    );
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo3926789.mockable.io/addaddress'),
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
