

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokal/configs/appConfig/appConfigDataHandler.dart';
import 'package:lokal/configs/env_utils.dart';
import 'package:lokal/configs/environment_data_handler.dart';
import 'package:lokal/constants/environment.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/pages/UikAddAddressScreen.dart';
import 'package:lokal/pages/UikAddressBook.dart';
import 'package:lokal/pages/UikBtsLocationFeasibilityScreen.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikCouponScreen.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/pages/UikMyAddressScreen.dart';
import 'package:lokal/pages/UikMyGames.dart';
import 'package:lokal/pages/UikOdOpScreen.dart';
import 'package:lokal/pages/UikOrderHistoryScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikPaymentDetailsScreen.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:lokal/screens/Form/SamhitaOtp.dart';
import 'package:lokal/screens/Form/SamhitaVerifyParticipant.dart';
import 'package:lokal/screens/Form/extraPayOptin.dart';
import 'package:lokal/screens/addServiceCustomerFlow/addServiceCustomerFlow.dart';
import 'package:lokal/screens/agents/AddAgentScreen.dart';
import 'package:lokal/screens/agents/AddAgentOtpScreen.dart';
import 'package:lokal/screens/Onboarding/NewOnboardingScreen.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/screens/agents/manageAgentScreen.dart';
import 'package:lokal/screens/landing_screen/service_landing_screen.dart';
import 'package:lokal/screens/myRewards/myRewardPage.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/AppInitializer.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';

import 'package:lokal/utils/storage/preference_util.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'configs/environment.dart';
import 'pages/UikIspHome.dart';
import 'pages/UikMembershipScreen.dart';
import 'pages/UikSamhitaHome.dart';
import 'pages/UikServiceDetail.dart';
import 'pages/UikServicesLanding.dart';
import 'screen_routes.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'screens/Form/SamhitaBecomeParticipant.dart';
import 'screens/Form/SamhitaAddParticipants.dart';
import 'screens/Form/SamhitaDataCollector.dart';
import 'screens/Onboarding/LandingPage.dart';
import 'screens/detailScreen/UikMyDetailsScreen.dart';
import 'package:shake/shake.dart';
import 'package:feedback/feedback.dart';

AppInitializer? appInit;

void main() async {
  appInit = new AppInitializer();
  await appInit?.init();
  WidgetsFlutterBinding.ensureInitialized();
  final appConfigDataHandler = AppConfigDataHandler();
  await appConfigDataHandler.init();
  await PreferenceUtils.init();
  String environment = String.fromEnvironment(
    ENVIRONMENT_KEY,
    defaultValue: EnvironmentDataHandler.getDefaultEnvironment(),
  );
  Environment().initConfig(environment);

  runApp(BetterFeedback(
    child: LokalApp(),
  ));

  //
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  //
  final fcmToken = await FirebaseMessaging.instance.getToken();

  print(fcmToken);

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    fcmToken = fcmToken;
    print(fcmToken);
  }).onError((err) {
    print("error");
    throw Exception(err);
  });
  if (fcmToken!.isNotEmpty) saveFCMForUser(fcmToken);
}

Future<void> saveFCMForUser(String fcmToken) async {
      await ApiRepository.saveNotificationToken(
      ApiRequestBody.getNotificationAddUserDetailsRequest(fcmToken, FCM));
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class LokalApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  LokalApp({Key? key}) : super(key: key);

  @override
  State<LokalApp> createState() => _LokalAppState();
}

late ShakeDetector detector;

