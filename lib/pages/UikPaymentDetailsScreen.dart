import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:http/http.dart' as http;

import '../constants/json_constants.dart';
import '../main.dart';
import '../screen_routes.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/network/retrofit/api_routes.dart';
// pay_online
// pay_cod
//

class UikPaymentDetailsScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.PAY_ONLINE);
    actionList.add(UIK_ACTION.PAY_COD);
    actionList.add(UIK_ACTION.PAYMENT_STATUS);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.addressNext;
  }

  void onPaymentDetailsScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.PAY_ONLINE:
        payOnline(uikAction);
        break;
      case UIK_ACTION.PAY_COD:
        payCOD(uikAction);
        break;
      case UIK_ACTION.PAYMENT_STATUS:
        paymentStatus(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onPaymentDetailsScreenTapAction;
  }

  @override
  getPageContext() {
    return UikPaymentDetailsScreen;
  }
}

void payCOD(UikAction uikAction) {
    makePayment(uikAction,PAYMENT_METHOD_COD);
}

Future<void> makePayment(UikAction uikAction, String paymentMethod) async {

  dynamic response = await ApiRepository.paymentNext(ApiRequestBody.
  getPaymentNextRequest( paymentMethod));
  if (response.isSuccess!) {
    var orderNumberId = response.data[ORDER_NUMBER_ID];
    Map<String, dynamic>? args = {
      "orderNumberId" : orderNumberId,
    };
    var context = NavigationService.navigatorKey.currentContext;
    Navigator.pushNamed(context!, ScreenRoutes.orderScreen, arguments: args);
  }
  else {
    UiUtils.showToast(response.error![MESSAGE]);
  }
}

void paymentStatus(UikAction uikAction) {
  print("...................inside status...........");
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ApiRoutes.paymentStatusScreen);
}

void payOnline(UikAction uikAction) {
  makePayment(uikAction,PAYMENT_METHOD_ONLINE);
}

// Future<ApiResponse> getMockedApiResponse(args) async {
//   final queryParameter = {
//     "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
//   };
//   print("entering lavesh");
//   final response = await http.get(
//     Uri.parse('http://demo2913052.mockable.io/payment'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );
//
//   print(response.body);
//
//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
