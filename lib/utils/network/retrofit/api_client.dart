import 'package:lokal/constants.dart';
import 'package:lokal/utils/network/retrofit/apis.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../storage/user_data_handler.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StandardScreenClient {

  factory StandardScreenClient(Dio dio, {String baseUrl}) =
      _StandardScreenClient;

  @GET("/")
  Future<ApiResponse> getResponse();

  @GET(Apis.homescreen)
  Future<ApiResponse> getHomeScreen();

  @GET(Apis.catalog)
  Future<ApiResponse> getCatlogue();
  
  @GET(Apis.productscreen)
  Future<ApiResponse> getProductScreen();
  
  @GET(Apis.search)
  Future<ApiResponse> getSearchScreen();
  
  @GET(Apis.paymentdetailsscreen)
  Future<ApiResponse> getPaymentDetailsScreen();
}
