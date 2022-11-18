import 'package:ui_sdk/props/ResponseAlternate.dart';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: "https://demo3348922.mockable.io/")
abstract class StandardScreenClient {
  factory StandardScreenClient(Dio dio, {String baseUrl}) = _StandardScreenClient;

  @GET("/test123")
  Future<StandardScreenResponse> getResponse();
}

/* @JsonSerializable()
class ApiResponse {
  const ApiResponse({
    this.isSuccess,
    this.data,
    this.error,
  });

  final bool? isSuccess;
  final StandardScreenResponse? data;
  final Map<String, dynamic>? error;

  /* factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final isSuccess = json["isSuccess"] as bool;
    final data = StandardScreenResponse.fromJson(json["data"]);
    final error = json["error"] as Map<String, dynamic>;

    return ApiResponse(isSuccess: isSuccess, data: data, error: error);
  } */

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
 */