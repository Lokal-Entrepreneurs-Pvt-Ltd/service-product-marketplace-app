
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/NavigationUtils.dart';



class UikDummyScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.BACK_PRESSED);
    actionList.add(UIK_ACTION.OPEN_PAGE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
  }

  void onOdOpScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {

      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
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
    return UikDummyScreen;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}



