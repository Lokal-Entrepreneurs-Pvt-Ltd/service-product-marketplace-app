import 'dart:convert';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../utils/deeplink_handler.dart';
import '../constants.dart';
import '../main.dart';

class UikHome extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_CATEGORY");
    actionList.add("OPEN_ISP");
    actionList.add("ADD_TO_CART");
    return actionList;
  }

  @override
  dynamic getData() {
    return fetchAlbum;
  }

  void onHomeScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case "ADD_TO_CART":
        addToCart(uikAction);
        break;
      case "OPEN_CATEGORY":
        openCategory(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return UikHome;
  }
}

Future<ApiResponse> fetchAlbum(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.post(
    Uri.parse('https://bc4c-1-38-54-6.ngrok.io/discovery/get'),
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
  final response =
      await http.post(Uri.parse('${baseUrl}/cart/update'), headers: {
    "ngrok-skip-browser-warning": "value",
  }, body: {
    "skuId": skuId,
    "cartId": "",
    "action": "add"
  });

  //displaying response from update cart
  print("statusCode ${response.body}");
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}
