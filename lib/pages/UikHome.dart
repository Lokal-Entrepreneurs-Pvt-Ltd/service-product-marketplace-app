import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/Logs/eventsdk.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/Logs/event.dart';
import 'package:lokal/utils/Logs/event_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
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
    
    EventSDK eventSDK = EventSDK();
    eventSDK.init();
    if (EventSDK.sessionId.isNotEmpty && EventSDK.userId != null) {
      print('${EventSDK.sessionId}---------------');
      Event event = Event(
        name: uikAction.tap.type.toString(),
        parameters: {
          "sessionId": EventSDK.sessionId,
          "userId": EventSDK.userId,
          "pageName": ScreenRoutes.homeScreen
        },
      );
      EventHandler.events(event: event);
    }
    
    ActionUtils.executeAction(uikAction);
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
