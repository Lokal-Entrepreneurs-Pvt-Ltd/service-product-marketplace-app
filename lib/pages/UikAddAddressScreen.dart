import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import '../utils/NavigationUtils.dart';
import '../utils/storage/user_data_handler.dart';

// add adress
// remove add
// delete address

class UikAddAddressScreen extends StandardPage {


  Map<String, dynamic>? args;

  UikAddAddressScreen({this.args});

  String name = "";
  String phone = "";
  String street = "";
  String houseNumber = "";
  String city = "";
  String postcode = "";
  String authToken = UserDataHandler.getUserToken();

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    actionList.add(UIK_ACTION.SUBMIT_ADDRESS);
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    // return getMockedApiResponse;
    return ApiRepository.addAddressScreen;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ON_TEXT_EDIT_COMPLETE:
        onTextEditComplete(uikAction);
        break;
      case UIK_ACTION.SUBMIT_ADDRESS:
        submitAddress(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
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
    return ScreenRoutes.addAddressScreen;
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
    if (name.isEmpty) {
      UiUtils.showToast("Enter your name");
      return;
    } else if (houseNumber.isEmpty) {
      UiUtils.showToast("Enter your house number");
      return;
    } else if (street.isEmpty) {
      UiUtils.showToast("Enter your street");
      return;
    } else if (city.isEmpty) {
      UiUtils.showToast("Enter your city");
      return;
    } else if (postcode.isEmpty) {
      UiUtils.showToast("Enter your post code");
      return;
    } else if (phone.isEmpty) {
      UiUtils.showToast("Enter your phone number");
      return;
    }

    Map<String, dynamic> args = {
      ADDRESS: {
        FIRST_NAME: name,
        LAST_NAME: "singh",
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

    print(args);

   NavigationUtils.openScreen(ScreenRoutes.paymentDetailsScreen,args);
  }

  @override
  getConstructorArgs() {
    return args;
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
