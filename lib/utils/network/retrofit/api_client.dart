import 'package:lokal/constants.dart';
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

  @POST(MyRoutes.homeScreen)
  Future<ApiResponse> getHomeScreen();

  @POST(MyRoutes.catalogueScreen)
  Future<ApiResponse> getCatlogue();

  @POST(MyRoutes.productScreen)
  Future<ApiResponse> getProductScreen();

  @POST(MyRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen();

  @POST(MyRoutes.paymentdetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen();

  @POST(MyRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen();

  @POST(MyRoutes.cartScreen)
  Future<ApiResponse> getCartScreen();

  @POST(MyRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen();

  @GET(MyRoutes.myAccountScreen)
  Future<ApiResponse> getMyAccountScreen();
}
