import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:http/http.dart' as http;
import '../actions.dart';
import '../constants/json_constants.dart';
import '../main.dart';
import '../utils/NavigationUtils.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/deeplink_handler.dart';
import '../screen_routes.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/storage/cart_data_handler.dart';

class UikEmptyCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen({"cartId": CartDataHandler.getCartId()});
    // return getMockedApiResponse;
  }

  void onEmptyCartScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onEmptyCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikEmptyCartScreen;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}

class UikCartScreen extends StandardPage {

  Map<String, dynamic>? args;

  UikCartScreen({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    actionList.add(UIK_ACTION.REMOVE_FROM_CART);
    actionList.add(UIK_ACTION.REMOVE_CART_ITEM);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    actionList.add(UIK_ACTION.OPEN_PAGE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
  }

  void onCartScreenTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
  }

  @override
  getPageCallBackForAction() {
    return onCartScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.cartScreen;
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
    Uri.parse('https://929e-202-89-65-238.ngrok.io/customer/get'),
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

void openAddress(UikAction uikAction) {
  NavigationUtils.openPage(uikAction);
}

void openMyDetails() {
  NavigationUtils.openScreen(ScreenRoutes.myDetailsScreen);
}

void addToCart(UikAction uikAction) async {
  var skuId = uikAction.tap.data.skuId;

  //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });

  //displaying response from update cart
  // print("statusCode ${response.body}");


  NavigationUtils.openScreen(ScreenRoutes.cartScreen,{});
}

void removeCartItem(UikAction uikAction) async {
  var skuId = uikAction.tap.data.skuId;
  var cartId = CartDataHandler.getCartId();
  NavigationUtils.showLoaderOnTop();
  dynamic response = await ApiRepository.updateCart(
    ApiRequestBody.getUpdateCartRequest(
      skuId!,
      "remove",
      cartId,
    ),
  );
  NavigationUtils.pop();

  if (response.isSuccess!) {
    var cartIdReceived = response.data[CART_DATA][CART_ID];
    CartDataHandler.saveCartId(cartIdReceived);
    NavigationUtils.openPage(uikAction);
  } else {
    UiUtils.showToast(response.error![MESSAGE]);
  }
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  NavigationUtils.openScreen(ScreenRoutes.catalogueScreen,{});

}

void openProduct(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.productScreen);
}

void openCoupon(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.couponScreen,{});
}

void openCheckout(UikAction uikAction) {

  NavigationUtils.openScreen(ScreenRoutes.addressBookScreen,{});
}
