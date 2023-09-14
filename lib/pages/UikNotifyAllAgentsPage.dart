import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../utils/NavigationUtils.dart';

class UikNotifyAllAgentsPage extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    // actionList.add(UIK_ACTION.OPEN_CART);
    // actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getProductScreen;
    //return fetchAlbum;
  }

  void onNotifyAgentsTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_CART:
        // showCartScreen(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onNotifyAgentsTapAction;
  }

  @override
  getPageContext() {
    return UikNotifyAllAgentsPage;
  }

  @override
  getConstructorArgs() {
    return {};
  }
}

// void showCartScreen(UikAction uikAction) async {
//   String skuId = await ProductDataHandler.getProductSkuId();
//   NavigationUtils.showLoaderOnTop();

//   dynamic response = await ApiRepository.updateCart(
//       ApiRequestBody.getUpdateCartRequest(
//           skuId, "add", CartDataHandler.getCartId()));

//   NavigationUtils.pop();

//   if (response.isSuccess!) {
//     var cartIdReceived = response.data[CART_DATA][CART_ID];
//     CartDataHandler.saveCartId(cartIdReceived);
//     var context = NavigationService.navigatorKey.currentContext;
//     DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
//   } else {
//     UiUtils.showToast(response.error![MESSAGE]);
//   }
// }
