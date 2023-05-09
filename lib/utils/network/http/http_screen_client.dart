import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/configs/environment.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/network_utils.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants/environment.dart';
import '../../../constants/json_constants.dart';
import '../../../pages/UikBottomNavigationBar.dart';
import '../../../screens/Onboarding/OnboardingScreen.dart';
import '../../storage/user_data_handler.dart';

class HttpScreenClient {
  static ChuckerHttpClient getHttp() {
    return ChuckerHttpClient(http.Client());
  }

  static displayUserUnAuthorisedDialog() {
    return showDialog(
      barrierDismissible: false,
      context: NavigationUtils.getCurrentContext()!,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              title: Text(YOU_HAVE_BEEN_LOGGED_OUT),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.amberAccent,
                  textColor: Colors.black,
                  child: const Text(LOG_IN),
                  onPressed: () {
                    UserDataHandler.clearUserToken();
                    Navigator.pushAndRemoveUntil(
                      NavigationUtils.getCurrentContext()!,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreen(),
                      ),
                      // ModalRoute.withName(ScreenRoutes.homeScreen)
                      (route) => false,
                    );
                  },
                ),
              ],
            ));
      },
    );
  }

  static displayDialogBox(String text) {
    return showDialog(
      barrierDismissible: false,
      context: NavigationUtils.getCurrentContext()!,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              title: Text(text),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.amberAccent,
                  textColor: Colors.black,
                  child: const Text(CONTINUE),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UikBottomNavigationBar(),
                      ),
                    );
                  },
                ),
              ],
            ));
      },
    );
  }

  static Future<ApiResponse> getApiResponse(String pageRoute, args) async {
    var bodyParams = (args != null) ? args : <String, dynamic>{};
    var header = NetworkUtils.getRequestHeaders();
    try {
      final response = await getHttp()
          .post(
            Uri.parse(Environment().config.BASE_URL + pageRoute),
            headers: header,
            body: jsonEncode(bodyParams),
          )
          .timeout(Duration(seconds: NetworkUtils.REQUEST_TIMEOUT));

      if (response.statusCode == NetworkUtils.HTTP_SUCCESS) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(response.body));
        if (apiResponse.isSuccess!)
          return apiResponse;
        else {
          String errorCode = apiResponse.error![CODE].toString();
          if (errorCode.isNotEmpty) {
            switch (errorCode) {
              case NetworkUtils.NETWORK_ERROR_USER_NOT_AUTHENTICATED:
                {
                  displayUserUnAuthorisedDialog();
                  throw Exception('Failed to load ' + pageRoute);
                }
                break;
              default:
                {
                  UiUtils.showToast(apiResponse.error![MESSAGE]);
                  throw Exception('Failed to load ' + pageRoute);
                }
            }
          } else
            throw Exception('Failed to load ' + pageRoute);
        }
      } else {
        throw Exception('Failed to load ' + pageRoute);
      }
    } on TimeoutException catch (_) {
      throw Exception('Timeout Error to load ' + pageRoute);
    } on SocketException catch (_) {
      throw Exception('Socket Error to load ' + pageRoute);
    }
  }
}
