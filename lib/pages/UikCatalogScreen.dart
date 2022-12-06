import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login/StandardScreenClient.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/StandardScreenResponse.dart';

import '../constants.dart';

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
}

Future<StandardScreenResponse> fetchAlbum() async {
  // final response = await http.post(
  //   Uri.parse('http://localhost:3000/discovery/get'),
  //   headers: {
  //     "ngrok-skip-browser-warning": "value",
  //     //"id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  //     //"token" : "h45ngvJIR7PjW-MXpLaUWlKdrwk3CNjerz9U1QnK1AA.eyJpbnN0YW5jZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2IiwiYXBwRGVmSWQiOiIyMmJlZjM0NS0zYzViLTRjMTgtYjc4Mi03NGQ0MDg1MTEyZmYiLCJtZXRhU2l0ZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2Iiwic2lnbkRhdGUiOiIyMDIyLTA5LTE0VDExOjM0OjQ0Ljg4MloiLCJ1aWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgiLCJwZXJtaXNzaW9ucyI6Ik9XTkVSIiwiZGVtb01vZGUiOmZhbHNlLCJzaXRlT3duZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsInNpdGVNZW1iZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsImV4cGlyYXRpb25EYXRlIjoiMjAyMi0wOS0xNFQxNTozNDo0NC44ODJaIiwibG9naW5BY2NvdW50SWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgifQ"
  //   },
  // );
  // dynamic res = json.decode(response.body);
  // print(response.body);
  // if (response.statusCode == 200) {
  //   return StandardScreenResponse.fromJson(res['data']['response']);
  // } else {
  //   throw Exception('Failed to load album');
  // }

  final dio = Dio();

  dio.options.headers["ngrok-skip-browser-warning"] = "value";

  final client = StandardScreenClient(dio, baseUrl: "http://localhost:3000/");

  ApiResponse response = await client.getbackendScreen();
  print(response);

  return StandardScreenResponse.fromJson(response.data);
}
