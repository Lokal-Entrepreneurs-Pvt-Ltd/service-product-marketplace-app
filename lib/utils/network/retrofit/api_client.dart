import 'package:lokal/constants.dart';
import 'package:lokal/screen_routes.dart';
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

  @POST(ApiRoutes.homeScreen)
  Future<ApiResponse> getHomeScreen(args);

  @POST(ApiRoutes.catalogueScreen)
  Future<ApiResponse> getCatlogue(args);

  @POST(ApiRoutes.productScreen)
  Future<ApiResponse> getProductScreen(args);

  @POST(ApiRoutes.updateCart)
  Future<ApiResponse> updateCart(args);

  @POST(ApiRoutes.cartScreen)
  Future<ApiResponse> getCartScreen(args);

  @POST(ApiRoutes.addressScreen)
  Future<ApiResponse> getAddressScreen(args);

  @POST(ApiRoutes.couponScreen)
  Future<ApiResponse> getCouponScreen(args);

  @POST(ApiRoutes.searchScreen)
  Future<ApiResponse> getSearchScreen(args);

  @POST(ApiRoutes.paymentdetailsScreen)
  Future<ApiResponse> getPaymentDetailsScreen(args);

  @POST(ApiRoutes.orderScreen)
  Future<ApiResponse> getOrderScreen(args);

  @POST(ApiRoutes.emptyCartScreen)
  Future<ApiResponse> getEmptyCartScreen(args);

  @POST(ApiRoutes.myAccountScreen)
  Future<ApiResponse> getMyAccountScreen(args);

  @POST(ApiRoutes.orderHistoryScreen)
  Future<ApiResponse> getOrderHistoryScreen(args);

  @POST(ApiRoutes.checkoutInit)
  Future<ApiResponse> getAddressBookScreen(args);

  @POST(ApiRoutes.loginScreen)
  Future<ApiResponse> getLoginScreen(args);

  @POST(ApiRoutes.signUpScreen)
  Future<ApiResponse> getSignUpScreen(args);

  @GET(ApiRoutes.inviteScreen)
  Future<ApiResponse> getInviteScreen(args);

  @GET(ApiRoutes.earningScreen)
  Future<ApiResponse> getEarningScreen(args);

  @GET(ApiRoutes.serviceScreen)
  Future<ApiResponse> getServiceScreen(args);

  @POST(ApiRoutes.updateCustomerInfo)
  Future<ApiResponse> updateCustomerInfo(args);

  @POST(ApiRoutes.sendOtp)
  Future<ApiResponse> sendOtp(args);

  @POST(ApiRoutes.verifyOtp)
  Future<ApiResponse> verifyOtp(args);
}
