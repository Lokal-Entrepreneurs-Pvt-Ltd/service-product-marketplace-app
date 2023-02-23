import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_client.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../storage/user_data_handler.dart';
import 'http/http_screen_client.dart';

class ApiRepository {
  static Dio getDio() {
    Dio dio = Dio(BaseOptions(contentType: "application/json"));
    dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
  }

  static Future<ApiResponse> getHomescreen(args) {
    return HttpScreenClient.getHomeScreen(args);
  }

  static Future<ApiResponse> getCatalogue(args) {
    return HttpScreenClient.getCatalogueScreen(args);
  }

  static Future<ApiResponse> getProductScreen(args) {
    return HttpScreenClient.getProductScreen(args);
  }

  static Future<ApiResponse> updateCart(args) {
    return HttpScreenClient.updateCart(args);
  }

  static Future<ApiResponse> getCartScreen(args) {
    return HttpScreenClient.getCartScreen(args);
  }

  static Future<ApiResponse> getAddressScreen(args) {
    return HttpScreenClient.getAddressScreen(args);
  }

  static Future<ApiResponse> getCouponScreen(args) {
    return HttpScreenClient.getCouponScreen(args);
  }

  static Future<ApiResponse> getSearchScreen(args) {
    return HttpScreenClient.getSearchScreen(args);
  }


  static Future<ApiResponse> getOrderScreen(args) {
    return   HttpScreenClient.getOrderScreen(args);
  }

  // static Future<ApiResponse> getEmptyCartScreen(args) {
  //   return StandardScreenClient(getDio(),
  //           baseUrl: "http://demo2913052.mockable.io/")
  //       .getEmptyCartScreen(args);
  // }

  static Future<ApiResponse> getOrderHistoryScreen(args) {
    return HttpScreenClient.getOrderHistoryScreen(args);
  }

  static Future<ApiResponse> getMyAccountScreen(args) {
    return HttpScreenClient.getMyAccountScreen(args);
  }

  static Future<ApiResponse> getAddressBookScreen(args) {
    return StandardScreenClient(
      getDio(),
    ).getAddressBookScreen(args);
  }

  static Future<ApiResponse> getInviteScreen(args) {
    return HttpScreenClient.getInviteScreen(args);
  }

  static Future<ApiResponse> getServiceScreen(args) {
    return HttpScreenClient.getServiceScreen(args);
  }

  static Future<ApiResponse> getEarningScreen(args) {
    return HttpScreenClient.getEarningScreen(args);
  }

  static Future<ApiResponse> getLoginScreen( args) {
    return HttpScreenClient.getLoginScreen(args);
  }

  static Future<ApiResponse> getSignUpScreen(args) {
    return HttpScreenClient.getSignUpScreen(args);
  }

  static Future<ApiResponse> updateCustomerInfo(args) {
    return HttpScreenClient.updateCustomerInfo(args);
  }

  static Future<ApiResponse> sendOtp(args) {
    return HttpScreenClient.sendOtp(args);
  }

  static Future<ApiResponse> verifyOtp(args) {
    return HttpScreenClient.verifyOtp(args);
  }

  static Future<ApiResponse> addressNext(args) {
    return HttpScreenClient.addressNext(args);
  }

  static Future<ApiResponse> paymentNext(args) {
    return HttpScreenClient.paymentNext(args);
  }
}

// apirequestbody class 
// make get login request body function