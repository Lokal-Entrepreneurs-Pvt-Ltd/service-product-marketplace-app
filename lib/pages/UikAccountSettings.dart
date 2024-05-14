// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';

class UikAccountSettings extends StandardPage {
  UikAccountSettings();
  // args: state.extra as Map<String, dynamic>
  // Map<String, dynamic>? args;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.IMAGE_PICKER);
    actionList.add(UIK_ACTION.OPEN_SIGN_OUT);
    actionList.add(UIK_ACTION.OPEN_PAGE);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAccountSettings;
  }

  void onAccountSettingsTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
  }

  @override
  getPageCallBackForAction() {
    return (UikAction uikAction) {
      onAccountSettingsTapAction(uikAction);
    };
  }

  @override
  getPageContext() {
    return ScreenRoutes.accountSettings;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}
