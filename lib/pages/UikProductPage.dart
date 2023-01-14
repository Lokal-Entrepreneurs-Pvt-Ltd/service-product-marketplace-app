import 'dart:convert';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../constants.dart';
import '../actions.dart';
import '../utils/network/ApiRepository.dart';
import '../utils/network/retrofit/api_client.dart';

class UikProductPage extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_WEB);
    actionList.add(UIK_ACTION.OPEN_HALA);
    actionList.add(UIK_ACTION.OPEN_ROUTE);
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    // return ApiRepository.getProductScreen();
    return fetchAlbum();
  }

  void onProductPageTapAction() {}

  @override
  getPageCallBackForAction() {
    return onProductPageTapAction;
  }

  @override
  getPageContext() {
    return UikProductPage;
  }
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
