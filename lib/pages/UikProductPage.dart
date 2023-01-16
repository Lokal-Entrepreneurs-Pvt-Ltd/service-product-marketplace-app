import 'dart:convert';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/models/Action.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:lokal/utils/uiUtils/uiUtils.dart';
import '../constants.dart';
import '../actions.dart';
import '../utils/network/ApiRepository.dart';
import '../utils/network/retrofit/api_client.dart';

// add_to_kart
// remove form cart
// view details
// view FAQ

class UikProductPage extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.REMOVE_FROM_CART);
    actionList.add(UIK_ACTION.VIEW_DETAILS);
    actionList.add(UIK_ACTION.VIEW_FAQ);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getProductScreen;
    // return fetchAlbum();
  }

  void onProductPageTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDERS:
        addToCarts(uikAction);
        break;
      case UIK_ACTION.OPEN_DETAILS:
        removeFromCart(uikAction);
        break;
      case UIK_ACTION.OPEN_WISHLIST:
        viewDetails(uikAction);
        break;
      case UIK_ACTION.OPEN_ADDRESS:
        viewFAQ(uikAction);
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

void viewFAQ(UikAction uikAction) {
  uiUtils.showToast("VIEW FAQ");
}

void viewDetails(UikAction uikAction) {
  uiUtils.showToast("VIEW DETAILS");
}

void removeFromCart(UikAction uikAction) {
  uiUtils.showToast("REMOVE FROM CART");
}

void addToCarts(UikAction uikAction) {
  uiUtils.showToast("ADDED TO CART");
}

Future<ApiResponse> fetchAlbum() async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.post(
    Uri.parse('${baseUrl}/products/get'),
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
