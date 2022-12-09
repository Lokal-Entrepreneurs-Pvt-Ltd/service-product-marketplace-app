import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;

class UikProductPage extends StandardPage {
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

  @override
  getPageCallBackForAction() {
    // TODO: implement getFunction
    throw UnimplementedError();
  }

  @override
  getPageContext() {
    // TODO: implement getReference
    throw UnimplementedError();
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
