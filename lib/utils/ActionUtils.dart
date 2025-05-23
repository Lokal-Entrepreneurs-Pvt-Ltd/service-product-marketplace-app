import 'dart:io';
import 'package:digia_ui/digia_ui.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lokal/main.dart';
import 'package:lokal/utils/Logs/event.dart';
import 'package:lokal/utils/Logs/event_handler.dart';
import 'package:lokal/utils/Logs/eventsdk.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:location/location.dart' as loc;
abstract class ActionUtils {
  static void sendEventonActionForScreen(String actionType, String screenName) {
    if (EventSDK.sessionId.isNotEmpty && EventSDK.userId != null) {
      print('${EventSDK.sessionId}---------------');
      Event event = Event.build(
        name: actionType,
        route: screenName,
      );
      EventHandler.events(event: event);
    }
  }

  static void executeAction(UikAction uikAction) {
    Event event = Event.build(
        name: "Action_taken__${uikAction.tap.type}",
        action: "${uikAction.tap.type} ${uikAction.tap.data.url ?? ""}");
    try {
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
          NavigationUtils.openScreen(ScreenRoutes.userProfileInfo, {});
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
        case UIK_ACTION.ADD_ADDRESS:
          NavigationUtils.openScreen(ScreenRoutes.addAddressScreen);
          break;
        case UIK_ACTION.OPEN_LOKAL_QR:
          NavigationUtils.openScreen(ScreenRoutes.customerLokalQr);
          break;
        case UIK_ACTION.SHARE_WHATSAPP:
          UiUtils.shareOnWhatsApp(
              uikAction.tap.data.url!, uikAction.tap.data.skuId!);
          break;
        case UIK_ACTION.IMAGE_PICKER:
          handleImageSelection();
          break;
        default:
          {}
      }
    } catch (e) {
      event.updateParameters(actionError: e.toString());
    }
    event.fire();
  }

  static void handleImageSelection() async {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    final ImagePicker picker = ImagePicker();
    int? type = await Bottomsheets.showBottomListDialog(
      context: context!,
      name: "Select Category",
      call: () async {
        return DataForFunction(index: -1, list: ["By Camera", "By Gallery"]);
      },
      alternateColoring: false,
      searchField: false,
    );
    final XFile? result;
    if (type == 0) {
      result = await picker.pickImage(source: ImageSource.camera);
    } else if (type == 1) {
      result = await picker.pickImage(source: ImageSource.gallery);
    } else {
      return;
    }

    if (result != null) {
      try {
        File pickedFile = File(result.path);
        await NavigationUtils.showLoaderOnTop();

        final tempDir = await getTemporaryDirectory();
        final tempFilePath =
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        File? compressedFile =
            await compressImage(pickedFile, tempFilePath, 70);
        if (compressedFile != null) {
          if (compressedFile.lengthSync() > 3000000) {
            await NavigationUtils.showLoaderOnTop(false);
            UiUtils.showToast("Image size should be less than 3 MB");
            return;
          }
          UiUtils.showToast("Uploading Profile Picture ");
          final response = await ApiRepository.uploadDocuments(
            ApiRequestBody.getuploaddocumentsid(
              "misc",
              compressedFile!,
            ),
          );
          compressedFile.delete();
          await tempDir.delete(recursive: true);
          if (response.isSuccess!) {
            String imageUrl = response.data["url"];
            final response2 = await ApiRepository.updateCustomerInfo(
                {"profilePicUrl": imageUrl});
            if (response2.isSuccess!) {
              UiUtils.showToast("Profile Picture Updated");
              NavigationUtils.pop();
              NavigationUtils.openScreen(ScreenRoutes.accountSettings, {});
              return;
            } else {
              UiUtils.showToast("Image is not uploaded successfully");
            }
          } else {
            UiUtils.showToast("Image is not uploaded successfully");
          }
        }
      } catch (e) {
        UiUtils.showToast(e.toString());
      } finally {
        await NavigationUtils.showLoaderOnTop(false);
      }
    } else {
      UiUtils.showToast("Image is not Selected");
    }
  }

  static Future<File?> compressImage(
      File imageFile, String path, int quality) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      path,
      quality: quality,
    );
    if (compressedFile != null) {
      return File(compressedFile.path);
    } else {
      return null;
    }
  }

  static void clearDataAndMoveToOnboarding(UikAction uikAction) {
    UserDataHandler.clearUserToken();
    DUIAppState().update<String>('bearerToken', '');
    NavigationUtils.popAllAndPush(ScreenRoutes.onboardingScreen, {});
    LokalApp.resetAppState();
    // todo mano recreate the main.dart by adding listners
  }

  static void handleSelectedLocation() async {
    try {
      UiUtils.showToast("Location is Updating");
      await NavigationUtils.showLoaderOnTop();

      loc.LocationData? position = await LocationUtils.getCurrentPosition();
      if (position != null && position.latitude != null && position.longitude != null) {
        double lat = position.latitude!;
        double long = position.longitude!;

        List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
        Placemark place = placemarks.first;

        final response = await ApiRepository.updateCustomerInfo({
          "latitude": lat,
          "longitude": long,
          "street": place.street,
          "isoCountryCode": place.isoCountryCode,
          "country": place.country,
          "postalCode": place.postalCode,
          "placeName": place.name,
          "administrativeArea": place.administrativeArea,
          "subAdministrativeArea": place.subAdministrativeArea,
          "locality": place.locality,
          "subLocality": place.subLocality,
        });

        await NavigationUtils.showLoaderOnTop(false);

        if (response.isSuccess!) {
          UiUtils.showToast("Location Updated");
          NavigationUtils.popAllAndPush(ScreenRoutes.uikBottomNavigationBar);
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }

        print('Latitude: $lat, Longitude: $long');
      } else {
        await NavigationUtils.showLoaderOnTop(false);
        print('Failed to retrieve the current location.');
      }
    } catch (e) {
      UiUtils.showToast("Error: $e");
    } finally {
      await NavigationUtils.showLoaderOnTop(false);
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
