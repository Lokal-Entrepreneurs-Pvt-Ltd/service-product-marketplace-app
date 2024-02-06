import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';

class UikCustomerLokalQr extends StandardPage {

  Map<String, dynamic>? args;

  UikCustomerLokalQr({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_LOKAL_QR);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCustomerLokalQr;
  }

  void onCustomerLokalQrTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
  }

  @override
  getPageCallBackForAction() {
    return onCustomerLokalQrTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.customerLokalQr;
  }
  @override
  getConstructorArgs() {
    return {};
  }
}



