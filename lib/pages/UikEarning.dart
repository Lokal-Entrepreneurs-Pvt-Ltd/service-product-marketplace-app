import 'dart:convert';
// import 'dart:js';

// import 'package:lokal/Widgets/UikSnackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:lokal/actions.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';

import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';

class UikEarningScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_WITHDRAW);
    actionList.add(UIK_ACTION.OPEN_LEADS);
    actionList.add(UIK_ACTION.OPEN_HISTORY);
    return actionList;
  }

  @override
  dynamic getData() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    // return getMockedApiResponse;
    return ApiRepository.getEarningScreen;
  }

  void onEarningScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_WITHDRAW:
        openWithdraw(uikAction);
        break;
      case UIK_ACTION.OPEN_LEADS:
        openLeads(uikAction);
        break;
      case UIK_ACTION.OPEN_HISTORY:
        openHistory(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onEarningScreenTapAction;
  }

  @override
  getPageContext() {
    return UikEarningScreen;
  }
}

void openHistory(UikAction uikAction) {
  UiUtils.showToast("History");
}

void openLeads(UikAction uikAction) {
  UiUtils.showToast("Leads");
}

void openWithdraw(UikAction uikAction) {
  UiUtils.showToast("Withdraw");
}

Future<ApiResponse> getMockedApiResponse(args) async {
  print("lavesh ${args}");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/earning'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
