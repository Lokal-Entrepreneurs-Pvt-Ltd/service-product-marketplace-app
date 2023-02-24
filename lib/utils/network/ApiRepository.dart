import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_client.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
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
    return HttpScreenClient.getApiResponse(ApiRoutes.homeScreen, args);
  }

  static Future<ApiResponse> getCatalogue(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.catalogueScreen, args);
  }

  static Future<ApiResponse> getProductScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.productScreen, args);
  }

  static Future<ApiResponse> updateCart(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateCart, args);
  }

  static Future<ApiResponse> getCartScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.cartScreen, args);
  }

  static Future<ApiResponse> getAddressScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressScreen, args);
  }

  static Future<ApiResponse> getCouponScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.couponScreen, args);
  }

  static Future<ApiResponse> getSearchScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.searchScreen, args);
  }


  static Future<ApiResponse> getOrderScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.orderScreen, args);
  }

  // static Future<ApiResponse> getEmptyCartScreen(args) {
  //   return StandardScreenClient(getDio(),
  //           baseUrl: "http://demo2913052.mockable.io/")
  //       .getEmptyCartScreen(args);
  // }

  static Future<ApiResponse> getOrderHistoryScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.orderHistoryScreen, args);
  }

  static Future<ApiResponse> getMyAccountScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.myAccountScreen, args);
  }

  static Future<ApiResponse> getAddressBookScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressBook, args);
  }

  static Future<ApiResponse> getInviteScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.inviteScreen, args);
  }

  static Future<ApiResponse> getServiceScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.serviceScreen, args);
  }

  static Future<ApiResponse> getEarningScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.earningScreen, args);
  }

  static Future<ApiResponse> getLoginScreen( args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.loginScreen, args);
  }

  static Future<ApiResponse> getSignUpScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.signUpScreen, args);
  }

  static Future<ApiResponse> updateCustomerInfo(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateCustomerInfo, args);
  }

  static Future<ApiResponse> sendOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.sendOtp, args);
  }

  static Future<ApiResponse> verifyOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyOtp, args);
  }

  static Future<ApiResponse> addressNext(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressNext, args);
  }

  static Future<ApiResponse> paymentNext(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.paymentNext, args);
  }
}

// apirequestbody class 
// make get login request body function