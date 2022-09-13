import 'dart:convert';

import 'package:flutter/material.dart';
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


class CartPage extends StandardPage {
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
   "id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse(
        'http://demo6005406.mockable.io/getLayout'),
    headers: {
      "ngrok-skip-browser-warning": "value",
      //"id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
      //"token" : "kPvSO_ItE-6Oun01yHlJ5VcUXapnGqCxAy3t6LWDmVw.eyJpbnN0YW5jZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2IiwiYXBwRGVmSWQiOiIyMmJlZjM0NS0zYzViLTRjMTgtYjc4Mi03NGQ0MDg1MTEyZmYiLCJtZXRhU2l0ZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2Iiwic2lnbkRhdGUiOiIyMDIyLTA5LTEyVDE0OjM1OjU2LjQwMloiLCJ1aWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgiLCJwZXJtaXNzaW9ucyI6Ik9XTkVSIiwiZGVtb01vZGUiOmZhbHNlLCJzaXRlT3duZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsInNpdGVNZW1iZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsImV4cGlyYXRpb25EYXRlIjoiMjAyMi0wOS0xMlQxODozNTo1Ni40MDJaIiwibG9naW5BY2NvdW50SWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgifQ"   
    },
  );


  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}