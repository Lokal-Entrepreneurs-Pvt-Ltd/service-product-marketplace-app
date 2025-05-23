class ApiRoutes {
  static const String homeScreen = '/discovery/get';
  static const String serviceLandingScreen = '/service/getAll';
  static const String catalogueScreen = '/products/get';
  static const String productScreen = "/products/getProductDetails";
  static const String updateCart = '/cart/update';
  static const String membershipUpdateCart = "/membership/updateCart";
  static const String cartScreen = '/cart/get';
  static const String addressScreen = '/checkout/initiate';
  static const String searchScreen = '/discovery/search';
  static const String paymentDetailsScreen = '/paymentdetailsscreen';
  static const String paymentStatusScreen = '/paymentstatusscreen';
  static const String orderScreen = '/order/get';
  static const String paymentdetailsScreen = '/paymentdetailsscreen';
  static const String orderHistoryScreen = "/order/getAll";
  static const String otp = "/otp";
  static const String avatar = "/avatar";
  static const String icon = "/icon";
  static const String emptyCartScreen = "/emptycartscreen";
  static const String forgetPassword = "/forgetPassword";
  static const String myAccountScreen = "/customer/account";
  static const String checkoutInit = "/checkout/initiate";
  static const String addNewAddressScreen = "/checkout/getAddressScreen";
  static const String addAddressScreen = "/addaddressScreen";
  static const String couponScreen = "/cart/coupon/getAll";
  static const String myAddressScreen = "/customer/address";
  static const String loginScreen = "/customer/login";
  static const String signUpScreen = "/customer/signup";
  static const String inviteScreen = "/invite";
  static const String earningScreen = "/earning";
  static const String serviceScreen = "/service";
  static const String updateCustomerInfo = "/customer/updatecustomerinfo";
  static const String sendOtp = "/customer/sendOtp";
  static const String verifyOtp = "/customer/verifyOtp";
  static const String addressNext = "/checkout/address/next";
  static const String paymentNext = "/checkout/payment/next";
  static const String paymentValidate = "/checkout/payment/validate";
  static const String addressBook = "/checkout/addressbook";
  static const String btsLocationFeasibility =
      "/isp/feasiblity/locationFeasiblityForm";
  static const String getNearestTowers = "/isp/feasiblity/getNearestTowers";
  static const String submitIspForm = "/isp/feasiblity/submitIspForm";
  static const String getStates = "/isp/feasiblity/getStates";
  static const String getDistrict = "/isp/feasiblity/getDistrictForState";
  static const String getBlocks = "/isp/feasiblity/getBlocksForDistrict";
  static const String getAllGames = "/misc/getAllGames";
  static const String ispHomeScreen = "/isp/feasiblity/getIspHome";
  static const String confirmTower = "/isp/feasiblity/confirmTower";
  static const String membershipScreen = "/membership/getall";
  static const String serviceDetail = "/service/getById";
  static const String notificationAddUser = "/notification/add/";
  static const String submitOptin = "/optin/create";
  static const String samhitaHome = "/samhita/home";
  static const String submitSamhitaForm = "/samhita/campionOptIn";
  static const String submitSamhitaAddParticipantsForm =
      "/samhita/createParticipant";
  static const String submitSamhitaBecomeParticipantForm =
      "/samhita/createParticipantSendOtp";
  static const String verifySamhitaOtp = "/samhita/samhitaVerifyOtp";
  static const String submitSamhitaVerifyParticipantForm =
      "/samhita/verifyParticipant";
  static const String odopScreen = "/odop/getDistrictHome";
  static const String submitExtraPayOptInForm = "/easyOptIn/add";
  static const String verifyAgentForPartner = "/agent/add";
  static const String manageAgent = "/agent/manage";
  static const String verifyAddAgentOtp = "/agent/verifyOtp";
  static const String submitUserServiceCreateCustomerForm =
      "/userServiceCustomer/create";
  static const String serviceTabs = "/service/getTabs";
  static const String getAllCustomerForUserService =
      "/service/getAllCustomerForUserService";
  static const String getAllAgentsForUserService =
      "/service/getAllAgentsForUserService";
  static const String getServiceDetailsById = "/service/getDetailsById";
  static const String addPartnerAgent = "/partnerAgent/add";
  static const String notifyAllAgents = "/notifyAllAgents";
  static const String getAllUserAgentByPartnerId =
      "/user/getAllUserAgentByPartnerId";
  static const String createOrUpdateForAgents =
      "/userService/createOrUpdateForAgents";
  static const String getAgentDetailsByPartnerIdAndServiceId =
      "/partnerAgent/getAgentDetailsByPartnerIdAndServiceId";
  static const String getAcademyTabs = "/trainingAcademy/getTabs";
  static const String getAcademyDataByType =
      "/trainingAcademy/getAcademyDataByType";
  static const String editScreen = "/editScreen";
  static const String sendOtpForSignup = "/customer/sendOtpForSignup";
  static const String signupByPhoneNumberOrEmail =
      "/customer/signupByPhoneNumberOrEmail";
  static const String verifyOtpAndLogin = "/customer/verifyOtpAndLogin";
  static const String sendOtpForLogin = "/customer/sendOtpForLogin";
  static const String sendOtpForLoginCustomer = "/customer/sendOtpForLogin";
  static const String uploadDocumentonServer = "/image/upload";
  static const String getUserProfile = "/customer/userProfile";
  static const String getQuestionsByServiceId =
      "/service/getQuestionsForService";
  static const String sendAnswersByServiceId =
      "/userService/createUserServiceApplication";
  static const String imageUpload = "/image/upload";
  static const String addAgentInService = "/agent/addAgentRequest";
  static const String verifyAndAddAgent = "/agent/verifyAndAddAgent";
  static const String customerLokalQr = "/customer/getLokalQr";
  static const String jobsLandingPage = "/jobs/landingPage";
  static const String jobsDetailsById = "/jobs/detailsById";
  static const String stateList = "/location/getStatesList";
  static const String districtListByState = "/location/getDistrictForState";
  static const String blockListByDistrict = "/location/getBlocksForDistrict";
  static const String dynamicLandingPage = "/dynamic/landingPage";
  static const String getCustomerProfileInfo = "/customer/getProfileInfo";
  static const String myAccountSettings = "/customer/accountSettings";
  static const String getUserByLokalId = "/user/getByLokalId";
  static const String getGoldPass = "/membership/getGoldPass";
  static const String updateReferredby = "/refferal/add";
  static const String getUserByLokalIdorPhone =
      "/user/getUserByLokalIdOrPhoneNumber";
  static const String updateUserAuthForEmail =
      "/customer/updateUserAuthForEmail";
  static const String verifyOtpAndLoginByEmail =
      "/customer/verifyOtpAndLoginByEmail";
  static const String digiLockerInitiate = "/digilocker/initiate";
  static const String getAccessTokenFromDigiLocker =
      "/digilocker/getAccessToken";
  static const String getIssuedFilesFromDigiLocker =
      "/digilocker/getIssuedFiles";
  static const String getAadharFromDigiLocker = "/digilocker/getAadhar";
  static const String getAllGovernmentServices = "/governmentSkill/getAll";
  static const String createUserGovSkill = "/userGovSkills/add";
  static const String updateSolarUserInfo = "/companyInfo/update";
  static const String getAllAgentByPartnerId =
      "/partnerAgent/getAgentDetailsByPartnerId";
  static const String addTeamMemberRequest = "/agent/addTeamMemberRequest";
  static const String updateCustomerById = "/agent/update";
  static const String deleteCustomerById = "/agent/deletebyid";
  static const String addNewLeads = "/leads/add";
  static const String fetchPDF = "/pdfextract/extractpdfdata";
  static const String addLoanDetails = "/loan/add";
  static const String requestPasswordReset =
      "/customer/requestPasswordResetToken";
  static const String resetPassword = "/customer/resetPassword";
  static const String phoneNumberAuth = "/customer/phoneNumberAuth";
  static const String generatePdf = "/resume/generatePdfv2";
  static const String previewResume = "/resume/preview";
  static const String initiatePaymentResume = "/resume/initiatePayment";
  static const String verifyPaymentResume = "/resume/verifyPayment";
  static const String downloadResume = "/resume/download";
}
