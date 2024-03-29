import 'dart:convert';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';
import '../utils/NavigationUtils.dart';

class UikMyGames extends StandardPage {

  Map<String, dynamic>? args;

  UikMyGames({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAllGames;
    //return getMockedApiResponse;
  }

  void onMyGamesTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onMyGamesTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.myGames;
  }
  @override
  getConstructorArgs() {
   return args;
  }
}

void openProduct(UikAction uikAction) {
  //Navigation to the product screen
  NavigationUtils.openPage(uikAction);
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('http://demo8751245.mockable.io/mygames'),
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
  // var skuId = uikAction.tap.data.skuId;
  //
  // //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });
  //
  // //displaying response from update cart
  // print("statusCode ${response.body}");
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  print(
      "_____________________________Catalogue call___________________________");
  NavigationUtils.openPage(uikAction);
}
