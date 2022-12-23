import 'package:lokal/constants/environment.dart';
import 'package:lokal/routes.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../storage/user_data_handler.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StandardScreenClient {
  factory StandardScreenClient(Dio dio, {String baseUrl}) =
      _StandardScreenClient;

  @POST("/")
  Future<ApiResponse> getResponse();

  @GET(MyRoutes.homeScreen)
  Future<ApiResponse> getHomeScreen();

  @GET(MyRoutes.catalogueScreen)
  Future<ApiResponse> getCatlogue();

  @GET(MyRoutes.productScreen)
  Future<ApiResponse> getProductScreen();

  @GET(MyRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen();

  @GET(MyRoutes.paymentDetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen();

  @GET(MyRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen();

  @GET(MyRoutes.cartScreen)
  Future<ApiResponse> getCartScreen();

  @GET(MyRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen();
}
