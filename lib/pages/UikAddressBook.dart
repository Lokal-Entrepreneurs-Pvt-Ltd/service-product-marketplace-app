import 'dart:convert';
// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../utils/deeplink_handler.dart';
import '../constants.dart';
import '../main.dart';
import '../actions.dart';
import 'package:lokal/utils/uiUtils/uiUtils.dart';

// add adress
// remove add
// delete address

class UikAddressBook extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    actionList.add(UIK_ACTION.REMOVE_ADDRESS);
    actionList.add(UIK_ACTION.DELETE_ADDRESS);
    return actionList;
  }

  @override
  dynamic getData() {
    return fetchAlbum;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_ADDRESS:
        addAddress(uikAction);
        break;
      case UIK_ACTION.REMOVE_ADDRESS:
        removeAddress(uikAction);
        break;
      case UIK_ACTION.DELETE_ADDRESS:
        deleteAddress(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onAddressBookTapAction;
  }

  @override
  getPageContext() {
    return UikAddressBook;
  }
}

void deleteAddress(UikAction uikAction) {
  uiUtils.showToast("DELETE ADDRESS");
}

void removeAddress(UikAction uikAction) {
  uiUtils.showToast("REMOVE ADDRESS");
}

void addAddress(UikAction uikAction) {
  uiUtils.showToast("ADD ADDRESS");
}

Future<ApiResponse> fetchAlbum(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo4695667.mockable.io/addressbook'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

//////// Q: what to do about these functions

// void addToCart(UikAction uikAction) async {
//   var skuId = uikAction.tap.data.skuId;

//   //api call to update cart
//   final response =
//       await http.post(Uri.parse('${baseUrl}/cart/update'), headers: {
//     "ngrok-skip-browser-warning": "value",
//   }, body: {
//     "skuId": skuId,
//     "cartId": "",
//     "action": "add"
//   });

//   //displaying response from update cart
//   print("statusCode ${response.body}");
// }

// void openCategory(UikAction uikAction) {
//   //Navigation to the next screen through deepLink Handler
//   var context = NavigationService.navigatorKey.currentContext;
//   DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
// }
