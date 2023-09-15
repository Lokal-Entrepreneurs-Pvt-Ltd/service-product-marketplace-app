import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';

class UikCustomerForUserService extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAllCustomerForUserService;
  }

  void onCustomerForUserServiceTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCustomerForUserServiceTapAction;
  }

  @override
  getPageContext() {
    return UikCustomerForUserService;
  }

  @override
  getConstructorArgs() {
    return {
      "serviceId": "16",
      "serviceCode": "b2b_commerce"
    };
  }
}
