import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/payments/razorpay_payment.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import '../constants/json_constants.dart';
import '../main.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikPaymentDetailsScreen extends StandardPage {
  String paymentMethod = "";
  String orderNumberId = "";
  String rzpPaymentId = "";
  String rzpSignature = "";
  String rzpOrderId = "";

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.PAY_ONLINE);
    actionList.add(UIK_ACTION.PAY_COD);
    actionList.add(UIK_ACTION.PLACE_ORDER);
    actionList.add(UIK_ACTION.PAYMENT_STATUS);
    actionList.add(UIK_ACTION.BACK_PRESSED);
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
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
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

  @override
  getConstructorArgs() {
    return {};
  }

  void setPaymentMode(String paymentMethod) {
    this.paymentMethod = paymentMethod;
  }

  void placeOrder(UikAction uikAction) {
    if (paymentMethod.isEmpty) {
      UiUtils.showToast(CHOOSE_PAYMENT_METHOD);
    } else {
      makePayment(uikAction, paymentMethod);
    }
  }

  Future<void> makePayment(UikAction uikAction, String paymentMethod) async {
    NavigationUtils.showLoaderOnTop();
    dynamic response = await ApiRepository.paymentNext(
      ApiRequestBody.getPaymentNextRequest(paymentMethod),
    );
    NavigationUtils.pop();

    if (response.isSuccess! && paymentMethod.isNotEmpty) {
      orderNumberId = response.data[ORDER_NUMBER_ID];
      if (paymentMethod == PAYMENT_METHOD_COD) {
        makeCodPayment();
      } else if (paymentMethod == PAYMENT_METHOD_ONLINE) {
        makeOnlinePayment(response);
      } else {
        UiUtils.showToast(PAYMENT_MODE_ERROR);
      }
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
    }
  }

  void paymentStatus(UikAction uikAction) {
    print("...................inside status...........");
    var context = NavigationService.navigatorKey.currentContext;
    // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
    Navigator.pushNamed(context!, ApiRoutes.paymentStatusScreen);
  }

  void makeOnlinePayment(response) {
    rzpOrderId = response.data[RAZOR_PAY_ORDER_ID];
    RazorpayPayment razorpay =
        RazorpayPayment(rzpOrderId: rzpOrderId, orderNumberId: orderNumberId);
    razorpay.openPaymentPage();
  }

  void makeCodPayment() {
    Map<String, dynamic>? args = {
      ORDER_NUMBER_ID: orderNumberId,
      PAYMENT_METHOD: paymentMethod,
    };
    NavigationUtils.openOrderScreen(args);
  }
}

void paymentStatus(UikAction uikAction) {
  print("...................inside status...........");
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ApiRoutes.paymentStatusScreen);
}
