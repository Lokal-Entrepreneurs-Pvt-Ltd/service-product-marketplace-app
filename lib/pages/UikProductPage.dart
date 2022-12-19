import 'dart:convert';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../utils/network/retrofit/api_client.dart';
class UikProductPage extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    return StandardScreenClient(Dio(BaseOptions(contentType: "application/json"))).getHomeScreen();
  }

  @override
  getPageCallBackForAction() {
    return of;
  }

  void of() {}

  @override
  getPageContext() {
    return UikProductPage;
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('http://demo7907509.mockable.io/ProductPage'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponsee
  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
