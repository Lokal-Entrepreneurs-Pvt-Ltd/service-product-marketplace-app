import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/pages/UikAccountSettings.dart';
import 'package:lokal/pages/UikDynamicPage.dart';
import 'package:lokal/screens/Onboarding/newLogin/newOtpScreen.dart';
import 'package:lokal/screens/Onboarding/newLogin/newPasswordScreen.dart';
import 'package:lokal/screens/Onboarding/newLogin/newSignUpScreen.dart';
import 'package:lokal/screens/detailScreen/UserAccountDetails.dart';
import 'package:lokal/screens/Onboarding/newLogin/newLogin.dart';
import 'package:lokal/screens/membership/GoldPassScreen.dart';
import 'package:lokal/screens/serviceInfra/DeliveryJobDetailsPage.dart';
import 'package:lokal/screens/serviceInfra/JobDetailsPage.dart';
import 'package:lokal/screens/serviceInfra/agent_details.dart';
import 'package:lokal/screens/serviceInfra/apniDetails/userDocumentInfo.dart';
import 'package:lokal/screens/serviceInfra/apniDetails/userGeneralInfo.dart';
import 'package:lokal/screens/serviceInfra/apniDetails/userOtherInfo.dart';
import 'package:lokal/screens/serviceInfra/apniDetails/userPersonalinfo.dart';
import 'package:lokal/screens/serviceInfra/applyforJob/otherjobdetails.dart';
import 'package:lokal/screens/serviceInfra/applyforJob/personaldetails.dart';
import 'package:lokal/screens/serviceInfra/customer_details.dart';
import 'package:lokal/screens/serviceInfra/jobscreen.dart';
import 'package:lokal/screens/serviceInfra/my_agents_list_screen.dart';
import 'package:lokal/screens/serviceInfra/my_agents_list_service_screen.dart';
import 'package:lokal/screens/serviceInfra/my_customers_list.dart';
import 'package:lokal/screens/serviceInfra/service_landing_screen.dart';
import 'package:lokal/screens/serviceInfra/sl_details_page.dart';
import 'package:lokal/screens/serviceInfra/sl_earnings_page.dart';
import 'package:lokal/screens/signUp/customer_signup_screen.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/screens/serviceInfra/status.dart';
import 'package:lokal/widgets/UikFilter.dart';
import 'package:upgrader/upgrader.dart';
import '../../pages/UikAgentsForUserService.dart';
import '../../pages/UikCustomerLokalQr.dart';
import '../../screens/Form/SamhitaAddParticipants.dart';

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
import 'package:lokal/screens/Onboarding/CustomerLoginScreen.dart';
import 'package:lokal/screens/Onboarding/LokalPartnerLoginScreen.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';
import 'package:lokal/screens/WebViewScreen.dart';
import 'package:lokal/screens/addServiceCustomerFlow/addServiceCustomerFlow.dart';
import 'package:lokal/screens/addServiceCustomerFlow/apiCallerScreen.dart';
import 'package:lokal/screens/agents/AddAgentOtpScreen.dart';
import 'package:lokal/screens/agents/AddAgentScreen.dart';
import 'package:lokal/screens/agents/manageAgentScreen.dart';
import 'package:lokal/screens/agents/notifyAllAgents.dart';
import 'package:lokal/screens/basicdetails/otherdetails.dart';
import 'package:lokal/screens/basicdetails/personaldetails.dart';
import 'package:lokal/screens/basicdetails/upload%20documents.dart';
import 'package:lokal/screens/detailScreen/UikMyDetailsScreen.dart';
import 'package:lokal/screens/editProfile/edit_profile_screen.dart';
import 'package:lokal/screens/myAccount/myAccountPageWrapper.dart';
import 'package:lokal/screens/myRewards/myRewardPage.dart';
import 'package:lokal/screens/partnerTraining/PartnerTrainingHome.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');

  void popUntil(GoRoute routeBase) {
    while (_goRouter.canPop() &&
        _goRouter.routerDelegate.currentConfiguration.matches.last.route !=
            routeBase) {
      _goRouter.pop();
    }
  }

  static void popUntilByName(String name) {
    while (_goRouter.canPop()) {
      GoRoute go =
          _goRouter.routerDelegate.currentConfiguration.routes.last as GoRoute;
      if (go.path == name) {
        break;
      }
      _goRouter.pop();
    }
    print(_goRouter.routerDelegate.currentConfiguration.routes.length);
  }

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: UserDataHandler.getUserToken().isEmpty
        ? _onboardingScreen.path
        : uikBottomNavigationBar.path,
    // initialLocation: _goldPassScreen.path,
    observers: [ChuckerFlutter.navigatorObserver],
    routes: [
      _onboardingScreen,
      uikBottomNavigationBar,
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
      _profileScreen,
      _profile_otherdetails,
      _profile_uploaddocuments,
      _profile_personal_details,
      _jobApplicationsPersonalDetails,
      _jobApplicationServiceQuestions,
      _alljobDetails,
      _customerloginScreen,
      _customerSignUpScreen,
      _uikMyAddress,
      _customerLokalQr,
      _jobsFiltersPage,
      _jobsDetailsPage,
      _userPersonalInfo,
      _userGeneralInfo,
      _userOtherInfo,
      _userDocumentInfo,
      _dynamicPage,
      _userAccountDetails,
      _userAccountSettings,
      _loginScreen2,
      _otpScreen2,
      _passwordScreen2,
      _signupScreen2,
      _deliveryJobsDetailsPage,
      _goldPassScreen,
      _newsScreen,
    ],
  );

  GoRouter get router => _goRouter;

  static final GoRoute _newsScreen = GoRoute(
    path: ScreenRoutes.newsPage,
    builder: (context, state) {
      // final Map<String, dynamic>? extraArgs =
      // state.extra as Map<String, dynamic>?;
      return const DUIPage(
        pageUid: 'homepage-65fbe15043a6c8e5400e65b9',
      );
    },
  );

  static final GoRoute _goldPassScreen = GoRoute(
    path: ScreenRoutes.goldPassScreen,
    builder: (context, state) {
      return GoldPassScreen(
        key: state.pageKey,
         args: state.extra,
      );
    },
  );

  static final GoRoute _signupScreen2 = GoRoute(
    path: ScreenRoutes.signupScreen2,
    builder: (context, state) {
      return SignupScreen2(
        key: state.pageKey,
        // args: state.extra,
      );
    },
  );

  static final GoRoute _passwordScreen2 = GoRoute(
    path: ScreenRoutes.passwordScreen2,
    builder: (context, state) {
      return PasswordScreen2(
        key: state.pageKey,
        args: state.extra,
        // args: state.extra,
      );
    },
  );

  static final GoRoute _otpScreen2 = GoRoute(
    path: ScreenRoutes.otpScreen2,
    builder: (context, state) {
      return NewOTPScreen(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );

  static final GoRoute _loginScreen2 = GoRoute(
    path: ScreenRoutes.loginScreen2,
    builder: (context, state) {
      return LoginScreen2(
        key: state.pageKey,
      );
    },
  );

  static final GoRoute _userAccountDetails = GoRoute(
    path: ScreenRoutes.userAccountDetails,
    builder: (context, state) {
      return UserAccountDetails(
        key: state.pageKey,
        args: state.extra,
      );
    },
  );

  static final GoRoute _userAccountSettings = GoRoute(
    path: ScreenRoutes.accountSettings,
    builder: (context, state) {
      // args: state.extra as Map<String, dynamic>
      return MyAccountWrapper(page: UikAccountSettings().page);
    },
  );

  static final GoRoute _userPersonalInfo = GoRoute(
    path: ScreenRoutes.userProfileInfo,
    builder: (context, state) {
      return UserPersonalInfo(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _userGeneralInfo = GoRoute(
    path: ScreenRoutes.userGeneralInfo,
    builder: (context, state) {
      return UserGeneralInfo(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _userOtherInfo = GoRoute(
    path: ScreenRoutes.userOtherInfo,
    builder: (context, state) {
      return UserOtherInfo(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _dynamicPage = GoRoute(
    path: ScreenRoutes.dynamicPage,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikDynamicPage(
        args: extraArgs,
      ).page;
      // return OtherDetails();
    },
  );
  static final GoRoute _userDocumentInfo = GoRoute(
    path: ScreenRoutes.userDocumentInfo,
    builder: (context, state) {
      return UserDocumentInfo(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _profile_personal_details = GoRoute(
    path: ScreenRoutes.personalDetails,
    builder: (context, state) {
      return PersonalDetails(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _profile_otherdetails = GoRoute(
    path: ScreenRoutes.otherdetails,
    builder: (context, state) {
      return OtherDetails(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _profile_uploaddocuments = GoRoute(
    path: ScreenRoutes.uploadDocuments,
    builder: (context, state) {
      return UploadDocuments(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _personalDetails = GoRoute(
    path: ScreenRoutes.personalDetails,
    builder: (context, state) {
      return PersonalDetails(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );
  static final GoRoute _alljobDetails = GoRoute(
    path: ScreenRoutes.alljobs,
    builder: (context, state) {
      return JobScreen(
        key: state.pageKey,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _jobApplicationServiceQuestions = GoRoute(
    path: ScreenRoutes.jobApplicationServiceQuestion,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return ApplyForJobServiceQuestions(
        key: state.pageKey,
        args: extraArgs,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _jobApplicationsPersonalDetails = GoRoute(
    path: ScreenRoutes.jobApplicationPersonalDetails,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return ApplyForJobPersonalDetails(
        key: state.pageKey,
        args: extraArgs,
      );
      // return OtherDetails();
    },
  );

  static final GoRoute _onboardingScreen = GoRoute(
    path: ScreenRoutes.onboardingScreen,
    builder: (context, state) {
      return OnboardingScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute uikBottomNavigationBar = GoRoute(
    path: ScreenRoutes.uikBottomNavigationBar,
    builder: (context, state) {
      return UpgradeAlert(
        showIgnore: false,
        child: UikBottomNavigationBar(
          key: state.pageKey,
        ),
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

  static final GoRoute _jobsFiltersPage = GoRoute(
    path: ScreenRoutes.jobsFiltersPage,
    builder: (context, state) {
      return UikFilter(
        args: state.extra as Map<String, dynamic>,
      );
    },
  );
  static final GoRoute _customerSignUpScreen = GoRoute(
    path: ScreenRoutes.customerSignUpScreen,
    builder: (context, state) {
      return CustomerSignupScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _jobsDetailsPage = GoRoute(
    path: ScreenRoutes.jobsDetailsPage,
    builder: (context, state) {
      return JobDetailsScreen(
          key: state.pageKey, args: state.extra as Map<String, dynamic>?);
    },
  );

  static final GoRoute _deliveryJobsDetailsPage = GoRoute(
    path: ScreenRoutes.deliveryJobsDetailsPage,
    builder: (context, state) {
      return DeliveryJobDetailsScreen(
          key: state.pageKey, args: state.extra as Map<String, dynamic>?);
    },
  );
  static final GoRoute _uikMyAddress = GoRoute(
    path: ScreenRoutes.myAddressScreen,
    builder: (context, state) {
      return UikMyAddressScreen(context,
              args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
  static final GoRoute _profileScreen = GoRoute(
    path: ScreenRoutes.profileScreen,
    builder: (context, state) {
      return EditProfileScreen(
        key: state.pageKey,
      );
    },
  );

  static final GoRoute _customerLokalQr = GoRoute(
    path: ScreenRoutes.customerLokalQr,
    builder: (context, state) {
      return UikCustomerLokalQr(args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
  static final GoRoute _loginScreen = GoRoute(
    path: ScreenRoutes.loginScreen,
    builder: (context, state) {
      return LokalPartnerLoginScreen(
        key: state.pageKey,
      );
    },
  );

  static final GoRoute _customerloginScreen = GoRoute(
    path: ScreenRoutes.customerLoginScreen,
    builder: (context, state) {
      return CustomerLoginScreen(
        key: state.pageKey,
      );
    },
  );
  static final GoRoute _myAccountScreen = GoRoute(
    path: ScreenRoutes.myAccountScreen,
    builder: (context, state) {
      // final Map<String, dynamic>? extraArgs =
      // state.extra as Map<String, dynamic>?;
      return MyAccountWrapper(page: UikMyAccountScreen(args: {}).page);
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
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikCatalogScreen(args: extraArgs).page;
    },
  );
  static final GoRoute _productScreen = GoRoute(
    path: ScreenRoutes.productScreen,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikProductPage(args: extraArgs).page;
    },
  );
  static final GoRoute _cartScreen = GoRoute(
    path: ScreenRoutes.cartScreen,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikCartScreen(args: extraArgs).page;
    },
  );
  static final GoRoute _addressBookScreen = GoRoute(
    path: ScreenRoutes.addressBookScreen,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikAddressBook(args: extraArgs).page;
    },
  );
  static final GoRoute _paymentDetailsScreen = GoRoute(
    path: ScreenRoutes.paymentDetailsScreen,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikPaymentDetailsScreen(args: extraArgs).page;
    },
  );
  static final GoRoute _orderScreen = GoRoute(
    path: ScreenRoutes.orderScreen,
    builder: (context, state) {
      return UikOrderScreen(args: state.extra as Map<String, dynamic>?).page;
    },
  );
  static final GoRoute _addAddressScreen = GoRoute(
    path: ScreenRoutes.addAddressScreen,
    builder: (context, state) {
      return UikAddAddressScreen(
        args: state.extra as Map<String, dynamic>?,
      ).page;
    },
  );
  static final GoRoute _orderHistoryScreen = GoRoute(
    path: ScreenRoutes.orderHistoryScreen,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikOrderHistoryScreen(args: extraArgs).page;
    },
  );
  static final GoRoute _myGames = GoRoute(
    path: ScreenRoutes.myGames,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikMyGames(args: extraArgs).page;
    },
  );
  static final GoRoute _ispHome = GoRoute(
    path: ScreenRoutes.ispHome,
    builder: (context, state) {
      final Map<String, dynamic>? extraArgs =
          state.extra as Map<String, dynamic>?;
      return UikIspHome(args: extraArgs).page;
    },
  );
  static final GoRoute _couponScreen = GoRoute(
    path: ScreenRoutes.couponScreen,
    builder: (context, state) {
      return UikCouponScreen(args: state.extra as Map<String, dynamic>?).page;
    },
  );
  static final GoRoute _membershipLanding = GoRoute(
    path: ScreenRoutes.membershipLanding,
    builder: (context, state) {
      return UikMembershipScreen(args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
  static final GoRoute _searchScreen = GoRoute(
    path: ScreenRoutes.searchScreen,
    builder: (context, state) {
      return UikSearchCatalog(args: state.extra as Map<String, dynamic>?).page;
    },
  );
  static final GoRoute _serviceLandingScreen = GoRoute(
    path: ScreenRoutes.serviceLandingScreen,
    builder: (context, state) {
      return UikServicesLanding(args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
  static final GoRoute _odOpHomeScreen = GoRoute(
    path: ScreenRoutes.odOpHomeScreen,
    builder: (context, state) {
      return UikOdOpScreen(args: state.extra as Map<String, dynamic>?).page;
    },
  );
  static final GoRoute _serviceScreen = GoRoute(
    path: ScreenRoutes.serviceScreen,
    builder: (context, state) {
      return UikServiceDetail(args: state.extra as Map<String, dynamic>?).page;
    },
  );
  static final GoRoute _samhitaLandingPage = GoRoute(
    path: ScreenRoutes.samhitaLandingPage,
    builder: (context, state) {
      return UikSamhitaHome(args: state.extra as Map<String, dynamic>?).page;
    },
  );

  // todo check route

  static final GoRoute _myAddressScreen = GoRoute(
    path: ScreenRoutes.addressBookScreen,
    builder: (context, state) {
      return UikMyAddressScreen(
        rootNavigatorKey.currentContext!,
        args: state.extra as Map<String, dynamic>?,
      ).page;
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
      return LokalPartnerLoginScreen(
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
      return UikCustomerForUserService(
              args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
  static final GoRoute _getAllAgentsForUserService = GoRoute(
    path: ScreenRoutes.getAllAgentsForUserService,
    builder: (context, state) {
      return UikAgentsForUserService(args: state.extra as Map<String, dynamic>?)
          .page;
    },
  );
}
