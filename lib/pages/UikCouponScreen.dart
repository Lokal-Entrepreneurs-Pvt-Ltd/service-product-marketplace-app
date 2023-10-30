import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

// apply and rmeove coupon

class UikCouponScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.REMOVE_COUPON);
    actionList.add(UIK_ACTION.APPLY_COUPON);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getCouponScreen;
  }

  void onCouponScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.APPLY_COUPON:
        applyCoupon(uikAction);
        break;
      case UIK_ACTION.REMOVE_COUPON:
        removeCoupon(uikAction);
        break;

      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onCouponScreenTapAction;
  }

  @override
  getPageContext() {
    return ScreenRoutes.couponScreen;
  }
  @override
  getConstructorArgs() {
   return {};
  }
}

void applyCoupon(UikAction uikAction) {
  UiUtils.showToast("APPLY COUPON");
}

void removeCoupon(UikAction uikAction) {
  UiUtils.showToast("REMOVE COUPON");
}

// Future<ApiResponse> getMockedApiResponse(args) async {
//   final queryParameter = {
//     "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
//   };

//   final response = await http.get(
//     Uri.parse('http://demo7907509.mockable.io/couponScreen'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );

//   print(response.body);

//   if (response.statusCode == 200) {
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
