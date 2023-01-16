import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/models/Action.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:lokal/utils/uiUtils/uiUtils.dart';

// pay_online
// pay_cod
//

class UikPaymentDetailsScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.PAY_ONLINE);
    actionList.add(UIK_ACTION.PAY_COD);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getPaymentDetailsScreen;
  }

  void onPaymentDetailsScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_ORDERS:
        payOnline(uikAction);
        break;
      case UIK_ACTION.OPEN_DETAILS:
        payCOD(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onPaymentDetailsScreenTapAction;
  }

  @override
  getPageContext() {
    return UikPaymentDetailsScreen;
  }
}

void payCOD(UikAction uikAction) {
  uiUtils.showToast("PAY COD");
}

void payOnline(UikAction uikAction) {
  uiUtils.showToast("PAY ONLINE");
}
