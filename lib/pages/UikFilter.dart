import 'dart:convert';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/network/retrofit/api_client.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

// add and remove filter

class UikFilter extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ADD_FILTER);
    actionList.add(UIK_ACTION.REMOVE_FILTER);
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    return StandardScreenClient(
            Dio(BaseOptions(contentType: "application/json")))
        .getHomeScreen("");
  }

  @override
  getPageCallBackForAction() {
    return onFilterTapAction;
  }

  void onFilterTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_FILTER:
        addFilter(uikAction);
        break;
      case UIK_ACTION.REMOVE_FILTER:
        removeFilter(uikAction);
        break;
      default:
    }
  }

  @override
  getPageContext() {
    return UikFilter;
  }
}

void removeFilter(UikAction uikAction) {
  UiUtils.showToast("REMOVE FILTER");
}

void addFilter(UikAction uikAction) {
  UiUtils.showToast("ADD FILTER");
}

// Future<StandardScreenResponse> getMockedApiResponse() async {
//   final queryParameter = {
//     "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
//   };
//   final response = await http.get(
//     Uri.parse('http://demo3348922.mockable.io/sdkWalkthrough'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );

//   if (response.statusCode == 200) {
//     return StandardScreenResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
