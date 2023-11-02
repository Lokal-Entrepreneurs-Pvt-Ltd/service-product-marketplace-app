import 'dart:convert';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/network/ApiRequestBody.dart';
import '../utils/network/http/http_screen_client.dart';
import '../utils/storage/product_data_handler.dart';

class UikServiceDetail extends StandardPage {
  Map<String, dynamic>? args;

  UikServiceDetail({this.args});
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.SERVICE_OPTIN);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    // return getMockedApiResponse;
    return ApiRepository.getServiceDetailScreen;
  }

  void onHomeScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.SERVICE_OPTIN:
        obtinClick(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
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
    return ScreenRoutes.serviceScreen;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse('http://demo8222596.mockable.io/home'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

void obtinClick(UikAction uikAction) async {
  String serviceCode = await ProductDataHandler.getServiceCode();
  NavigationUtils.showLoaderOnTop();
  final response = await ApiRepository.submitOptin(
      ApiRequestBody.getOptinRequest(serviceCode));
  if (response.isSuccess!) {
    HttpScreenClient.displayDialogBox(response.data["message"]);
  }

  // NavigationUtils.pop();
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
