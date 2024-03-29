import 'dart:convert';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../screen_routes.dart';
import '../utils/NavigationUtils.dart';
import '../utils/network/ApiRepository.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

// search product action

class UikSearchCatalog extends StandardPage {

  Map<String, dynamic>? args;

  UikSearchCatalog({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_SEARCH);
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    actionList.add(UIK_ACTION.BACK_PRESSED);
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
      case UIK_ACTION.OPEN_CATEGORY:
        NavigationUtils.openCategory(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.ON_TEXT_EDIT_COMPLETE:
        print('search screen action');
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
    return ScreenRoutes.searchScreen;
  }
  @override
  getConstructorArgs() {
   return args;
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
