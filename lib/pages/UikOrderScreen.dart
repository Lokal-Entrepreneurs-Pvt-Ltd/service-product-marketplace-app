import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/models/Action.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../actions.dart';
import '../utils/NavigationUtils.dart';

// view order details

class UikOrderScreen extends StandardPage {
  final dynamic args;

  UikOrderScreen({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getOrderScreen;
    return getMockedApiResponse;
  }

  void onOrderScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_TO_CART:
        addToCart(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        openCategory(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.openScreen(
          ScreenRoutes.uikBottomNavigationBar,
        );
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onOrderScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.orderScreen;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}

void orderDetail(UikAction uikAction) {
  UiUtils.showToast("ORDER DETAILS");
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/orderscreen'),
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

void addToCart(UikAction uikAction) async {
  // var skuId = uikAction.tap.data.skuId;

  // //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });

  // //displaying response from update cart
  // print("statusCode ${response.body}");
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  print("Category call");
  var context = AppRoutes.rootNavigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  context!.go(ScreenRoutes.catalogueScreen);
}
