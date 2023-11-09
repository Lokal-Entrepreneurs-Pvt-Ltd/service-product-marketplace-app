import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/ApiResponseState.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/utils/datastore_utils/datastore_utils.dart';

import '../actions.dart';

class UikHome extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.ADD_TO_CART);
    actionList.add(UIK_ACTION.OPEN_PRODUCT);
    actionList.add(UIK_ACTION.OPEN_PAGE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getHomescreen;
    // return getMockedApiResponse;
  }

  void onHomeScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_TO_CART:
        addToCart(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        NavigationUtils.openCategory(uikAction);
        break;
      case UIK_ACTION.OPEN_PRODUCT:
        NavigationUtils.openCategory(uikAction);
        break;
      case UIK_ACTION.OPEN_ISP:
        openIsp(uikAction);
        break;
      case UIK_ACTION.OPEN_PAGE:
        var cubit = AppRoutes.rootNavigatorKey.currentContext!
            .read<StandardScreenResponseCubit>();
        var apiCubit = AppRoutes.rootNavigatorKey.currentContext!
            .read<ApiResponseCubit>();
        DataStoreUtils().updateScreenResponse(
          ScreenRoutes.homeScreen,
          cubit,
          apiCubit,
          [
            StandardPageResponseWidgets.fromJson(
                {"id": "uikAgentWelcomeTile", "uiType": "UikListTile"}),
          ],
          {
            "id": "UikListTile",
            "title": {
              "id": "txt",
              "text": "Welcome Premansh",
              "size": 24.0,
              "color": "#000000",
              "fontWeight": "FontWeight.w600",
              "normalFontWeight": "FontWeight.w600",
              "isCenter": false,
              "leftMargin": 0.0,
              "topMargin": 0.0,
              "rightMargin": 0.0,
              "bottomMargin": 0.0
            },
            "isGradient": true,
            "subtitle": {
              "id": "UikSimpleRow",
              "alignment": "centerLeft",
              "widgets": [
                {
                  "id": "txt",
                  "text": "Lokal PARTNER",
                  "size": 14.0,
                  "fontWeight": "FontWeight.w500",
                  "color": "#9E9E9E",
                  "textAlign": "TextAlign.center",
                  "isStrike": false,
                  "leftMargin": 0.0
                }
              ]
            },
            "trailing": {
              "id": "avatar",
              "backgroundColor": "#86CF9E",
              "backgroundImage":
                  "https://img.freepik.com/free-icon/user-male-shape-circle-ios-7-interface-symbol_318-35357.jpg",
              "radius": 20.0
            },
            "action": {
              "tap": {
                "type": "OPEN_PAGE",
                "data": {"url": "https://lokalcompany.in/myAccount"}
              }
            }
          },
        );
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.homeScreen;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}

void openIsp(UikAction uikAction) {
  final BuildContext context = AppRoutes.rootNavigatorKey.currentContext!;
  NavigationUtils.openScreen(ScreenRoutes.ispHome, {});
}

// void openProduct(UikAction uikAction) {
//   //Navigation to the product screen
//   var context = NavigationService.navigatorKey.currentContext;
//   DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
// }

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse('http://demo8222596.mockable.io/home'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

void addToCart(UikAction uikAction) async {
  // late List<StandardPageResponseWidgets> widgets;
  // late Map<String, dynamic>? dataStore = null;

  // DatastoreUtils.updateScreenResponse(ScreenRoutes.homeScreen,widgets,dataStore)
  // fetch standard screen response from the map based on screen route
  // iterate over widgets if they don't exists in SCR, insert widgets in SCR datastore response
  // if widget exists in dataStore replace the dataStore object with dataStore recived in input
  // add empty dataSource in get widget function

  // var skuId = uikAction.tap.data.skuId;
  //
  // //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });
  //
  // //displaying response from update cart
  // print("statusCode ${response.body}");
}
