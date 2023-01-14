import 'package:lokal/constants.dart';
import 'package:lokal/routes.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../storage/user_data_handler.dart';
import 'api_routes.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class StandardScreenClient {
  factory StandardScreenClient(Dio dio, {String baseUrl}) =
      _StandardScreenClient;

  @POST("/")
  Future<ApiResponse> getResponse();

  @POST(MyApiRoutes.homeScreen)
  Future<ApiResponse> getHomeScreen(args);

  @POST(MyApiRoutes.catalogueScreen)
  Future<ApiResponse> getCatlogue(args);

  @POST(MyApiRoutes.productScreen)
  Future<ApiResponse> getProductScreen();

  @POST(MyApiRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen();

  @POST(MyApiRoutes.paymentdetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen();

  @POST(MyApiRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen();

  @POST(MyApiRoutes.cartScreen)
  Future<ApiResponse> getCartScreen();

  @POST(MyApiRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen();
}
