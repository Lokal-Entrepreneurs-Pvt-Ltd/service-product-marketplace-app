import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_client.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../storage/user_data_handler.dart';

class ApiRepository {
  static Dio getDio() {
    Dio dio = Dio(BaseOptions(contentType: "application/json"));
    String authToken = "";
    UserDataHandler.getUserToken().then((value) {
      authToken = value;
    });
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken'
    };
    dio.options.headers = headers;
    dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
  }

  static Future<ApiResponse> getHomescreen(args) {
    return StandardScreenClient(getDio())
        .getHomeScreen(args);
  }

  static Future<ApiResponse> getCatalogue(args) {
    return StandardScreenClient(getDio()).getCatlogue(args);
  }

  static Future<ApiResponse> getProductScreen(args) {
    return StandardScreenClient(getDio()).getProductScreen(args);
  }

  static Future<ApiResponse> updateCart(args) {
    return StandardScreenClient(getDio()).updateCart(args);
  }

  static Future<ApiResponse> getCartScreen(args) {
    return StandardScreenClient(getDio()).getCartScreen(args);
  }

  static Future<ApiResponse> getAddressScreen(args) {
    return StandardScreenClient(getDio()).getAddressScreen(args);
  }

  static Future<ApiResponse> getCouponScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo6536398.mockable.io/")
        .getCouponScreen(args);
  }

  static Future<ApiResponse> getSearchScreen(args) {
    return StandardScreenClient(getDio()).getSearchScreen(args);
  }

  static Future<ApiResponse> getPaymentDetailsScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo8023603.mockable.io/")
        .getPaymentDetailsScreen(args);
  }

  static Future<ApiResponse> getOrderScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo8971456.mockable.io/")
        .getOrderScreen(args);
  }

  static Future<ApiResponse> getEmptyCartScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "http://demo2913052.mockable.io/")
        .getEmptyCartScreen(args);
  }

  static Future<ApiResponse> getOrderHistoryScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo9350314.mockable.io/")
        .getOrderHistoryScreen(args);
  }

  static Future<ApiResponse> getMyAccountScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo6536398.mockable.io/")
        .getMyAccountScreen(args);
  }

  static Future<ApiResponse> getAddressBookScreen(args) {
    return StandardScreenClient(getDio(),)
        .getAddressBookScreen(args);
  }

  static Future<ApiResponse> getInviteScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo6536398.mockable.io/")
        .getInviteScreen(args);
  }

  static Future<ApiResponse> getServiceScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo6536398.mockable.io/")
        .getServiceScreen(args);
  }

  static Future<ApiResponse> getEarningScreen(args) {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo6536398.mockable.io/")
        .getEarningScreen(args);
  }

  static Future<ApiResponse> getLoginScreen(args) {
    return StandardScreenClient(getDio()).getLoginScreen(args);
  }

  static Future<ApiResponse> getSignUpScreen(args) {
    return StandardScreenClient(getDio()).getSignUpScreen(args);
  }
}

// apirequestbody class 
// make get login request body function