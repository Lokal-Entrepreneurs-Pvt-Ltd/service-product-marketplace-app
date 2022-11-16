import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/services/networkLibrary.dart';
import 'package:login/services/serviceType.dart';
import 'package:ui_sdk/StandardPage.dart';
//import 'package:ui_sdk/props/ResponseAlternate.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
// class UikDummy extends StatelessWidget {
//   const UikDummy({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("Screen2")),
//     );
//   }
// }

class UikHomePage extends StandardPage {
  // @override
  // Future<StandardScreenResponse> getData() {
  //   return fetchAlbum();
  // }

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
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await getResponse('/MainPageTwo', serviceType.get, null);

  print(response.body);
  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
