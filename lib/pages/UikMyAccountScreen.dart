// import 'dart:js';

import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';


class UikMyAccountScreen extends StandardPage {
  // final obj = Snack();
  final dynamic args;
  UikMyAccountScreen({this.args});
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_ORDER_HISTORY);
    actionList.add(UIK_ACTION.OPEN_MY_DETAILS);
    actionList.add(UIK_ACTION.OPEN_WISHLIST);
    actionList.add(UIK_ACTION.OPEN_ADDRESS);
    actionList.add(UIK_ACTION.OPEN_PAYMENT);
    actionList.add(UIK_ACTION.OPEN_SIGN_OUT);
    actionList.add(UIK_ACTION.OPEN_MY_ADDRESS);
    actionList.add(UIK_ACTION.OPEN_LOG_IN);
    actionList.add(UIK_ACTION.OPEN_MY_AGENT);
    actionList.add(UIK_ACTION.OPEN_MY_REWARDS);
    actionList.add(UIK_ACTION.PROFILE_SCREEN);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMyAccountScreen;
  }

  void onMyAccountScreenTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
    ActionUtils.sendEventonActionForScreen(
        uikAction.tap.type.toString(), ScreenRoutes.myAccountScreen);
  }

  @override
  getPageCallBackForAction() {
    return onMyAccountScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.myAccountScreen;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}

void clearDataAndMoveToOnboarding() {
  UserDataHandler.clearUserToken();
  NavigationUtils.openScreen(ScreenRoutes.onboardingScreen, {});
  // todo mano recreate the main.dart by adding listners
}

void openPayment(UikAction uikAction) {
  UiUtils.showToast("PAYMENTS");
}

void openAddress(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myAddressScreen, {});
}

void openWishlist(UikAction uikAction) {
  UiUtils.showToast("WISHLIST");
}

void openDetails(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myDetailsScreen, {});
}

void openMyAgent(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myAgentListScreen, {});
}

void openMyRewards(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myRewardsPage, {});
}

void openOrders(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.orderHistoryScreen, {});
}

// Future<ApiResponse> getMockedApiResponse(args) async {
//   print("lavesh ${args}");
//   final response = await http.get(
//     Uri.parse('https://demo6536398.mockable.io/myAccount'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );
//
//   // StandardScreenResponse
//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
