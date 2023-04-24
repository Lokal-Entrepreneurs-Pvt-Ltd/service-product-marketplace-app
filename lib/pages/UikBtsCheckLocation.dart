import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:ui_sdk/NavigatorService.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../constants/json_constants.dart';
import '../main.dart';
import '../screen_routes.dart';
import '../screens/bts/ConfirmTowers.dart';
import '../utils/NavigationUtils.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/network/ApiRepository.dart';
import '../utils/network/ApiRequestBody.dart';

class UikBtsCheckLocationScreen extends StandardPage {
  final dynamic args;
  final int userId;
  String towerId = "";

  UikBtsCheckLocationScreen({required this.args, required this.userId});

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.SELECT_TOWER);
    actionList.add(UIK_ACTION.CONFIRM_TOWER);
    actionList.add(UIK_ACTION.BACK_PRESSED);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getNearestTowers;
    // return getMockedApiResponse;
  }

  void onBtsCheckLocationScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.SELECT_TOWER:
        onSelectTower(uikAction);
        break;
      case UIK_ACTION.CONFIRM_TOWER:
        onSubmitTower(uikAction);
        break;
      case UIK_ACTION.BACK_PRESSED:
        NavigationUtils.pop();
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onBtsCheckLocationScreenTapAction;
  }

  @override
  getPageContext() {
    return UikBtsCheckLocationScreen;
  }

  void onSelectTower(UikAction uikAction) async {
    var key = uikAction.tap.data.key;
    var towerId = uikAction.tap.data.value;
    if (towerId != null) {
      this.towerId = towerId;
    }
  }

  void onSubmitTower(UikAction uikAction) async {
    if (towerId.isEmpty) {
      UiUtils.showToast("Select Tower");
      return;
    }
    final BuildContext context = NavigationService.navigatorKey.currentContext!;
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Color(0xfffee440),
        ));
      },
    );
    final response = await ApiRepository.confirmTower(
        ApiRequestBody.confirmTowerRequest(userId, this.towerId));

    Navigator.of(context).pop();
    if (response.isSuccess == true) {
      print("The Tower is Confirmed");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmTowers(),
        ),
        // arguments: args,
      );
    } else {
      print("Not Confirmed");
      UiUtils.showToast(response.error![MESSAGE]);
    }
  }

  @override
  getConstructorArgs() {
    // TODO: implement getConstructorArgs
    return args;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  final response = await http.get(
    Uri.parse('https://demo2235403.mockable.io/checkFeasibility'),
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
