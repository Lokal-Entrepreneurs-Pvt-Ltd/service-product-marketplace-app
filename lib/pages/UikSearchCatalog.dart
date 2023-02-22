import 'dart:convert';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/models/Action.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';
import '../utils/network/ApiRepository.dart';
import '../utils/network/retrofit/api_client.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

// search product action

class UikSearchCatalog extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_SEARCH);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getSearchScreen;
    // return getMockedApiResponse;
  }

  void onSearchCatalogTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDER_HISTORY:
        openSearch(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onSearchCatalogTapAction;
  }

  @override
  getPageContext() {
    return UikSearchCatalog;
  }
}

void openSearch(UikAction uikAction) {
  UiUtils.showToast("OPEN SEARCH");
}

Future<ApiResponse> getMockedApiResponse() async {
  final response = await http.get(
    Uri.parse('https://v.mockable.io/SearchCategory'),
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
