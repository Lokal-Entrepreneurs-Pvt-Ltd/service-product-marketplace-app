import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../actions.dart';
import '../constants/json_constants.dart';
import '../constants/strings.dart';
import '../screen_routes.dart';
import 'NavigationUtils.dart';
import 'UiUtils/UiUtils.dart';
import 'network/ApiRepository.dart';
import 'network/ApiRequestBody.dart';
import 'storage/product_data_handler.dart';

abstract class ActionUtils {
  static void executeAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_WEB:
        NavigationUtils.openWeb(uikAction);
        break;
      case UIK_ACTION.ADD_TO_CART:
        addToCart(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        NavigationUtils.openCategory(uikAction);
        break;
      case UIK_ACTION.OPEN_PRODUCT:
        NavigationUtils.openCategory(uikAction);
        break;
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      case UIK_ACTION.OPEN_CART:
        showCartScreen(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_PRODUCT:
        NavigationUtils.openPage(uikAction);
        break;

      case UIK_ACTION.ADD_ADDRESS:
        addAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_ADDRESS:
        if (UserDataHandler.getIsUserVerified()) {
          openAddress(uikAction);
        } else {
          openMyDetails();
        }
        break;
      case UIK_ACTION.REMOVE_FROM_CART:
        removeCartItem(uikAction);
        break;
      case UIK_ACTION.REMOVE_CART_ITEM:
        removeCartItem(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      case UIK_ACTION.OPEN_PAGE:
        NavigationUtils.openPage(uikAction);
        break;
      case UIK_ACTION.FETCH_LOCATION:
        {
          handleSelectedLocation();
        }
        break;
      case UIK_ACTION.OPEN_ORDER_HISTORY:
        NavigationUtils.openScreen(ScreenRoutes.orderHistoryScreen, {});
        break;
      case UIK_ACTION.OPEN_MY_DETAILS:
        NavigationUtils.openScreen(ScreenRoutes.myDetailsScreen, {});
        break;
      case UIK_ACTION.OPEN_WISHLIST:
        UiUtils.showToast("WISHLIST");
        break;
      case UIK_ACTION.OPEN_ADDRESS:
        openAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_AGENT:
        NavigationUtils.openScreen(ScreenRoutes.myAgentListScreen, {});
        break;
      case UIK_ACTION.OPEN_MY_REWARDS:
        NavigationUtils.openScreen(ScreenRoutes.myRewardsPage, {});
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
        break;
      case UIK_ACTION.OPEN_MY_ADDRESS:
        openAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_SIGN_OUT:
        {
          UiUtils.showToast(LOG_OUT);
          clearDataAndMoveToOnboarding(uikAction);
        }
        break;
      case UIK_ACTION.OPEN_LOG_IN:
        {
          UiUtils.showToast(LOG_IN);
          clearDataAndMoveToOnboarding(uikAction);
        }
        break;
      case UIK_ACTION.PROFILE_SCREEN:
        NavigationUtils.openScreen(ScreenRoutes.profileScreen);
        break;
      default:
        {}
    }
  }

  static void clearDataAndMoveToOnboarding(UikAction uikAction) {
    UserDataHandler.clearUserToken();
    NavigationUtils.openScreen(ScreenRoutes.onboardingScreen, {});
    // todo mano recreate the main.dart by adding listners
  }

  static void handleSelectedLocation() async {
    Position? position = await LocationUtils.getCurrentPosition();
    if (position != null) {
      GeocodingPlatform geocodingPlatform = GeocodingPlatform.instance;
      geocodingPlatform.placemarkFromCoordinates(
          position.latitude, position.longitude);

      final response = await ApiRepository.updateCustomerInfo(
          ApiRequestBody.updateLatlong(position.latitude, position.longitude));
      if (response.isSuccess!) {
        UiUtils.showToast("Location Updated");
        NavigationUtils.openScreenUntil(ScreenRoutes.uikBottomNavigationBar);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
        return null;
      }
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } else {
      print('Failed to retrieve the current location.');
    }
  }

  static void openAddress(UikAction uikAction) {
    NavigationUtils.openPage(uikAction);
  }

  static void openMyDetails() {
    NavigationUtils.openScreen(ScreenRoutes.myDetailsScreen);
  }

  static void addToCart(UikAction uikAction) async {
    var skuId = uikAction.tap.data.skuId;

    //api call to update cart
    // final response =
    //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
    //   "ngrok-skip-browser-warning": "value",
    // }, body: {
    //   "skuId": skuId,
    //   "cartId": "",
    //   "action": "add"
    // });

    //displaying response from update cart
    // print("statusCode ${response.body}");

    NavigationUtils.openScreen(ScreenRoutes.cartScreen, {});
  }

  static void removeCartItem(UikAction uikAction) async {
    var skuId = uikAction.tap.data.skuId;
    var cartId = CartDataHandler.getCartId();
    NavigationUtils.showLoaderOnTop();
    dynamic response = await ApiRepository.updateCart(
      ApiRequestBody.getUpdateCartRequest(
        skuId!,
        "remove",
        cartId,
      ),
    );
    NavigationUtils.pop();

    if (response.isSuccess!) {
      var cartIdReceived = response.data[CART_DATA][CART_ID];
      CartDataHandler.saveCartId(cartIdReceived);
      NavigationUtils.openPage(uikAction);
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
    }
  }

  static void openCategory(UikAction uikAction) {
    //Navigation to the next screen through deepLink Handler
    NavigationUtils.openScreen(ScreenRoutes.catalogueScreen, {});
  }

  static void openProduct(UikAction uikAction) {
    NavigationUtils.openScreen(ScreenRoutes.productScreen);
  }

  static void openCoupon(UikAction uikAction) {
    NavigationUtils.openScreen(ScreenRoutes.couponScreen, {});
  }

  static void openCheckout(UikAction uikAction) {
    NavigationUtils.openScreen(ScreenRoutes.addressBookScreen, {});
  }

  static void addAddress(UikAction uikAction) {
    NavigationUtils.openScreen(ScreenRoutes.addAddressScreen, {});
  }

  static Future<void> openPayment(UikAction uikAction) async {
    if (uikAction.tap.data.key == TAP_ACTION_TYPE_KEY_ADDRESS_ID) {
      Map<String, dynamic>? args = {
        ADDRESS_ID: uikAction.tap.data.value,
        CART_ID: CartDataHandler.getCartId()
      };
      NavigationUtils.openScreen(ScreenRoutes.paymentDetailsScreen, args);
    }
  }

  static void showCartScreen(UikAction uikAction) async {
    String skuId = await ProductDataHandler.getProductSkuId();
    //NavigationUtils.showLoaderOnTop();

    dynamic response = await ApiRepository.updateCart(
        ApiRequestBody.getUpdateCartRequest(skuId, "add", ""));

    // NavigationUtils.pop();

    if (response.isSuccess!) {
      var cartIdReceived = response.data[CART_DATA][CART_ID];
      CartDataHandler.saveCartId(cartIdReceived);
      NavigationUtils.openPage(uikAction);
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
    }
  }
}
