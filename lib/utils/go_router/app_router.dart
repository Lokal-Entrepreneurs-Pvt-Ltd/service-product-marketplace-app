import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/Onboarding/NewOnboardingScreen.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/screens/WebViewScreen.dart';
import 'package:lokal/screens/partnerTraining/PartnerTrainingHome.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';

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
}
