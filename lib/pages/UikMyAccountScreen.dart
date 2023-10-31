// import 'dart:js';

import 'package:go_router/go_router.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../constants/strings.dart';

class UikMyAccountScreen extends StandardPage {
  // final obj = Snack();
  Map<String, dynamic>? args;
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
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getMyAccountScreen;
  }

  void onMyAccountScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDER_HISTORY:
        openOrders(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_DETAILS:
        openDetails(uikAction);
        break;
      case UIK_ACTION.OPEN_WISHLIST:
        openWishlist(uikAction);
        break;
      case UIK_ACTION.OPEN_ADDRESS:
        openAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_AGENT:
        openMyAgent(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_REWARDS:
        openMyRewards(uikAction);
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_ADDRESS:
        openAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_SIGN_OUT:
        {
          UiUtils.showToast(LOG_OUT);
          clearDataAndMoveToOnboarding(uikAction);
        }
        break;
      case UIK_ACTION.OPEN_LOG_IN:
        {
          UiUtils.showToast(LOG_IN);
          clearDataAndMoveToOnboarding(uikAction);
        }
        break;
      default:
    }
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

void clearDataAndMoveToOnboarding(UikAction uikAction) {
  UserDataHandler.clearUserToken();
  AppRoutes.rootNavigatorKey.currentContext!.go(ScreenRoutes.onboardingScreen);
  // todo mano recreate the main.dart by adding listners
}

void openPayment(UikAction uikAction) {
  UiUtils.showToast("PAYMENTS");
}

void openAddress(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myAddressScreen);
}

void openWishlist(UikAction uikAction) {
  UiUtils.showToast("WISHLIST");
}

void openDetails(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myDetailsScreen);
}

void openMyAgent(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myAgentListScreen);
}

void openMyRewards(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.myRewardsPage);
}

void openOrders(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.orderHistoryScreen);
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
