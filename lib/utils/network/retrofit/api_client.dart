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

  @GET("/")
  Future<ApiResponse> getResponse();

  @GET(MyApiRoutes.homeScreen)
  Future<ApiResponse> getHomeScreen(args);

  @GET(MyApiRoutes.catalogueScreen)
  Future<ApiResponse> getCatlogue(args);

  @GET(MyApiRoutes.productScreen)
  Future<ApiResponse> getProductScreen(args);

  @GET(MyApiRoutes.couponScreen)
  Future<ApiResponse> getCouponScreen(args);

  @GET(MyApiRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen(args);

  @GET(MyApiRoutes.paymentdetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen(args);

  @GET(MyApiRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen(args);

  @GET(MyApiRoutes.cartScreen)
  Future<ApiResponse> getCartScreen(args);

  @GET(MyApiRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen(args);

  @GET(MyApiRoutes.myAccountScreen)
  Future<ApiResponse> getMyAccountScreen(args);

  @GET(MyApiRoutes.orderHistoryScreen)
  Future<ApiResponse> getOrderHistoryScreen(args);

  @GET(MyApiRoutes.addressBookScreen)
  Future<ApiResponse> getAddressBookScreen(args);

  @POST(MyApiRoutes.loginScreen)
  Future<ApiResponse> getLoginScreen(args);

  @POST(MyApiRoutes.signUpScreen)
  Future<ApiResponse> getSignUpScreen(args);
}
