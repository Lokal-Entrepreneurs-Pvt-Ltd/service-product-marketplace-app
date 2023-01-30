import 'package:flutter/material.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';

import '../actions.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../utils/network/retrofit/api_routes.dart';

class UikAddressBook extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();

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
  UiUtils.showToast("DELETE ADDRESS");
}

void removeAddress(UikAction uikAction) {
  UiUtils.showToast("REMOVE ADDRESS");
}

void addAddress(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;

  Navigator.pushNamed(context!, ApiRoutes.addAddressScreen);
}

void openPayment(UikAction uikAction) {
  var context = NavigationService.navigatorKey.currentContext;

  Navigator.pushNamed(context!, ApiRoutes.paymentDetailsScreen);
}

