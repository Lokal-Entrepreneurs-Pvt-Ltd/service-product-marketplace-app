import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lokal/utils/network/network_utils.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants.dart';
import '../../../constants/environment.dart';

class HttpScreenClient {
  static Future<ApiResponse> getHomeScreen(args) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.homeScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load homescreen');
    }
  }

  static Future<ApiResponse> getMyAccountScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.myAccountScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load my account');
    }
  }

  static Future<ApiResponse> getCatalogueScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.catalogueScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load catalog screen');
    }
  }

  static Future<ApiResponse> getProductScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.productScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product screen');
    }
  }

  static Future<ApiResponse> updateCart(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.updateCart),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load update cart screen');
    }
  }

  static Future<ApiResponse> getCartScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.cartScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load cart screen');
    }
  }

  static Future<ApiResponse> getAddressScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.addressScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load address screen');
    }
  }

  static Future<ApiResponse> getCouponScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.couponScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load coupon screen');
    }
  }

  static Future<ApiResponse> getSearchScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.searchScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search screen');
    }
  }

  static Future<ApiResponse> getPaymentDetailsScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.paymentDetailsScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load payment details screen');
    }
  }

  static Future<ApiResponse> getOrderScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.orderScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load order screen');
    }
  }

  static Future<ApiResponse> getEmptyCartScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.emptyCartScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load empty cart screen');
    }
  }

  static Future<ApiResponse> getOrderHistoryScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.orderHistoryScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load order history screen');
    }
  }

  static Future<ApiResponse> getAddressBookScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.addressBook),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load address book screen');
    }
  }

  static Future<ApiResponse> getInviteScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.inviteScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load invite screen');
    }
  }

  static Future<ApiResponse> getServiceScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.serviceScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load service screen');
    }
  }

  static Future<ApiResponse> getEarningScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.earningScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load earning screen');
    }
  }

  static Future<ApiResponse> getLoginScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.loginScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load login screen');
    }
  }

  static Future<ApiResponse> getSignUpScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.signUpScreen),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load signup screen');
    }
  }

  static Future<ApiResponse> updateCustomerInfo(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.updateCustomerInfo),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load update customer info screen');
    }
  }

  static Future<ApiResponse> sendOtp(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.sendOtp),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load send OTP screen');
    }
  }

  static Future<ApiResponse> verifyOtp(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.verifyOtp),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load verify OTP screen');
    }
  }

  static Future<ApiResponse> addressNext(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.addressNext),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load address next screen');
    }
  }

  static Future<ApiResponse> paymentNext(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ApiRoutes.paymentNext),
      headers: {...NetworkUtils.getRequestHeaders()},
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load payment next screen');
    }
  }
}
