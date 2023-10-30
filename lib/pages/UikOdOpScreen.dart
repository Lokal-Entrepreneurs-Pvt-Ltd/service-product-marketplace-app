
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../main.dart';
import '../utils/NavigationUtils.dart';
import '../utils/deeplink_handler.dart';

class UikOdOpScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.BACK_PRESSED);
    actionList.add(UIK_ACTION.OPEN_PAGE);
    actionList.add(UIK_ACTION.OPEN_PRODUCT);
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getOdOpScreen;
  }

  void onOdOpScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {

      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      case UIK_ACTION.OPEN_PRODUCT:
        openProduct(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        NavigationUtils.openCategory(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onOdOpScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.odOpHomeScreen;
  }

  @override
  getConstructorArgs() {
    return {
      "state": "UTTAR PRADESH",
      "district": "AGRA"
    };
  }
}

void openProduct(UikAction uikAction) {
  //Navigation to the product screen
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}

