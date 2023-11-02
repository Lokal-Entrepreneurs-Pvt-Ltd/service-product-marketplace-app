import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';

class UikCustomerForUserService extends StandardPage {

  Map<String, dynamic>? args;

  UikCustomerForUserService({this.args});

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
    return ScreenRoutes.getAllCustomerForUserService;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}
