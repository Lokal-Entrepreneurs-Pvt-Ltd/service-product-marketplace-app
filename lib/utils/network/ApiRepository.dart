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
    return StandardScreenClient(getDio()).getHomeScreen(args);
  }

  static Future<ApiResponse> getCatalogue(args) {
    return StandardScreenClient(getDio()).getCatlogue(args);
  }

  static Future<ApiResponse> getProductScreen() {
    return StandardScreenClient(getDio()).getProductScreen();
  }

  static Future<ApiResponse> getSearchScreen() {
    return StandardScreenClient(getDio()).getSearchScreen();
  }

  static Future<ApiResponse> getPaymentDetailsScreen() {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo8023603.mockable.io/")
        .getPaymentDetailsScreen();
  }

  static Future<ApiResponse> getOrderScreen() {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo8971456.mockable.io/")
        .getOrderScreen();
  }

  static Future<ApiResponse> getCartScreen() {
    return StandardScreenClient(getDio(),
            baseUrl: "https://demo9790512.mockable.io/")
        .getCartScreen();
  }

  static Future<ApiResponse> getEmptyCartScreen() {
    return StandardScreenClient(getDio(),
            baseUrl: "http://demo2913052.mockable.io/")
        .getEmptyCartScreen();
  }
}
