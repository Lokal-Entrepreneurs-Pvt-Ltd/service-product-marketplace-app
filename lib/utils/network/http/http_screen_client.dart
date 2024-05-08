import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lokal/utils/Logs/eventqueue.dart';
import 'package:lokal/utils/Logs/event.dart';
import 'package:lokal/utils/Logs/event_handler.dart';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/configs/environment.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/network_utils.dart';

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants/json_constants.dart';
import '../../../pages/UikBottomNavigationBar.dart';
import '../../../screen_routes.dart';
import '../../../screens/Onboarding/OnboardingScreen.dart';
import '../../storage/user_data_handler.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../retrofit/api_routes.dart';

class HttpScreenClient {
  // static HttpClient getHttp() {
  //   return http.Client();
  //  // return ChuckerHttpClient(http.Client());
  // }

  static http.Client getHttp() {
    if (kDebugMode) {
      // Only enable Chucker in debug mode
      return ChuckerHttpClient(
        http.Client(),
        // Optional: You can configure Chucker as needed.
        // For example, you can set maxSavedLength to limit the size of saved request/response bodies.
        // maxSavedLength: 8192, // You can adjust this value as needed.
      );
    } else {
      // Use a regular http.Client in release mode
      return http.Client();
    }
  }

  static displayUserUnAuthorisedDialog() {
    TextOverlay.show(
        text: YOU_HAVE_BEEN_LOGGED_OUT,
        buttonText: LOG_IN,
        onPressed: () {
          UserDataHandler.clearUserToken();
          NavigationUtils.popAllAndPush(ScreenRoutes.onboardingScreen);
        });
  }

  static displayPhoneNumberNotInSignUpDialog(String pageRoute) {
    TextOverlay.show(
        text: "Kindly add PhoneNo to your account for smooth login process",
        buttonText: ADD_PHONENUMBER_IN_ACCOUNT,
        onPressed: () {
          UserDataHandler.clearUserToken();
          if (pageRoute == ApiRoutes.sendOtpForLoginCustomer) {
            NavigationUtils.openScreen(ScreenRoutes.customerSignUpScreen, {});
          } else {
            NavigationUtils.openScreen(ScreenRoutes.signUpScreen, {});
          }
        });
  }

  static displayDialogBox(String text) {
    TextOverlay.show(
        text: text,
        buttonText: CONTINUE,
        onPressed: () {
          UserDataHandler.clearUserToken();
          Navigator.pushAndRemoveUntil(
            NavigationUtils.getCurrentContext()!,
            MaterialPageRoute(
              builder: (context) => const UikBottomNavigationBar(),
            ),
            // ModalRoute.withName(ScreenRoutes.homeScreen)
            (route) => false,
          );
        });
  }

  static Future<ApiResponse> getmultipartrequest(
      String pageRoute, Map<String, dynamic> args) async {
    try {
      // bool hasConnection = await InternetConnectionChecker().hasConnection;
      // if (!hasConnection) {
      //   displayNoInternetDialog(null);
      //   throw Exception('No internet connection');
      // }
      var header = NetworkUtils.getRequestHeaders();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Environment().config.BASE_URL + pageRoute),
      )..headers.addAll(header);
      var bodyParams = args ?? <String, dynamic>{};
      if (bodyParams.containsKey(FILE)) {
        var file = bodyParams[FILE];
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(FILE, fileStream, length,
            filename: file.path.split("/").last);
        request.files.add(multipartFile);
        bodyParams.remove(FILE);
      }
      request.fields.addAll({USE_CASE: bodyParams[USE_CASE]});
      var response = await request.send();
      if (response.statusCode == NetworkUtils.HTTP_SUCCESS) {
        var responseBody = await response.stream.bytesToString();
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(responseBody));
        if (apiResponse.isSuccess!) {
          return apiResponse;
        } else {
          String errorCode = apiResponse.error![CODE].toString();
          if (errorCode.isNotEmpty) {
            switch (errorCode) {
              case NetworkUtils.NETWORK_ERROR_USER_NOT_AUTHENTICATED:
                {
                  if (pageRoute != ApiRoutes.notificationAddUser)
                    displayUserUnAuthorisedDialog();
                  throw Exception('User not authenticated');
                }
              case NetworkUtils.PHONE_NUMBER_NOT_IN_SIGNUP:
                {
                  if (pageRoute != ApiRoutes.notificationAddUser)
                    displayPhoneNumberNotInSignUpDialog(pageRoute);

                  throw Exception('User not in SingnUp');
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
      debugPrint('API request failed: $e$stackTrace');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getIfscCode(String ifsc) async {
    try {
      final response = await getHttp()
          .get(
            Uri.parse("https://ifsc.razorpay.com/$ifsc"),
          )
          .timeout(Duration(seconds: NetworkUtils.REQUEST_TIMEOUT));

      if (response.statusCode == NetworkUtils.HTTP_SUCCESS) {
        // Parse the response body to a Map<String, dynamic>
        final responseBody = json.decode(response.body);
        return responseBody;
      } else {
        // Handle HTTP error response
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or timeouts
      print('Error: $e');
      return null;
    }
  }

  static Future<ApiResponse> getApiResponse(String pageRoute, args) async {
    try {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      String routes = pageRoute.replaceAll('/', '_');
      Event event =
          Event.build(name: "Api_Called_$routes", apiEndPoint: pageRoute);
      if (!hasConnection) {
        displayNoInternetDialog(null);
        throw Exception('No internet connection');
      }

      // EventQueue eventQueue = EventQueue();
      // eventQueue.add(event);
      // print("${eventQueue.queue.length}-----------------------");

      var bodyParams = args ?? <String, dynamic>{};
      var header = NetworkUtils.getRequestHeaders();
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
        if (apiResponse.isSuccess!) {
          event.updateParameters(apiError: "No Error");
          event.fire();
          return apiResponse;
        } else {
          String errorCode = apiResponse.error![CODE].toString();
          if (errorCode.isNotEmpty) {
            switch (errorCode) {
              case NetworkUtils.NETWORK_ERROR_USER_NOT_AUTHENTICATED:
                {
                  if (pageRoute != ApiRoutes.notificationAddUser)
                    displayUserUnAuthorisedDialog();
                  throw Exception('User not authenticated');
                }
              case NetworkUtils.PHONE_NUMBER_NOT_IN_SIGNUP:
                {
                  if (pageRoute != ApiRoutes.notificationAddUser)
                    displayPhoneNumberNotInSignUpDialog(pageRoute);

                  throw Exception('User not in SingnUp');
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
      debugPrint('API request failed: $e$stackTrace');
      rethrow;
    }
  }

  static Future<String?> fetchContentType(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.headers['content-type'];
      }
    } catch (e) {
      print('Error fetching content type: $e');
    }
    return null;
  }

  static displayNoInternetDialog(Function? retryCallback) {
    TextOverlay.show(
        text: "No Internet Connecton !",
        buttonText: "Close App",
        onPressed: () {
          SystemNavigator.pop();
        });
  }
}
