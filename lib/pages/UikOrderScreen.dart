import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/models/Action.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:lokal/utils/uiUtils/uiUtils.dart';

// view order details

class UikOrderScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ORDER_DETAIL);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getOrderScreen;
  }

  void onOrderScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ORDER_DETAIL:
        orderDetail(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onOrderScreenTapAction;
  }

  @override
  getPageContext() {
    return UikOrderScreen;
  }
}

void orderDetail(UikAction uikAction) {
  uiUtils.showToast("ORDER DETAILS");
}
