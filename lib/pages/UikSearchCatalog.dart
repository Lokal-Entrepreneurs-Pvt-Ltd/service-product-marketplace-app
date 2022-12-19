import 'dart:convert';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';
import '../utils/network/retrofit/api_client.dart';
class UikSearchCatalog extends StandardPage {
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
    return UikSearchCatalog;
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://demo1595178.mockable.io/SearchCategory'),
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
}
