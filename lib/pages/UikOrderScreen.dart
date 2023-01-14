import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';

class UikOrderScreen extends StandardPage {
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
    return ApiRepository.getOrderScreen;
  }

  void onOrderScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onOrderScreenTapAction;
  }

  @override
  getPageContext() {
    return UikOrderScreen;
  }
}
