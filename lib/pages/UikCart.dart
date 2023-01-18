import 'dart:convert';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/network/retrofit/api_client.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';

// check for duplicacy

// add to cart
// remove from cart

class UikCart extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.REMOVE_FROM_CART);
    return actionList;
  }

  @override
  dynamic getData() {
    return StandardScreenClient(
            Dio(BaseOptions(contentType: "application/json")))
        .getHomeScreen("");
  }

  @override
  getPageCallBackForAction() {
    return onCart;
  }

  void onCart(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_TO_CART:
        addTOCarts(uikAction);
        break;
      case UIK_ACTION.REMOVE_FROM_CART:
        removeFromCarts(uikAction);
        break;
      default:
    }
  }

  @override
  getPageContext() {
    return UikCart;
  }
}

void addTOCarts(UikAction uikAction) {
  UiUtils.showToast("ADDED TO CART");
}

void removeFromCarts(UikAction uikAction) {
  UiUtils.showToast("REMOVE FORM CART");
}

Future<StandardScreenResponse> fetchAlbum() async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse('http://demo3348922.mockable.io/getCart'),
    headers: {
      "ngrok-skip-browser-warning": "value",
      "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
      "token":
          "MCcuLmDAItWRB8YL85quqkN2JEXNaefJcZosDQYu9cE.eyJpbnN0YW5jZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2IiwiYXBwRGVmSWQiOiIyMmJlZjM0NS0zYzViLTRjMTgtYjc4Mi03NGQ0MDg1MTEyZmYiLCJtZXRhU2l0ZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2Iiwic2lnbkRhdGUiOiIyMDIyLTA5LTI4VDE5OjUwOjI0LjIyMloiLCJ1aWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgiLCJwZXJtaXNzaW9ucyI6Ik9XTkVSIiwiZGVtb01vZGUiOmZhbHNlLCJzaXRlT3duZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsInNpdGVNZW1iZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsImV4cGlyYXRpb25EYXRlIjoiMjAyMi0wOS0yOFQyMzo1MDoyNC4yMjJaIiwibG9naW5BY2NvdW50SWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgifQ"
    },
  );

  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
