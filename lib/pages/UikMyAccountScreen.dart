import 'dart:convert';

import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../utils/network/retrofit/api_client.dart';

class UikMyAccountScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_ORDERS");
    actionList.add("OPEN_DETAILS");
    actionList.add("OPEN_WISHLIST");
    actionList.add("OPEN_ADDRESS");
    actionList.add("OPEN_PAYMENT");
    actionList.add("OPEN_SIGN_OUT");
    return actionList;
  }

  @override
  dynamic getData() {
    return fetchAlbum;
  }

  void onMyAccountScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case "OPEN_ORDERS":
        openOrders(uikAction);
        break;
      case "OPEN_DETAILS":
        openDetails(uikAction);
        break;
      case "OPEN_WISHLIST":
        openWishlist(uikAction);
        break;
      case "OPEN_ADDRESS":
        openAddress(uikAction);
        break;
      case "OPEN_PAYMENT":
        openPayment(uikAction);
        break;
      case "OPEN_SIGN_OUT":
        openSign(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onMyAccountScreenTapAction;
  }

  @override
  getPageContext() {
    return UikMyAccountScreen;
  }
}

void openSign(UikAction uikAction) {}

void openPayment(UikAction uikAction) {}

void openAddress(UikAction uikAction) {}

void openWishlist(UikAction uikAction) {}

void openDetails(UikAction uikAction) {}

void openOrders(uikAction) {}

Future<ApiResponse> fetchAlbum(args) async {
  print("lavesh ${args}");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/myAccount'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
