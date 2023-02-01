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

class UikServiceScreen extends StandardPage {
  // final obj = Snack();
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_INVITE);
    actionList.add(UIK_ACTION.OPEN_STATUS);
    actionList.add(UIK_ACTION.OPEN_COPY);
    actionList.add(UIK_ACTION.OPEN_SHARE);
    return actionList;
  }

  @override
  dynamic getData() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    // return getMockedApiResponse;
    return ApiRepository.getServiceScreen;
  }

  void onServiceScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.OPEN_INVITE:
        openInvite(uikAction);
        break;
      case UIK_ACTION.OPEN_STATUS:
        openStatus(uikAction);
        break;
      case UIK_ACTION.OPEN_COPY:
        openCopy(uikAction);
        break;
      case UIK_ACTION.OPEN_SHARE:
        openShare(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onServiceScreenTapAction;
  }

  @override
  getPageContext() {
    return UikServiceScreen;
  }
}

void openShare(UikAction uikAction) {
  UiUtils.showToast("Share");
}

void openCopy(UikAction uikAction) {
  UiUtils.showToast("Copy");
}

void openStatus(UikAction uikAction) {
  UiUtils.showToast("Status");
}

void openInvite(UikAction uikAction) {
  UiUtils.showToast("Invite");
}

Future<ApiResponse> getMockedApiResponse(args) async {
  print("lavesh ${args}");
  final response = await http.get(
    Uri.parse('https://demo6536398.mockable.io/service'),
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
