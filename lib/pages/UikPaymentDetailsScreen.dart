import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/payments/razorpay_payment.dart';
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

// enum PaymentMethod {
//   online,
//   cod,
// }

class UikPaymentDetailsScreen extends StandardPage {
  String paymentMethod = "";

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.PAY_ONLINE);
    actionList.add(UIK_ACTION.PAY_COD);
    actionList.add(UIK_ACTION.PLACE_ORDER);
    actionList.add(UIK_ACTION.PAYMENT_STATUS);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.addressNext;
    //return getMockedApiResponse;
  }

  void onPaymentDetailsScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.PAY_ONLINE:
        UiUtils.showToast(PAY_ONLINE_SELECTED);
        setPaymentMode(PAYMENT_METHOD_ONLINE);
        break;
      case UIK_ACTION.PAY_COD:
        UiUtils.showToast(PAY_COD_SELECTED);
        setPaymentMode(PAYMENT_METHOD_COD);
        break;
      case UIK_ACTION.PAYMENT_STATUS:
        paymentStatus(uikAction);
        break;
      case UIK_ACTION.PLACE_ORDER:
        placeOrder(uikAction);
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

  void setPaymentMode(String paymentMethod) {
    this.paymentMethod = paymentMethod;
  }

  void placeOrder(UikAction uikAction) {
    if (paymentMethod.isEmpty) {
      UiUtils.showToast(CHOOSE_PAYMENT_METHOD);
    } else {
      checkPaymentMethod(uikAction, paymentMethod);
    }
  }
}

Future<void> makeOnlinePayment(
    UikAction uikAction, String paymentMethod) async {
  dynamic response = await ApiRepository.paymentNext(
    ApiRequestBody.getPaymentNextRequest(paymentMethod),
  );

  if (response.isSuccess!) {
    var orderNumberId = response.data[ORDER_NUMBER_ID];

    Map<String, dynamic>? args = {
      ORDER_NUMBER_ID: orderNumberId,
      PAYMENT_METHOD: paymentMethod,
    };

    RazorpayPayment razorpay = RazorpayPayment(orderId: orderNumberId);

    razorpay.openPaymentPage();
  } else {
    UiUtils.showToast(response.error![MESSAGE]);
  }
}

void makeCodPayment() {
  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.orderScreen, arguments: {});
}

void paymentStatus(UikAction uikAction) {
  print("...................inside status...........");
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ApiRoutes.paymentStatusScreen);
}

void checkPaymentMethod(UikAction uikAction, String paymentMethod) {
  if (paymentMethod == "cod") {
    makeCodPayment();
  } else {
    makeOnlinePayment(uikAction, paymentMethod);
  }
}
