import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/pages/UikAddAddressScreen.dart';
import 'package:lokal/pages/UikAddressBook.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikCouponScreen.dart';
import 'package:lokal/pages/UikCustomerForUserService.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikIspHome.dart';
import 'package:lokal/pages/UikMembershipScreen.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/pages/UikMyAddressScreen.dart';
import 'package:lokal/pages/UikMyGames.dart';
import 'package:lokal/pages/UikOdOpScreen.dart';
import 'package:lokal/pages/UikOrderHistoryScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikPaymentDetailsScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSamhitaHome.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:lokal/pages/UikServiceDetail.dart';
import 'package:lokal/pages/UikServicesLanding.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/Form/SamhitaBecomeParticipant.dart';
import 'package:lokal/screens/Form/SamhitaDataCollector.dart';
import 'package:lokal/screens/Form/SamhitaOtp.dart';
import 'package:lokal/screens/Form/SamhitaVerifyParticipant.dart';
import 'package:lokal/screens/Form/extraPayOptIn.dart';
import 'package:lokal/screens/Onboarding/NewOnboardingScreen.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';
import 'package:lokal/screens/WebViewScreen.dart';
import 'package:lokal/screens/addServiceCustomerFlow/addServiceCustomerFlow.dart';
import 'package:lokal/screens/addServiceCustomerFlow/apiCallerScreen.dart';
import 'package:lokal/screens/agents/AddAgentOtpScreen.dart';
import 'package:lokal/screens/agents/AddAgentScreen.dart';
import 'package:lokal/screens/agents/manageAgentScreen.dart';
import 'package:lokal/screens/agents/notifyAllAgents.dart';
import 'package:lokal/screens/detailScreen/UikMyDetailsScreen.dart';
import 'package:lokal/screens/landing_screen/my_agents_list_screen.dart';
import 'package:lokal/screens/landing_screen/service_landing_screen.dart';
import 'package:lokal/screens/myRewards/myRewardPage.dart';
import 'package:lokal/screens/partnerTraining/PartnerTrainingHome.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';

