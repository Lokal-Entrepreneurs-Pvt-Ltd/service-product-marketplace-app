import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/network/retrofit/api_routes.dart';
import 'package:http/http.dart' as http;

class UikAddressBook extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_PAYMENT);
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
   //return  getMockedApiResponse;
    return ApiRepository.getAddressScreen;
  }



  // Future<ApiResponse> getMockedApiResponse(args) async {
  //   print("lavesh ${args}");
  //   final response = await http.get(
  //     Uri.parse('http://demo2913052.mockable.io/addressbook'),
  //     headers: {
  //       "ngrok-skip-browser-warning": "value",
  //     },
  //   );
  //
  //   // StandardScreenResponse
  //   if (response.statusCode == 200) {
  //     return ApiResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_ADDRESS:
        addAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
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

void deleteAddress(UikAction uikAction) {
  UiUtils.showToast("DELETE ADDRESS");
}

void removeAddress(UikAction uikAction) {
  UiUtils.showToast("REMOVE ADDRESS");
}

void addAddress(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.addAddressScreen);
}

void openPayment(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.paymentDetailsScreen);
}

