import 'dart:convert';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';

class UikServicesLanding extends StandardPage {

  Map<String, dynamic>? args;

  UikServicesLanding({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};

    actionList.add(UIK_ACTION.OPEN_PAGE);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    actionList.add(UIK_ACTION.SELECT_LOCATION);

    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getServicesLandingScreen;
    // return getMockedApiResponse;
  }

  void onHomeScreenTapAction(UikAction uikAction) {
    // print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      // case UIK_ACTION.SELECT_LOCATION:
      //   LocationUtils.getCurrentPosition();
      //   break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.serviceLandingScreen;
  }

  @override
  getConstructorArgs() {
    return args;
  }
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
