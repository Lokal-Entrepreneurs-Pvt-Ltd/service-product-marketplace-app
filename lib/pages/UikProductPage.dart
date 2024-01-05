import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import '../actions.dart';
import '../utils/ActionUtils.dart';
import '../utils/NavigationUtils.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/storage/product_data_handler.dart';

class UikProductPage extends StandardPage {

  Map<String, dynamic>? args;

  UikProductPage({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_CART);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getProductScreen;
    //return fetchAlbum;
  }

  void onProductPageTapAction(UikAction uikAction) {

    ActionUtils.executeAction(uikAction);
  }

  @override
  getPageCallBackForAction() {
    return onProductPageTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.productScreen;
  }

  @override
  getConstructorArgs() {
    return args;
  }
}


