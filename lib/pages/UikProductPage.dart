import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../actions.dart';
import '../utils/storage/product_data_handler.dart';

class UikProductPage extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_CART);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getProductScreen;
    //return fetchAlbum;
  }

  void onProductPageTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_CART:
        showCartScreen(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onProductPageTapAction;
  }

  @override
  getPageContext() {
    return UikProductPage;
  }
}

// Future<ApiResponse> getMockedApiResponse(args) async {
//   final queryParameter = {
//     "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
//   };
//   print("entering lavesh");
//   final response = await http.post(
//     Uri.parse(
//         'https://4b7c-103-70-43-12.in.ngrok.io/products/getProductDetails'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );
//
//   print("........................response..........................");
//   print(response.body);
//
//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

void showCartScreen(UikAction uikAction) async {
  print("________________________UikAction______________________");
  String skuId = await ProductDataHandler.getProductSkuId();
  print(skuId);
  var args = {
    "skuId": skuId,
    "action": "add",
  };
  dynamic response = await ApiRepository.updateCart(args);
  CartDataHandler.saveCartId(response.data['cart_data']['cartId']);
  print(response.data['cart_data']['cartId']);
  print("!!!!!!!!!!!!!!!!!!!!!!!!!API call done!!!!!!!!!!!!!!!!!!");
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}
