import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/StandardScreenResponse.dart';

class UikCatalogScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<StandardScreenResponse> getData() {
    return fetchAlbum();
  }

  void of() {}

  @override
  getPageCallBackForAction() {
    // TODO: implement getPageCallBackForAction
    return of;
  }

  @override
  getPageContext() {
    // TODO: implement getPageContext
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
