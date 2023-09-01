import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';

class UikServiceDetailsPage extends StandardPage {
  final String? serviceId, serviceCode;
  UikServiceDetailsPage({
    this.serviceId,
    this.serviceCode,
  });

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_PAGE);
    actionList.add(UIK_ACTION.BACK_PRESSED);

    return actionList;
  }

  @override
  dynamic getData() {
    // return ApiRepository.getHomescreen;
    return ApiRepository.getServiceDetailScreen;
    // return getMockedApiResponse;
  }

  void onServiceDetailScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onServiceDetailScreenTapAction;
  }

  @override
  getPageContext() {
    return UikServiceDetailsPage;
  }

  @override
  getConstructorArgs() {
    return {
      "serviceId": serviceId,
      "serviceCode": serviceCode,
    };
  }
}

void addToCart(UikAction uikAction) async {
  // var skuId = uikAction.tap.data.skuId;
  //
  // //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });
  //
  // //displaying response from update cart
  // print("statusCode ${response.body}");
}