import '../../pages/UikAgentsForUserService.dart';
import '../../screens/Form/SamhitaAddParticipants.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');

  // Go Router

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: UserDataHandler.getUserToken().isEmpty
        ? _onboardingScreen.path
        : _uikBottomNavigationBar.path,
    routes: [
      _onboardingScreen,
      _uikBottomNavigationBar,
      _loginScreen,
      _signUpScreen,
      _uikHomeWrapper,
      _myAccountScreen,
      _webScreenView,
      _partnerTrainingHome,
      _serServiceTabsScreen,
      _catalogueScreen,
      _productScreen,
      _cartScreen,
      _addressBookScreen,
      _paymentDetailsScreen,
      _orderScreen,
      _addAddressScreen,
      _orderHistoryScreen,
      _myGames,
      _ispHome,
      _couponScreen,
      _membershipLanding,
      _searchScreen,
      _serviceLandingScreen,
      _odOpHomeScreen,
      _serviceScreen,
      _samhitaLandingPage,
      _myAddressScreen,
      _myDetailsScreen,
      _otpScreen,
      _samhitaDataCollector,
      _samhitaAddParticipantForm,
      _samhitaBecomeParticipantForm,
      _samhitaOtp,
      _extraPayOptInScreen,
      _samhitaVerifyParticipantForm,
      _addAgentScreen,
      _addAgentOtpScreen,
      _newOnboardingScreen,
      _myRewardsPage,
      _addUserServiceCustomer,
      _apiCallerScreen,
      _notifyAgentsScreen,
      _myAgentListScreen,
      _manageAgentScreen,
      _getAllCustomerForUserService,
      _getAllAgentsForUserService,
    ],
  );

  GoRouter get router => _goRouter;

  static final GoRoute _onboardingScreen = GoRoute(
    path: ScreenRoutes.onboardingScreen,
    builder: (context, state) {
      return OnboardingScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _uikBottomNavigationBar = GoRoute(
    path: ScreenRoutes.uikBottomNavigationBar,
    builder: (context, state) {
      return UikBottomNavigationBar(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _uikHomeWrapper = GoRoute(
    path: ScreenRoutes.homeScreen,
    builder: (context, state) {
      return UikHomeWrapper(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _signUpScreen = GoRoute(
    path: ScreenRoutes.signUpScreen,
    builder: (context, state) {
      return SignupScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _loginScreen = GoRoute(
    path: ScreenRoutes.loginScreen,
    builder: (context, state) {
      return LoginScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _myAccountScreen = GoRoute(
    path: ScreenRoutes.myAccountScreen,
    builder: (context, state) {
      return UikMyAccountScreen().page;
    },
  );
  static final GoRoute _partnerTrainingHome = GoRoute(
    path: ScreenRoutes.partnerTrainingHome,
    builder: (context, state) {
      return PartnerTrainingHomeScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _webScreenView = GoRoute(
    path: ScreenRoutes.webScreenView,
    builder: (context, state) {
      return WebViewScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _serServiceTabsScreen = GoRoute(
    path: ScreenRoutes.userServiceTabsScreen,
    builder: (context, state) {
      return ServiceLandingScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _catalogueScreen = GoRoute(
    path: ScreenRoutes.catalogueScreen,
    builder: (context, state) {
      return UikCatalogScreen().page;
    },
  );
  static final GoRoute _productScreen = GoRoute(
    path: ScreenRoutes.productScreen,
    builder: (context, state) {
      return UikProductPage().page;
    },
  );
  static final GoRoute _cartScreen = GoRoute(
    path: ScreenRoutes.cartScreen,
    builder: (context, state) {
      return UikCartScreen().page;
    },
  );
  static final GoRoute _addressBookScreen = GoRoute(
    path: ScreenRoutes.addressBookScreen,
    builder: (context, state) {
      return UikAddressBook().page;
    },
  );
  static final GoRoute _paymentDetailsScreen = GoRoute(
    path: ScreenRoutes.paymentDetailsScreen,
    builder: (context, state) {
      return UikPaymentDetailsScreen().page;
    },
  );
  static final GoRoute _orderScreen = GoRoute(
    path: ScreenRoutes.orderScreen,
    builder: (context, state) {
      return UikOrderScreen(
        args: state.extra
      ).page;
    },
  );
  static final GoRoute _addAddressScreen = GoRoute(
    path: ScreenRoutes.addAddressScreen,
    builder: (context, state) {
      return UikAddAddressScreen().page;
    },
  );
  static final GoRoute _orderHistoryScreen = GoRoute(
    path: ScreenRoutes.orderHistoryScreen,
    builder: (context, state) {
      return UikOrderHistoryScreen().page;
    },
  );
  static final GoRoute _myGames = GoRoute(
    path: ScreenRoutes.myGames,
    builder: (context, state) {
      return UikMyGames().page;
    },
  );
  static final GoRoute _ispHome = GoRoute(
    path: ScreenRoutes.ispHome,
    builder: (context, state) {
      return UikIspHome().page;
    },
  );
  static final GoRoute _couponScreen = GoRoute(
    path: ScreenRoutes.couponScreen,
    builder: (context, state) {
      return UikCouponScreen().page;
    },
  );
  static final GoRoute _membershipLanding = GoRoute(
    path: ScreenRoutes.membershipLanding,
    builder: (context, state) {
      return UikMembershipScreen().page;
    },
  );
  static final GoRoute _searchScreen = GoRoute(
    path: ScreenRoutes.searchScreen,
    builder: (context, state) {
      return UikSearchCatalog().page;
    },
  );
  static final GoRoute _serviceLandingScreen = GoRoute(
    path: ScreenRoutes.serviceLandingScreen,
    builder: (context, state) {
      return UikServicesLanding().page;
    },
  );
  static final GoRoute _odOpHomeScreen = GoRoute(
    path: ScreenRoutes.odOpHomeScreen,
    builder: (context, state) {
      return UikOdOpScreen().page;
    },
  );
  static final GoRoute _serviceScreen = GoRoute(
    path: ScreenRoutes.serviceScreen,
    builder: (context, state) {
      return UikServiceDetail().page;
    },
  );
  static final GoRoute _samhitaLandingPage = GoRoute(
    path: ScreenRoutes.samhitaLandingPage,
    builder: (context, state) {
      return UikSamhitaHome().page;
    },
  );
  static final GoRoute _myAddressScreen = GoRoute(
    path: ScreenRoutes.addressBookScreen,
    builder: (context, state) {
      return UikMyAddressScreen(rootNavigatorKey.currentContext!).page;
    },
  );
  static final GoRoute _myDetailsScreen = GoRoute(
    path: ScreenRoutes.myDetailsScreen,
    builder: (context, state) {
      return MyDetailsScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _otpScreen = GoRoute(
    path: ScreenRoutes.otpScreen,
    builder: (context, state) {
      return OtpScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _samhitaDataCollector = GoRoute(
    path: ScreenRoutes.samhitaDataCollector,
    builder: (context, state) {
      return SamhitaDataCollector(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _samhitaAddParticipantForm = GoRoute(
    path: ScreenRoutes.samhitaAddParticipantForm,
    builder: (context, state) {
      return SamhitaAddParticipants(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _samhitaBecomeParticipantForm = GoRoute(
    path: ScreenRoutes.samhitaBecomeParticipantForm,
    builder: (context, state) {
      return SamhitaBecomeParticipant(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _samhitaOtp = GoRoute(
    path: ScreenRoutes.samhitaBecomeParticipantForm,
    builder: (context, state) {
      return SamhitaOtp(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _extraPayOptInScreen = GoRoute(
    path: ScreenRoutes.extraPayOptInScreen,
    builder: (context, state) {
      return extraPayOptIn(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _samhitaVerifyParticipantForm = GoRoute(
    path: ScreenRoutes.samhitaVerifyParticipantForm,
    builder: (context, state) {
      return SamhitaVerifyParticipant(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _addAgentScreen = GoRoute(
    path: ScreenRoutes.addAgentScreen,
    builder: (context, state) {
      return AddAgentScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _addAgentOtpScreen = GoRoute(
    path: ScreenRoutes.addAgentOtpScreen,
    builder: (context, state) {
      return AddAgentOtpScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _newOnboardingScreen = GoRoute(
    path: ScreenRoutes.newOnboardingScreen,
    builder: (context, state) {
      return LoginScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _myRewardsPage = GoRoute(
    path: ScreenRoutes.myRewardsPage,
    builder: (context, state) {
      return MyRewardPage(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _addUserServiceCustomer = GoRoute(
    path: ScreenRoutes.addUserServiceCustomer,
    builder: (context, state) {
      return AddServiceCustomerFlow(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _apiCallerScreen = GoRoute(
    path: ScreenRoutes.apiCallerScreen,
    builder: (context, state) {
      return ApiCallerScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _notifyAgentsScreen = GoRoute(
    path: ScreenRoutes.notifyAgentsScreen,
    builder: (context, state) {
      return NotifyAgentsScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _myAgentListScreen = GoRoute(
    path: ScreenRoutes.myAgentListScreen,
    builder: (context, state) {
      return MyAgentListScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );
  static final GoRoute _manageAgentScreen = GoRoute(
    path: ScreenRoutes.manageAgentScreen,
    builder: (context, state) {
      return ManageAgentScreen().page;
    },
  );
  static final GoRoute _getAllCustomerForUserService = GoRoute(
    path: ScreenRoutes.getAllCustomerForUserService,
    builder: (context, state) {
      return UikCustomerForUserService().page;
    },
  );
  static final GoRoute _getAllAgentsForUserService = GoRoute(
    path: ScreenRoutes.getAllAgentsForUserService,
    builder: (context, state) {
      return UikAgentsForUserService().page;
    },
  );
}
