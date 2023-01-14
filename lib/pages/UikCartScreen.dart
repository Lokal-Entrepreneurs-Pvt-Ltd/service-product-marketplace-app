import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';

class UikEmptyCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_WEB);
    actionList.add(UIK_ACTION.OPEN_HALA);
    actionList.add(UIK_ACTION.OPEN_ROUTE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getEmptyCartScreen;
  }

  void onEmptyCartScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onEmptyCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikEmptyCartScreen;
  }
}

class UikCartScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_WEB);
    actionList.add(UIK_ACTION.OPEN_HALA);
    actionList.add(UIK_ACTION.OPEN_ROUTE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCartScreen;
  }

  void onCartScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onCartScreenTapAction;
  }

  @override
  getPageContext() {
    return UikCartScreen;
  }
}
