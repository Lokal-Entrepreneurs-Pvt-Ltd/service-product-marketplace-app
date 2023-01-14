import 'dart:convert';
import 'dart:developer';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../utils/deeplink_handler.dart';
import '../constants.dart';
import '../main.dart';
import '../actions.dart';

class UikCouponScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.APPLY_COUPON);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCouponScreen;
  }

  void onCouponScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.APPLY_COUPON:
        applyCoupon(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCouponScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCouponScreen;
  }

  void applyCoupon(UikAction uikAction) {
    log("applyCoupon");
  }
}

Future<ApiResponse> fetchAlbum(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('http://demo7907509.mockable.io/couponScreen'),
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
