import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';

class UikDynamicPage extends StandardPage {
  Map<String, dynamic>? args;

  UikDynamicPage({this.args});

  @override
  Set<String?> getActions() {
    return {};
  }

  @override
  dynamic getData() {
    return ApiRepository.getDynamicLandingPage;
  }

  void onJobsLandingPageTapAction(UikAction uikAction) {
    ActionUtils.executeAction(uikAction);
    ActionUtils.sendEventonActionForScreen(
        uikAction.tap.type.toString(), ScreenRoutes.dynamicPage);
  }

  @override
  getPageCallBackForAction() {
    return onJobsLandingPageTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.dynamicPage;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}
