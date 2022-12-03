import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;



class UikFilter extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<StandardScreenResponse> getData() {
    // TODO: implement getData
    return fetchAlbum();
  }
}

Future<StandardScreenResponse> fetchAlbum() async {

  final queryParameter = {
   "id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse(
        'http://demo3348922.mockable.io/sdkWalkthrough'),
    headers: {
      "ngrok-skip-browser-warning": "value",

    },
  );

  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}