import 'dart:convert';

import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';

import '../utils/network/retrofit/api_client.dart';
class UikCatalogScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    actionList.add("OPEN_ROUTE");
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    return ApiRepository.getCatalogue();
  }

  void onCatalogScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onCatalogScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCatalogScreen;
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
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

  // final dio = Dio();

  // dio.options.headers["ngrok-skip-browser-warning"] = "value";

  // final client = StandardScreenClient(dio, baseUrl: "http://localhost:3000/");

  // ApiResponse response = await client.getbackendScreen();
  // print(response);

  // return StandardScreenResponse.fromJson(response.data);
}

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
