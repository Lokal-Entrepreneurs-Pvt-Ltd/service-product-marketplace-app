import 'package:login/constants.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'StandardScreenClient.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StandardScreenClient {
  factory StandardScreenClient(Dio dio, {String baseUrl}) =
      _StandardScreenClient;

  @GET("/")
  Future<ApiResponse> getResponse();

  @GET("/MainPageOne")
  Future<ApiResponse> getMainPageOne();

  @GET("/MainPageTwo")
  Future<ApiResponse> getMainPageTwo();

  @GET("/newHomeScreen")
  Future<ApiResponse> getHomeScreen();

  @GET("/CatalogScreen")
  Future<ApiResponse> getCatalogSreen();

  @GET("/SearchCategory")
  Future<ApiResponse> getSearchCatalogScreen();
}
