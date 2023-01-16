import 'dart:convert';

import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/network/retrofit/api_client.dart';
import 'package:lokal/utils/uiUtils/uiUtils.dart';

// open product

class UikCatalogScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_PRODUCT);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCatalogue;
  }

  void onCatalogScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_PRODUCT:
        openProduct(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCatalogScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCatalogScreen;
  }
}

void openProduct(UikAction uikAction) {
  uiUtils.showToast("OPEN PRODUCT");
}

// remove fetch() from all screen

// Future<ApiResponse> fetchAlbum(args) async {
//   print("catalogue screen");
//   print("lavesh ${args}");
//   final response = await http.post(
//     Uri.parse('https://bc4c-1-38-54-6.ngrok.io/products/get'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//     body: args,
//   );

//   // StandardScreenResponse
//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed uuu to load album');
//   }

  // final dio = Dio();

  // dio.options.headers["ngrok-skip-browser-warning"] = "value";

  // final client = StandardScreenClient(dio, baseUrl: "http://localhost:3000/");

  // ApiResponse response = await client.getbackendScreen();
  // print(response);

  // return StandardScreenResponse.fromJson(response.data);
// }

/* Future<StandardScreenResponse> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://demo1595178.mockable.io/CatalogScreen'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
} */
