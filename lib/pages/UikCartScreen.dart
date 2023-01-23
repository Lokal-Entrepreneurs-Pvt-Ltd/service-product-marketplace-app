import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:http/http.dart' as http;
import '../actions.dart';
import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikEmptyCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    return actionList;
  }

  @override
  dynamic getData() {
    print("########################################################");
    return ApiRepository.getCartScreen;
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
}

class UikCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.OPEN_COUPON);
    actionList.add(UIK_ACTION.OPEN_CHECKOUT);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
    //return fetchAlbum;
  }

  void onCartScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_TO_CART:
        addToCart(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        openCategory(uikAction);
        break;
      case UIK_ACTION.OPEN_COUPON:
        openCoupon(uikAction);
        break;
      case UIK_ACTION.OPEN_CHECKOUT:
        openCheckout(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCartScreen;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo7181466.mockable.io/cartscreen'),
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
  var skuId = uikAction.tap.data.skuId;

  //api call to update cart
  // final response =
  //     await http.post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });

  //displaying response from update cart
  // print("statusCode ${response.body}");

  var context = NavigationService.navigatorKey.currentContext;

  Navigator.pushNamed(context!, MyApiRoutes.cartScreen);
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, MyApiRoutes.catalogueScreen);
}

void openProduct(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, MyApiRoutes.productScreen);
}

void openCoupon(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  print("Coupon OPEN");
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, MyApiRoutes.couponScreen);
}

void openCheckout(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  print("checkout");
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, MyApiRoutes.addressBookScreen);
}
