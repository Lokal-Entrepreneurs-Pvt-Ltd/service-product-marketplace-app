import 'dart:convert';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';
import '../utils/network/ApiRepository.dart';
import '../utils/network/retrofit/api_client.dart';
import '../actions.dart';

class UikSearchCatalog extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_WEB);
    actionList.add(UIK_ACTION.OPEN_HALA);
    actionList.add(UIK_ACTION.OPEN_ROUTE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getSearchScreen;
  }

  void onSearchCatalogTapAction() {}

  @override
  getPageCallBackForAction() {
    return onSearchCatalogTapAction;
  }

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
