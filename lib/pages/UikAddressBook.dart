
import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants/json_constants.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/NavigationUtils.dart';

class UikAddressBook extends StandardPage {

  Map<String, dynamic>? args;

  UikAddressBook({this.args});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = {};
    actionList.add(UIK_ACTION.OPEN_PAYMENT);
    actionList.add(UIK_ACTION.ADD_ADDRESS);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getAddressScreen;
  }

  void onAddressBookTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_ADDRESS:
        addAddress(uikAction);
        break;
      case UIK_ACTION.OPEN_PAYMENT:
        openPayment(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
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
    return ScreenRoutes.addressBookScreen;
  }

  @override
  getConstructorArgs() {
   return args;
  }
}

void deleteAddress(UikAction uikAction) {
  UiUtils.showToast("DELETE ADDRESS");
}

void removeAddress(UikAction uikAction) {
  UiUtils.showToast("REMOVE ADDRESS");
}

void
addAddress(UikAction uikAction) {
  NavigationUtils.openScreen(ScreenRoutes.addAddressScreen,{});
}

Future<void> openPayment(UikAction uikAction) async {

  if (uikAction.tap.data.key == TAP_ACTION_TYPE_KEY_ADDRESS_ID) {
    Map<String, dynamic>? args = {
      ADDRESS_ID: uikAction.tap.data.value,
      CART_ID: CartDataHandler.getCartId()
    };
    NavigationUtils.openScreen(ScreenRoutes.paymentDetailsScreen,args);
  }
}
