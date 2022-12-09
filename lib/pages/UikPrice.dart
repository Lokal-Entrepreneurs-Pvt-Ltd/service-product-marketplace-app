import 'dart:convert';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;

class UikPrice extends StandardPage {
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
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse('https://8969-1-39-200-14.in.ngrok.io/getcart'),
    headers: {
      "ngrok-skip-browser-warning": "value",
      "id": "34f6221f-595a-474f-95a8-e6fe491ec62a",
      "token":
          "wKvzk08wyJdkgM-k6CfkrXzRmLPsWGlRAiCwort1pRw.eyJpbnN0YW5jZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2IiwiYXBwRGVmSWQiOiIyMmJlZjM0NS0zYzViLTRjMTgtYjc4Mi03NGQ0MDg1MTEyZmYiLCJtZXRhU2l0ZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2Iiwic2lnbkRhdGUiOiIyMDIyLTA5LTE1VDE0OjE1OjM3Ljg5OFoiLCJ1aWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgiLCJwZXJtaXNzaW9ucyI6Ik9XTkVSIiwiZGVtb01vZGUiOmZhbHNlLCJzaXRlT3duZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsInNpdGVNZW1iZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsImV4cGlyYXRpb25EYXRlIjoiMjAyMi0wOS0xNVQxODoxNTozNy44OThaIiwibG9naW5BY2NvdW50SWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgifQ"
    },
  );

  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
