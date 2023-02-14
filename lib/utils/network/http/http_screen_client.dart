import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants.dart';

class HttpScreenClient {
  static Future<ApiResponse> getHomeScreen(args) async {
    // String url = apiBaseUrl ?? baseUrl;

    print("World");

    final response = await http.get(
      // Uri.parse('$url/discovery/get'),
      Uri.parse('http://demo2913052.mockable.io/home'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      // body: args,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getCatalogueScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/products/get'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getProductScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/products/getProductDetails'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> updateCart(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/cart/update'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getCartScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/cart/get'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getAddressScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/checkout/initiate'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getCouponScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/couponscreen'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getSearchScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/discovery/search'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getPaymentDetailsScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/paymentdetailsscreen'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getOrderScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/orderscreen'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getEmptyCartScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/emptycartscreen'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getOrderHistoryScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/orderhistoryscreen'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getMyAccountScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/myAccount'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getAddressBookScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/checkout/initiate'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getInviteScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/invite'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getServiceScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/service'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getEarningScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/earning'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getLoginScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/customer/login'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> getSignUpScreen(
      [String? apiBaseUrl, Map<String, dynamic>? args]) async {
    String url = apiBaseUrl ?? baseUrl;

    final response = await http.post(
      Uri.parse('$url/customer/signup'),
      headers: {
        "ngrok-skip-browser-warning": "value",
      },
      body: args,
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}