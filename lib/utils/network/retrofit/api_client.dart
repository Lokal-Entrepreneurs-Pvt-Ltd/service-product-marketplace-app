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
  Future<ApiResponse> getProductScreen(args);

  @POST(MyApiRoutes.updateCart)
  Future<ApiResponse> updateCart(args);

  @POST(MyApiRoutes.cartScreen)
  Future<ApiResponse> getCartScreen(args);

  @POST(MyApiRoutes.couponScreen)
  Future<ApiResponse> getCouponScreen(args);

  @POST(MyApiRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen(args);

  @POST(MyApiRoutes.paymentdetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen(args);

  @POST(MyApiRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen(args);

  @POST(MyApiRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen(args);

  @POST(MyApiRoutes.myAccountScreen)
  Future<ApiResponse> getMyAccountScreen(args);

  @POST(MyApiRoutes.orderHistoryScreen)
  Future<ApiResponse> getOrderHistoryScreen(args);

  @POST(MyApiRoutes.addressBookScreen)
  Future<ApiResponse> getAddressBookScreen(args);

  @POST(MyApiRoutes.loginScreen)
  Future<ApiResponse> getLoginScreen(args);

  @POST(MyApiRoutes.signUpScreen)
  Future<ApiResponse> getSignUpScreen(args);

  @POST(MyApiRoutes.inviteScreen)
  Future<ApiResponse> getInviteScreen(args);

  @POST(MyApiRoutes.earningScreen)
  Future<ApiResponse> getEarningScreen(args);

  @POST(MyApiRoutes.serviceScreen)
  Future<ApiResponse> getServiceScreen(args);
}
