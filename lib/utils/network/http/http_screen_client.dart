import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/configs/environment.dart';
import 'package:lokal/utils/network/network_utils.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';

import 'package:ui_sdk/props/ApiResponse.dart';

import '../../../constants/environment.dart';

class
HttpScreenClient {
  static ChuckerHttpClient getHttp() {
    return ChuckerHttpClient(http.Client());
  }

  static Future<ApiResponse> getApiResponse(String pageRoute, args) async {
    var bodyParams = (args != null) ? args : <String, dynamic>{};
    var header = NetworkUtils.getRequestHeaders();
    try {
      final response = await getHttp().post(
        Uri.parse(Environment().config.BASE_URL + pageRoute),
        headers: header,
        body: jsonEncode(bodyParams),
      ).timeout(Duration(seconds: NetworkUtils.REQUEST_TIMEOUT));
      if (response.statusCode == NetworkUtils.HTTP_SUCCESS) {
        return ApiResponse.fromJson(jsonDecode(response.body));
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
