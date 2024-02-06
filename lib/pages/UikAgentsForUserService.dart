import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/ActionUtils.dart';

class UikAgentsForUserService extends StandardPage {
  Map<String, dynamic>? args;

  UikAgentsForUserService({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAllAgentsForUserService;
  }

  void onAgentsForUserServiceTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
  }

  @override
  getPageCallBackForAction() {
    return onAgentsForUserServiceTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.getAllAgentsForUserService;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}
