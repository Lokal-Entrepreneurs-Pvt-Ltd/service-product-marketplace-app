import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/configs/environment.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/network_utils.dart';

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants/json_constants.dart';
import '../../../pages/UikBottomNavigationBar.dart';
import '../../../screens/Onboarding/OnboardingScreen.dart';
import '../../storage/user_data_handler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class HttpScreenClient {
  // static HttpClient getHttp() {
  //   return http.Client();
  //  // return ChuckerHttpClient(http.Client());
  // }

  static displayUserUnAuthorisedDialog() {
    return showDialog(
      barrierDismissible: false,
      context: NavigationUtils.getCurrentContext()!,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              title: const Text(YOU_HAVE_BEEN_LOGGED_OUT),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.amberAccent,
                  textColor: Colors.black,
                  child: const Text(LOG_IN),
                  onPressed: () {
                    UserDataHandler.clearUserToken();
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      NavigationUtils.getCurrentContext()!,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
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
                    Navigator.pushAndRemoveUntil(
                      NavigationUtils.getCurrentContext()!,
                      MaterialPageRoute(
                        builder: (context) => const UikBottomNavigationBar(),
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

  static Future<ApiResponse> getApiResponse(String pageRoute, args) async {
    try {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        displayNoInternetDialog(null);
        throw Exception('No internet connection');
      }

      var bodyParams = args ?? <String, dynamic>{};
      var header = NetworkUtils.getRequestHeaders();
      final response = await http.Client()
          .post(
        Uri.parse(Environment().config.BASE_URL + pageRoute),
        headers: header,
        body: jsonEncode(bodyParams),
      )
          .timeout(Duration(seconds: NetworkUtils.REQUEST_TIMEOUT));

      if (response.statusCode == NetworkUtils.HTTP_SUCCESS) {
        ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
        if (apiResponse.isSuccess!) {
          return apiResponse;
        } else {
          String errorCode = apiResponse.error![CODE].toString();
          if (errorCode.isNotEmpty) {
            switch (errorCode) {
              case NetworkUtils.NETWORK_ERROR_USER_NOT_AUTHENTICATED:
                {
                  displayUserUnAuthorisedDialog();
                  throw Exception('User not authenticated');
                }
              default:
                {
                  UiUtils.showToast(apiResponse.error![MESSAGE]);
                  throw Exception('API response error');
                }
            }
          } else {
            throw Exception('API response error');
          }
        }
      } else {
        throw Exception('API request failed');
      }
    } on TimeoutException catch (_) {
      throw Exception('Timeout Error');
    } on SocketException catch (_) {
      throw Exception('Socket Error');
    } catch (e, stackTrace) {
      // Log the error for debugging and monitoring
      debugPrint('API request failed: $e'+ stackTrace.toString());
      throw e;
     }
  }


  static displayNoInternetDialog(Function? retryCallback) {
    return showDialog(
      barrierDismissible: false,
      context: NavigationUtils.getCurrentContext()!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: const Text("No Internet Connecton !"),
            actions: <Widget>[
              MaterialButton(
                color: Colors.amberAccent,
                textColor: Colors.black,
                child: const Text("Close App"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  SystemNavigator.pop();
                 // retryCallback(); // Call the retry callback
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
