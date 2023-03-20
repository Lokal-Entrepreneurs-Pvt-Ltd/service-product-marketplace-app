import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikStateList.dart';
import 'package:ui_sdk/Renderer.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UikBtsLocationFeasibilityScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    actionList.add(UIK_ACTION.SELECT_STATE);
    actionList.add(UIK_ACTION.SELECT_DISTRICT);
    actionList.add(UIK_ACTION.SELECT_BLOCK);
    return actionList;
  }

  @override
  dynamic getData() {
    // return ApiRepository.btsLocationFeasibility;
    return getMockedApiResponse;
  }

  void onBtsLocationFeasibilityScreenTapAction(UikAction uikAction) {
    print(uikAction.tap.type);
    switch (uikAction.tap.type) {
      case UIK_ACTION.ON_TEXT_EDIT_COMPLETE:
        onEditingText(uikAction);
        break;
      case UIK_ACTION.SELECT_STATE:
        selectState(uikAction);
        break;
      case UIK_ACTION.SELECT_DISTRICT:
        selectDistrict(uikAction);
        break;
      case UIK_ACTION.SELECT_BLOCK:
        selectBlock(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onBtsLocationFeasibilityScreenTapAction;
  }

  @override
  getPageContext() {
    return UikBtsLocationFeasibilityScreen;
  }

  void onEditingText(UikAction uikAction) {}

  void selectState(UikAction uikAction) async {
    print("Inside Select State func");
    var context = NavigationService.navigatorKey.currentContext;

    final result = await showModalBottomSheet(
      context: context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) => Container(
        height: 375.0,
        width: double.infinity,
        // padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: UikStateList().page,
      ),
    );

    print("RESULT VALUE - ");
    print(result);
  }

  void selectDistrict(UikAction uikAction) async {
    print("Inside Select District func");
    var context = NavigationService.navigatorKey.currentContext;

    final result = await showModalBottomSheet(
      context: context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) => Container(
        height: 375.0,
        width: double.infinity,
        // padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: UikStateList().page,
      ),
    );

    print("RESULT VALUE - ");
    print(result);
  }

  void selectBlock(UikAction uikAction) async {
    print("Inside Select Block func");
    var context = NavigationService.navigatorKey.currentContext;

    final result = await showModalBottomSheet(
      context: context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) => Container(
        height: 375.0,
        width: double.infinity,
        // padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: UikStateList().page,
      ),
    );

    print("RESULT VALUE - ");
    print(result);
  }
}

Future<ApiResponse>? getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo2891646.mockable.io/btslocationfeasibility'),
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

Future<ApiResponse>? getMockedApiResponseBottomSheet(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo8009892.mockable.io/statelist'),
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
