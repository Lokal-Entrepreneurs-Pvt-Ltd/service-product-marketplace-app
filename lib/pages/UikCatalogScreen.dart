import 'dart:convert';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';

class UikCatalogScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.OPEN_PRODUCT);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCatalogue;
    //return fetchAlbum;
  }

  void onCatalogScreenTapAction(UikAction uikAction) {
    print("___________________UIK-ACTION_____________________f_");

    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_PRODUCT:
        openProduct(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCatalogScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCatalogScreen;
  }

  @override
  getConstructorArgs() {
   return {};
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/cataloguescreen'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

void openProduct(UikAction uikAction) {
  //Navigation to the product screen
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}
