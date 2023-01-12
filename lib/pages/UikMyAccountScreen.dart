import 'dart:convert';

import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';

import '../utils/network/retrofit/api_client.dart';

class UikMyAccountScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    actionList.add("OPEN_ROUTE");
    return actionList;
  }

  @override
  dynamic getData() {
    return fetchAlbum;
  }

  void onMyAccountScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onMyAccountScreenTapAction;
  }

  @override
  getPageContext() {
    return UikMyAccountScreen;
  }
}

Future<ApiResponse> fetchAlbum(args) async {
  print("lavesh ${args}");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/myAccount'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