class _LokalAppState extends State<LokalApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    PreferenceUtils.setString("device_id", deviceId.toString());

    if (!mounted) return;
  }

  displayTextInputDialog(BuildContext context) async {
    var tempLocalUrl = EnvironmentDataHandler.getLocalBaseUrl();
    return showDialog(
        context: context,
        builder: (context) {
          var _textFieldController = TextEditingController(
              text: EnvironmentDataHandler.getLocalBaseUrl());
          return AlertDialog(
            title: Text('Set Ngrok URL'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempLocalUrl = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter the local url"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Clear Data and Kill App'),
                onPressed: () {
                  setState(() {
                    UiUtils.showToast("Data Cleared, Restart the app");
                    PreferenceUtils.clearStorage();
                    SystemNavigator.pop();
                  });
                },
              ),
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Set Prod'),
                onPressed: () {
                  setState(() {
                    EnvUtils.setEnvironmentAndResetApp(
                        context, Environment.PROD, "");
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Set Dev'),
                onPressed: () {
                  setState(() {
                    EnvUtils.setEnvironmentAndResetApp(
                        context, Environment.DEV, "");
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Set Lokal'),
                onPressed: () {
                  setState(() {
                    if (tempLocalUrl.isNotEmpty &&
                        tempLocalUrl.endsWith("ngrok.io")) {
                      EnvUtils.setEnvironmentAndResetApp(
                          context, Environment.LOCAL, tempLocalUrl);
                    } else
                      UiUtils.showToast("Invalid url");
                  });
                },
              ),
            ],
          );
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        // navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(fontFamily: 'Georgia'),
        routes: {
          "/": (context) {
            // return ServiceLandingScreen();
            return UserDataHandler.getUserToken().isEmpty
                ? OnboardingScreen()
                : UikBottomNavigationBar();
          },
          ScreenRoutes.serviceLandingPageNew: (context) => const ServiceLandingScreen(),
          ScreenRoutes.homeScreen: (context) => const UikHomeWrapper(),
          ScreenRoutes.catalogueScreen: (context) => UikCatalogScreen().page,
          ScreenRoutes.productScreen: (context) => UikProductPage().page,
          ScreenRoutes.cartScreen: (context) => UikCartScreen().page,
          ScreenRoutes.addressBookScreen: (context) => UikAddressBook().page,
          ScreenRoutes.myAccountScreen: (context) => UikMyAccountScreen().page,
          ScreenRoutes.myDetailsScreen: (context) => const MyDetailsScreen(),
          ScreenRoutes.myAddressScreen: (context) =>
              UikMyAddressScreen(context).page,
          ScreenRoutes.otpScreen: (context) => OtpScreen(),
          ScreenRoutes.paymentDetailsScreen: (context) =>
              UikPaymentDetailsScreen().page,
          ScreenRoutes.orderScreen: (context) => UikOrderScreen().page,
          ScreenRoutes.addAddressScreen: (context) =>
              UikAddAddressScreen().page,
          ScreenRoutes.orderHistoryScreen: (context) =>
              UikOrderHistoryScreen().page,
          ScreenRoutes.myGames: (context) => UikMyGames().page,
          ScreenRoutes.btsLocationFeasibility: (context) =>
              UikBtsLocationFeasibilityScreen().page,
          ScreenRoutes.ispHome: (context) => UikIspHome().page,
          ScreenRoutes.couponScreen: (context) => UikCouponScreen().page,
          ScreenRoutes.signUpScreen: (context) => const SignupScreen(),
          ScreenRoutes.membershipLanding: (context) =>
              UikMembershipScreen().page,
          ScreenRoutes.searchScreen: (context) => UikSearchCatalog().page,
          ScreenRoutes.serviceLandingScreen: (context) =>
              UikServicesLanding().page,
          ScreenRoutes.serviceScreen: (context) => UikServiceDetail().page,
          ScreenRoutes.samhitaDataCollector: (context) =>
              SamhitaDataCollector(),
          ScreenRoutes.samhitaLandingPage: (context) => UikSamhitaHome().page,
          ScreenRoutes.samhitaAddParticipantForm: (context) =>
              SamhitaAddParticipants(),
          ScreenRoutes.samhitaBecomeParticipantForm: (context) =>
              SamhitaBecomeParticipant(),
          ScreenRoutes.odOpHomeScreen: (context) => UikOdOpScreen().page,
          ScreenRoutes.samhitaOtp: (context) => SamhitaOtp(),
          ScreenRoutes.extraPayOptInScreen: (context) => extraPayOptIn(),
          ScreenRoutes.samhitaVerifyParticipantForm: (context) =>
              SamhitaVerifyParticipant(),
          ScreenRoutes.extraPayOptInScreen: (context) => extraPayOptIn(),
          ScreenRoutes.addAgentScreen: (context) => AddAgentScreen(),
          ScreenRoutes.manageAgentScreen: (context) => ManageAgentScreen().page,
          ScreenRoutes.addAgentOtpScreen: (context) => AddAgentOtpScreen(),
          ScreenRoutes.newOnboardingScreen: (context) => NewOnboardingScreen(),
          ScreenRoutes.myRewardsPage: (context) => MyRewardPage(),
          ScreenRoutes.addUserServiceCustomer: (context) =>
              addUserServiceCustomer()
          ScreenRoutes.addUserServiceCustomer: (context) => AddServiceCustomerFlow()

        },
      ),
    );
  }
}
