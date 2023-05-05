import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../constants/json_constants.dart';
import '../main.dart';
import '../actions.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/storage/cart_data_handler.dart';

class UikMembershipScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();

    actionList.add(UIK_ACTION.BACK_PRESSED);
    actionList.add(UIK_ACTION.OPEN_CART);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMembershipScreen;
    // return getMockedApiResponse;
  }

  void membershipScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_CART:
        addMembershipToCart(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return membershipScreenTapAction;
  }

  @override
  getPageContext() {
    return UikMembershipScreen;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}

void addMembershipToCart(UikAction uikAction) async {
  var skuIdvalue = uikAction.tap.data.value;
  NavigationUtils.showLoaderOnTop();
  dynamic response = await ApiRepository.membershipUpdateCart(
      ApiRequestBody.getUpdateCartRequest(
          skuIdvalue!, "add", CartDataHandler.getCartId()));

  NavigationUtils.pop();

  if (response.isSuccess!) {
    var cartIdReceived = response.data[CART_ID];
    CartDataHandler.saveCartId(cartIdReceived);
    var context = NavigationService.navigatorKey.currentContext;
    DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  } else {
    UiUtils.showToast(response.error![MESSAGE]);
    NavigationUtils.pop();
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('http://demo7588460.mockable.io/ispHome'),
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
