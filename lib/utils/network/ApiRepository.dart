// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/product_data_handler.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'http/http_screen_client.dart';

class ApiRepository {
  static Dio getDio() {
    Dio dio = Dio(BaseOptions(contentType: "application/json"));
    // dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
  }

  static Future<ApiResponse> getUserByLokalID(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getUserByLokalId, args);
  }

  static Future<ApiResponse> getStateList(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.stateList, args);
  }

  static Future<ApiResponse> getDistrictByStateCode(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.districtListByState, args);
  }

  static Future<ApiResponse> getJobsbyId(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.jobsDetailsById, args);
  }

  static Future<ApiResponse> getSamhitaHomescreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.samhitaHome, args);
  }

  static Future<ApiResponse> getQuestionsByServiceId(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getQuestionsByServiceId, args);
  }

  static Future<ApiResponse> submitSamhitaAddParticipantForm(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.submitSamhitaAddParticipantsForm, args);
  }

  static Future<ApiResponse> submitSamhitaBecomeParticipantForm(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.submitSamhitaBecomeParticipantForm, args);
  }

  static Future<ApiResponse> submitSamhitaVerifyParticipantForm(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.submitSamhitaVerifyParticipantForm, args);
  }

  static Future<ApiResponse> submitUserServiceCreateCustomerForm(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.submitUserServiceCreateCustomerForm, args);
  }

  static Future<ApiResponse> apiCallerScreen(
      String apiRoute, Map<String, dynamic> args) {
    return HttpScreenClient.getApiResponse(apiRoute, args);
  }

  static Future<ApiResponse> submitExtraPayOptInForm(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.submitExtraPayOptInForm, args);
  }

  static Future<ApiResponse> submitSamhitaForm(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.submitSamhitaForm, args);
  }

  static Future<ApiResponse> getServiceDetailScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.serviceDetail, args);
  }

  static Future<ApiResponse> getServicesLandingScreen(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.serviceLandingScreen, args);
  }

  static Future<ApiResponse> getHomescreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.homeScreen, args);
  }

  static Future<ApiResponse> getIspHomescreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.ispHomeScreen, args);
  }

  static Future<ApiResponse> getMembershipScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.membershipScreen, args);
  }

  static Future<ApiResponse> confirmTower(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.confirmTower, args);
  }

  static Future<ApiResponse> getCatalogue(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.catalogueScreen, args);
  }

  static Future<ApiResponse> getProductScreen(args) {
    ProductDataHandler.saveProductSkuId(args['skuId']);
    return HttpScreenClient.getApiResponse(ApiRoutes.productScreen, args);
  }

  static Future<ApiResponse> membershipUpdateCart(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.membershipUpdateCart, args);
  }

  static Future<ApiResponse> updateCart(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateCart, args);
  }

  static Future<ApiResponse> getCartScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.cartScreen, args);
  }

  static Future<ApiResponse> getAddressScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressScreen, args);
  }

  static Future<ApiResponse> getCouponScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.couponScreen, args);
  }

  static Future<ApiResponse> getSearchScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.searchScreen, args);
  }

  static Future<ApiResponse> getOrderScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.orderScreen, args);
  }

  // static Future<ApiResponse> getEmptyCartScreen(args) {
  //   return StandardScreenClient(getDio(),
  //           baseUrl: "http://demo2913052.mockable.io/")
  //       .getEmptyCartScreen(args);
  // }

  static Future<ApiResponse> getOrderHistoryScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.orderHistoryScreen, args);
  }

  static Future<ApiResponse> getMyAccountScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.myAccountScreen, args);
  }

  static Future<ApiResponse> addAddressScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addNewAddressScreen, args);
  }

  static Future<ApiResponse> getAddressBookScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressBook, args);
  }

  static Future<ApiResponse> getInviteScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.inviteScreen, args);
  }

  static Future<ApiResponse> getServiceScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.serviceScreen, args);
  }

  static Future<ApiResponse> getEarningScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.earningScreen, args);
  }

  static Future<ApiResponse> getMyAddressScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.myAddressScreen, args);
  }

  static Future<ApiResponse> getAccountSettings(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.myAccountSettings, args);
  }

  static Future<ApiResponse> getLoginScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.loginScreen, args);
  }

  static Future<ApiResponse> getSignUpScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.signUpScreen, args);
  }

  static Future<ApiResponse> getUserProfile(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getUserProfile, args);
  }

  static Future<ApiResponse> updateCustomerInfo(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateCustomerInfo, args);
  }

  static Future<ApiResponse> updateAnswersInService(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.sendAnswersByServiceId, args);
  }

  static Future<ApiResponse> sendOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.sendOtp, args);
  }

  static Future<ApiResponse> verifyOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyOtp, args);
  }

  static Future<ApiResponse> verifySamhitaOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifySamhitaOtp, args);
  }

  static Future<ApiResponse> addressNext(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addressNext, args);
  }

  static Future<ApiResponse> paymentNext(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.paymentNext, args);
  }

  static Future<ApiResponse> validatePayment(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.paymentValidate, args);
  }

  static Future<ApiResponse> btsLocationFeasibility(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.btsLocationFeasibility, args);
  }

  static Future<ApiResponse> uploadDocuments(args) {
    return HttpScreenClient.getmultipartrequest(ApiRoutes.imageUpload, args);
  }

  static Future<ApiResponse> getNearestTowers(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getNearestTowers, args);
  }

  static Future<ApiResponse> submitOptin(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.submitOptin, args);
  }

  static Future<ApiResponse> submitIspForm(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.submitIspForm, args);
  }

  static Future<ApiResponse> getStates(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getStates, args);
  }

  static Future<ApiResponse> getDistricts(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getDistrict, args);
  }

  static Future<ApiResponse> getBlocks(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getBlocks, args);
  }

  static Future<ApiResponse> getAllGames(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getAllGames, args);
  }

  static Future<ApiResponse> saveNotificationToken(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.notificationAddUser, args);
  }

  static Future<ApiResponse> getOdOpScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.odopScreen, args);
  }

  static Future<ApiResponse> verifyAddAgentOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyAndAddAgent, args);
  }

  static Future<ApiResponse> verifyAndAddAgentOtp(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyAndAddAgent, args);
  }

  static Future<ApiResponse> verifyAgentForPartner(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.verifyAgentForPartner, args);
  }

  static Future<ApiResponse> manageAgent(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.manageAgent, args);
  }

  static Future<ApiResponse> getAddNewAddressScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addNewAddressScreen, args);
  }

  static Future<ApiResponse> getServiceTabsScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.serviceTabs, args);
  }

  static Future<ApiResponse> getAllCustomerForUserService(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAllCustomerForUserService, args);
  }

  static Future<ApiResponse> getAllAgentsForUserService(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAllAgentsForUserService, args);
  }

  static Future<ApiResponse> getServiceDetailsById(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getServiceDetailsById, args);
  }

  static Future<ApiResponse> addPartnerAgent(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addPartnerAgent, args);
  }

  static Future<ApiResponse> addAgentInService(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.addAgentInService, args);
  }

  static Future<ApiResponse> notifyAllAgents(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.notifyAllAgents, args);
  }

  static Future<ApiResponse> getAllUserAgentByPartnerId(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAllUserAgentByPartnerId, args);
  }

  static Future<ApiResponse> createOrUpdateForAgents(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.createOrUpdateForAgents, args);
  }

  static Future<ApiResponse> getAgentDetailsByPartnerIdAndServiceId(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAgentDetailsByPartnerIdAndServiceId, args);
  }

  static Future<ApiResponse> getAcademyTabsScreen(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getAcademyTabs, args);
  }

  static Future<ApiResponse> getAcademyDataByType(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAcademyDataByType, args);
  }

  static Future<ApiResponse> sendOtpForSignup(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.sendOtpForSignup, args);
  }

  static Future<ApiResponse> signupByPhoneNumberOrEmail(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.signupByPhoneNumberOrEmail, args);
  }

  static Future<ApiResponse> verifyOtpAndLogin(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyOtpAndLogin, args);
  }

  static Future<ApiResponse> sendOtpForLogin(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.sendOtpForLogin, args);
  }

  static Future<ApiResponse> sendOtpForLoginCustomer(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.sendOtpForLoginCustomer, args);
  }

  static Future<ApiResponse> getCustomerLokalQr(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.customerLokalQr, args);
  }

  static Future<ApiResponse> getJobsLandingPage(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.jobsLandingPage, args);
  }

  static Future<ApiResponse> getDynamicLandingPage(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.dynamicLandingPage, args);
  }

  static Future<ApiResponse> getUserAccountDetails(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getCustomerProfileInfo, args);
  }
}

// apirequestbody class
// make get login request body function
