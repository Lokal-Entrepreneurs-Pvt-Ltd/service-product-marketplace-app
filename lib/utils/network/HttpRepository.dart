import 'package:ui_sdk/props/ApiResponse.dart';

import 'http/http_screen_client.dart';

class HttpRepository {
  static Future<ApiResponse> getHomeScreen(dynamic args) {
    return HttpScreenClient.getHomeScreen(args);
  }

  static Future<ApiResponse> getCatalogue([dynamic args]) {
    return HttpScreenClient.getCatalogueScreen(args);
  }

  static Future<ApiResponse> getProductScreen([dynamic args]) {
    return HttpScreenClient.getProductScreen(args);
  }

  static Future<ApiResponse> updateCart([dynamic args]) {
    return HttpScreenClient.updateCart(args);
  }

  static Future<ApiResponse> getCartScreen([dynamic args]) {
    return HttpScreenClient.getCartScreen(args);
  }

  static Future<ApiResponse> getAddressScreen([dynamic args]) {
    return HttpScreenClient.getAddressScreen(args);
  }

  static Future<ApiResponse> getCouponScreen([dynamic args]) {
    return HttpScreenClient.getCouponScreen(args);
  }

  static Future<ApiResponse> getSearchScreen([dynamic args]) {
    return HttpScreenClient.getSearchScreen(args);
  }

  static Future<ApiResponse> getPaymentDetailsScreen([dynamic args]) {
    return HttpScreenClient.getPaymentDetailsScreen(args);
  }

  static Future<ApiResponse> getOrderScreen([dynamic args]) {
    return HttpScreenClient.getOrderScreen(args);
  }

  static Future<ApiResponse> getEmptyCartScreen([dynamic args]) {
    return HttpScreenClient.getEmptyCartScreen(args);
  }

  static Future<ApiResponse> getOrderHistoryScreen([dynamic args]) {
    return HttpScreenClient.getOrderHistoryScreen(args);
  }

  static Future<ApiResponse> getMyAccountScreen([dynamic args]) {
    return HttpScreenClient.getMyAccountScreen(args);
  }

  static Future<ApiResponse> getAddressBookScreen([dynamic args]) {
    return HttpScreenClient.getAddressBookScreen(args);
  }

  static Future<ApiResponse> getInviteScreen([dynamic args]) {
    return HttpScreenClient.getInviteScreen(args);
  }

  static Future<ApiResponse> getServiceScreen([dynamic args]) {
    return HttpScreenClient.getServiceScreen(args);
  }

  static Future<ApiResponse> getEarningScreen([dynamic args]) {
    return HttpScreenClient.getEarningScreen(args);
  }

  static Future<ApiResponse> getLoginScreen([dynamic args]) {
    return HttpScreenClient.getLoginScreen(args);
  }

  static Future<ApiResponse> getSignUpScreen([dynamic args]) {
    return HttpScreenClient.getSignUpScreen(args);
  }
}
