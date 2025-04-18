// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/product_data_handler.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'http/http_screen_client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  static Dio getDio() {
    Dio dio = Dio(BaseOptions(contentType: "application/json"));
    // dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
  }

  static Future<ApiResponse> updateReferredbyInfo(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateReferredby, args);
  }

  static Future<ApiResponse> getUserByLokalID(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getUserByLokalId, args);
  }

  static Future<ApiResponse> getUserByLokalIDorPhoneNumber(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getUserByLokalIdorPhone, args);
  }

  static Future<ApiResponse> getStateList(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.stateList, args);
  }

  static Future<ApiResponse> getDistrictByStateCode(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.districtListByState, args);
  }

  static Future<ApiResponse> getBlockByDistrictCode(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.blockListByDistrict, args);
  }

  static Future<Map<String, dynamic>?> getBankDetailsByIfsc(args) {
    return HttpScreenClient.getIfscCode(args);
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

  static Future<ApiResponse> apiCallerScreen(String apiRoute,
      Map<String, dynamic> args) {
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

  static Future<ApiResponse> addTeamMemberRequest(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.addTeamMemberRequest, args);
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

  static Future<ApiResponse> updateUserAuthForEmail(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.updateUserAuthForEmail, args);
  }

  static Future<ApiResponse> initiateDigiLocker(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.digiLockerInitiate, {
      "reference_id": "2",
      "consent": true,
      "consent_purpose": "testing the credentials"
    });
  }

  static Future<ApiResponse> getAccessTokenFromDigiLocker(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAccessTokenFromDigiLocker, args);
  }

  static Future<ApiResponse> getIssuedFilesFromFromDigiLocker(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getIssuedFilesFromDigiLocker, args);
  }

  static Future<ApiResponse> getAdhaarFromDigiLocker(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAadharFromDigiLocker, args);
  }

  static Future<ApiResponse> getAllGovernmentServices(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAllGovernmentServices, args);
  }

  static Future<ApiResponse> createUserGovSkill(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.createUserGovSkill, args);
  }

  static Future<ApiResponse> verifyOtpAndLoginByEmail(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.verifyOtpAndLoginByEmail, args);
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

  static Future<ApiResponse> getGoldPass(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.getGoldPass, args);
  }

  static Future<ApiResponse> updateSolarUserFields(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateSolarUserInfo, args);
  }

  static Future<ApiResponse> getAllAgentByPartnerId(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.getAllAgentByPartnerId, args);
  }

  static Future<ApiResponse> updateCustomerById(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.updateCustomerById, args);
  }

  static Future<ApiResponse> deleteCustomerById(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.deleteCustomerById, args);
  }

  static Future<ApiResponse> fieldScreenApi(String route, args) {
    return HttpScreenClient.getApiResponse(route, args);
  }

  static Future<ApiResponse> fetchPDF(args) {
    return HttpScreenClient.getmultipartrequest(ApiRoutes.fetchPDF, args);
  }

  static Future<ApiResponse> requestPasswordResetToken(args) {
    return HttpScreenClient.getApiResponse(
        ApiRoutes.requestPasswordReset, args);
  }

  static Future<ApiResponse> resetPassword(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.resetPassword, args);
  }

  static Future<ApiResponse> phoneNumberAuth(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.phoneNumberAuth, args);
  }

  static Future<ApiResponse> generateResumePdf(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.generatePdf, args);
  }

  static Future<ApiResponse> previewResume(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.previewResume, args);
  }

  static Future<ApiResponse> initiatePaymentResume(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.initiatePaymentResume, args);
  }

  static Future<ApiResponse> verifyPaymentResume(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.verifyPaymentResume, args);
  }

  static Future<ApiResponse> downLoadResume(args) {
    return HttpScreenClient.getApiResponse(ApiRoutes.downloadResume, args);
  }
}

  // static Future<ApiResponse> verifyOtp(Map<String, dynamic> request) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${ApiConstants.baseUrl}/auth/verify-otp'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(request),
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //     return ApiResponse(
  //       isSuccess: response.statusCode == 200,
  //       data: responseData['data'],
  //       error: response.statusCode != 200 ? responseData : null,
  //     );
  //   } catch (e) {
  //     return ApiResponse(
  //       isSuccess: false,
  //       error: {'message': 'Network error occurred'},
  //     );
  //   }
  // }
//}

// apirequestbody class
// make get login request body functiona
