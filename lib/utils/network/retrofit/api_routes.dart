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
  static const String odopScreen =
      "/odop/getDistrictHome";
  static const String submitExtraPayOptInForm =
      "/easyOptIn/add";
  static const String verifyAgentForPartner = "/agent/verifyPartner";
  static const String verifyAddAgentOtp = "/agent/verifyOtp";
}
