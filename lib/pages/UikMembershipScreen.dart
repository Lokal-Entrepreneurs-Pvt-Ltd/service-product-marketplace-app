import 'dart:convert';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants/json_constants.dart';
import '../actions.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/storage/cart_data_handler.dart';

class UikMembershipScreen extends StandardPage {
  Map<String, dynamic>? args;

  UikMembershipScreen({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};

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
    return ScreenRoutes.membershipLanding;
  }

  @override
  getConstructorArgs() {
    return args;
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
    NavigationUtils.openPage(uikAction);
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
