import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:http/http.dart' as http;
import '../actions.dart';
import '../constants/json_constants.dart';
import '../main.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/deeplink_handler.dart';
import '../screen_routes.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/storage/cart_data_handler.dart';

class UikEmptyCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
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
}

class UikCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    actionList.add(UIK_ACTION.REMOVE_CART_ITEM);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
  }

  void onCartScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ADDRESS:
        if (UserDataHandler.getIsUserVerified()) {
          openAddress(uikAction);
        } else {
          openMyDetails();
        }
        break;
      case UIK_ACTION.REMOVE_CART_ITEM:
        if (UserDataHandler.getIsUserVerified()) {
          removeCartItem(uikAction);
        } else {
          openMyDetails();
        }
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
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}

void openMyDetails() {
  var context = NavigationService.navigatorKey.currentContext;
  Navigator.pushNamed(context!, ScreenRoutes.myDetailsScreen);
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

  Navigator.pushNamed(context!, ScreenRoutes.cartScreen);
}

void removeCartItem(UikAction uikAction) async {
  var skuId = uikAction.tap.data.skuId;
  var cartId = CartDataHandler.getCartId();

  dynamic response = await ApiRepository.updateCart(
    ApiRequestBody.getUpdateCartRequest(
      skuId!,
      "remove",
      cartId,
    ),
  );

  if (response.isSuccess!) {
    var cartIdReceived = response.data[CART_DATA][CART_ID];
    CartDataHandler.saveCartId(cartIdReceived);

    var context = NavigationService.navigatorKey.currentContext;
    DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  } else {
    UiUtils.showToast(response.error![MESSAGE]);
  }
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.catalogueScreen);
}

void openProduct(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.productScreen);
}

void openCoupon(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  print("Coupon OPEN");
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.couponScreen);
}

void openCheckout(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  print("checkout");
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ScreenRoutes.addressBookScreen);
}
