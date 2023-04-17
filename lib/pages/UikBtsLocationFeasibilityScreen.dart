import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikStateList.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/Renderer.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../actions.dart';
import 'package:http/http.dart' as http;

import '../constants/json_constants.dart';
import '../main.dart';
import '../utils/UiUtils/UiUtils.dart';
import '../utils/network/ApiRequestBody.dart';
import 'UikBlockList.dart';
import 'UikBtsCheckLocation.dart';
import 'UikDistrictList.dart';

class UikBtsLocationFeasibilityScreen extends StandardPage {
  int? stateCode = -1;
  int? districtCode = -1;
  int? blockCode = -1;
  String customerName = "";
  String email = "";
  String phoneNo = "";
  String stateName = "";
  String districtName = "";
  String blockName = "";
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.ON_TEXT_EDIT_COMPLETE);
    actionList.add(UIK_ACTION.SELECT_STATE);
    actionList.add(UIK_ACTION.SELECT_DISTRICT);
    actionList.add(UIK_ACTION.SELECT_BLOCK);
    actionList.add(UIK_ACTION.FETCH_LOCATION);
    actionList.add(UIK_ACTION.SUBMIT_FORM);
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.btsLocationFeasibility;
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
      case UIK_ACTION.FETCH_LOCATION:
        fetchLocation(uikAction);
        break;
      case UIK_ACTION.SUBMIT_FORM:
        submitForm(uikAction);
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

  @override
  getConstructorArgs() {
    return {};
  }

  void submitForm(UikAction uikAction) async {
    if (customerName.isEmpty) {
      UiUtils.showToast("Enter your name");
      return;
    } else if (email.isEmpty) {
      UiUtils.showToast("Enter your email");
      return;
    } else if (phoneNo.isEmpty) {
      UiUtils.showToast("Enter your phone number");
      return;
    } else if (stateName.isEmpty) {
      UiUtils.showToast("Select your state");
      return;
    } else if (districtName.isEmpty) {
      UiUtils.showToast("Select your district name");
      return;
    } else if (blockName.isEmpty) {
      UiUtils.showToast("Select your block");
      return;
    } else if (latitude == 0.0 || longitude == 0.0) {
      UiUtils.showToast("Fetch your location");
      return;
    }

    final response = await ApiRepository.submitIspForm(
        ApiRequestBody.submitIspFormRequest(
            stateCode,
            districtCode,
            blockCode,
            stateName,
            districtName,
            blockName,
            customerName,
            email,
            phoneNo,
            latitude,
            longitude));

    if (response.isSuccess!) {
      // UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);

      // var customerData = response.data[CUSTOMER_DATA];
      // if(customerData!= null) {
      //   UserDataHandler.saveCustomerData(customerData);
      // }
      final BuildContext context =
          NavigationService.navigatorKey.currentContext!;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => UikBtsCheckLocationScreen().page,
      //   ),
      // );

      print("200 Success");
    } else {
      //todo show login error
      UiUtils.showToast(response.error![MESSAGE]);
    }

    // Map<String, dynamic> args = {
    //   ADDRESS: {
    //     FIRST_NAME: name,
    //     LAST_NAME: "singh",
    //     ADDRESS_LINE_1: houseNumber,
    //     ADDRESS_LINE_2: street,
    //     CITY: city,
    //     STATE: {
    //       "id": 578,
    //     },
    //     POSTCODE: postcode,
    //     TELEPHONE: phone,
    //   },
    // };

    // print(args);

    // final BuildContext context = NavigationService.navigatorKey.currentContext!;
    // Navigator.pushNamed(
    //   context,
    //   ScreenRoutes.paymentDetailsScreen,
    //   arguments: args,
    // );
  }

  void onEditingText(UikAction uikAction) {
    print("................Lavesh................");
    var key = uikAction.tap.data.key;
    var value = uikAction.tap.data.value;

    if (key == "Name") {
      customerName = value!;
    } else if (key == "Email") {
      email = value!;
    } else if (key == "Phone Number") {
      phoneNo = value!;
    }
    print(customerName);
  }

  void selectState(UikAction uikAction) async {
    var context = NavigationService.navigatorKey.currentContext;

    var result = await showModalBottomSheet(
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
    print(
        "............................Shubham Checking..................................");
    print(result.runtimeType);
    UiUtils.showToast("You selected $result");

    stateCode = result[0];
    stateName = result[1];
    print(stateCode);
    print("STATE Name INside selectstate $stateName");
    return;
  }

  void selectDistrict(UikAction uikAction) async {
    print(stateCode);
    print("STATE Name INside selectdistrict $stateName");
    if (stateCode == -1 || stateCode == null) {
      UiUtils.showToast("Kindly select state first !");
      return;
    }

    var context = NavigationService.navigatorKey.currentContext;

    var result = await showModalBottomSheet(
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
        child: UikDistrictList(stateCode: stateCode).page,
      ),
    );

    UiUtils.showToast("You selected $result");

    districtCode = result[0];
    districtName = result[1];
  }

  void selectBlock(UikAction uikAction) async {
    if (stateCode == -1 || stateCode == null) {
      UiUtils.showToast("Kindly select state first !");
      return;
    }

    if (districtCode == -1 || districtCode == null) {
      UiUtils.showToast("Kindly select district first !");
      return;
    }

    var context = NavigationService.navigatorKey.currentContext;

    var result = await showModalBottomSheet(
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
        child: UikBlockList(districtCode: districtCode).page,
      ),
    );

    UiUtils.showToast("You selected $result");

    blockCode = result[0];
    blockName = result[1];
  }

  Future<void> fetchLocation(UikAction uikAction) async {
    print("/////////////////////////Inside fetch location/////////////");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    print(latitude);
    print(longitude);
    latitude = position.latitude;
    longitude = position.longitude;
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
