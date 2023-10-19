import 'package:feedback/feedback.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokal/configs/env_utils.dart';
import 'package:lokal/configs/environment_data_handler.dart';
import 'package:lokal/constants/environment.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/AppInitializer.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/preference_util.dart';
import 'package:lokal/utils/storage/shared_prefs.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

import 'configs/environment.dart';

AppInitializer? appInit;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  appInit = AppInitializer();
  await appInit?.init();
  WidgetsFlutterBinding.ensureInitialized();
  // final appConfigDataHandler = AppConfigDataHandler();
  // await appConfigDataHandler.init();
  await PreferenceUtils.init();
  String environment = String.fromEnvironment(
    ENVIRONMENT_KEY,
    defaultValue: EnvironmentDataHandler.getDefaultEnvironment(),
  );
  Environment().initConfig(environment);

  runApp(const BetterFeedback(
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

  const LokalApp({Key? key}) : super(key: key);

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
          var textFieldController = TextEditingController(
              text: EnvironmentDataHandler.getLocalBaseUrl());
          return AlertDialog(
            title: const Text('Set Ngrok URL'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempLocalUrl = value;
                });
              },
              controller: textFieldController,
              decoration:
                  const InputDecoration(hintText: "Enter the local url"),
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
                child: const Text('Set Lokal'),
                onPressed: () {
                  setState(() {
                    if (tempLocalUrl.isNotEmpty &&
                        tempLocalUrl.endsWith("ngrok.io")) {
                      EnvUtils.setEnvironmentAndResetApp(
                          context, Environment.LOCAL, tempLocalUrl);
                    } else {
                      UiUtils.showToast("Invalid url");
                    }
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
    final router = AppRoutes().router;
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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        // navigatorKey: NavigationService.navigatorKey,
        // navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(fontFamily: 'Georgia'),
        // routes: {
        //   "/": (context) {
        //     //return const LocationScreen();
        //     return UserDataHandler.getUserToken().isEmpty
        //         ? const OnboardingScreen()
        //         : const UikBottomNavigationBar();
        //   },
        //   ScreenRoutes.userServiceTabsScreen: (context) =>
        //       const ServiceLandingScreen(),
        //   ScreenRoutes.homeScreen: (context) => const UikHomeWrapper(),
        //   ScreenRoutes.catalogueScreen: (context) => UikCatalogScreen().page,
        //   ScreenRoutes.productScreen: (context) => UikProductPage().page,
        //   ScreenRoutes.cartScreen: (context) => UikCartScreen().page,
        //   ScreenRoutes.addressBookScreen: (context) => UikAddressBook().page,
        //   ScreenRoutes.myAccountScreen: (context) => UikMyAccountScreen().page,
        //   ScreenRoutes.myDetailsScreen: (context) => const MyDetailsScreen(),
        //   ScreenRoutes.myAddressScreen: (context) =>
        //       UikMyAddressScreen(context).page,
        //   ScreenRoutes.otpScreen: (context) => const OtpScreen(),
        //   ScreenRoutes.paymentDetailsScreen: (context) =>
        //       UikPaymentDetailsScreen().page,
        //   ScreenRoutes.orderScreen: (context) => UikOrderScreen().page,
        //   ScreenRoutes.addAddressScreen: (context) =>
        //       UikAddAddressScreen().page,
        //   ScreenRoutes.orderHistoryScreen: (context) =>
        //       UikOrderHistoryScreen().page,
        //   ScreenRoutes.myGames: (context) => UikMyGames().page,
        //   // ScreenRoutes.btsLocationFeasibility: (context) =>
        //   //     UikBtsLocationFeasibilityScreen().page,
        //   ScreenRoutes.ispHome: (context) => UikIspHome().page,
        //   ScreenRoutes.couponScreen: (context) => UikCouponScreen().page,
        //   ScreenRoutes.signUpScreen: (context) => const SignupScreen(),
        //   ScreenRoutes.membershipLanding: (context) =>
        //       UikMembershipScreen().page,
        //   ScreenRoutes.searchScreen: (context) => UikSearchCatalog().page,
        //   ScreenRoutes.serviceLandingScreen: (context) =>
        //       UikServicesLanding().page,
        //   ScreenRoutes.serviceScreen: (context) => UikServiceDetail().page,
        //   ScreenRoutes.samhitaDataCollector: (context) =>
        //       const SamhitaDataCollector(),
        //   ScreenRoutes.samhitaLandingPage: (context) => UikSamhitaHome().page,
        //   ScreenRoutes.samhitaAddParticipantForm: (context) =>
        //       const SamhitaAddParticipants(),
        //   ScreenRoutes.samhitaBecomeParticipantForm: (context) =>
        //       const SamhitaBecomeParticipant(),
        //   ScreenRoutes.odOpHomeScreen: (context) => UikOdOpScreen().page,
        //   ScreenRoutes.samhitaOtp: (context) => const SamhitaOtp(),
        //   ScreenRoutes.extraPayOptInScreen: (context) => const extraPayOptIn(),
        //   ScreenRoutes.samhitaVerifyParticipantForm: (context) =>
        //       const SamhitaVerifyParticipant(),
        //   ScreenRoutes.addAgentScreen: (context) => const AddAgentScreen(),
        //   ScreenRoutes.manageAgentScreen: (context) => ManageAgentScreen().page,
        //   ScreenRoutes.addAgentOtpScreen: (context) => const AddAgentOtpScreen(),
        //   ScreenRoutes.newOnboardingScreen: (context) => const LoginScreen(),
        //   ScreenRoutes.myRewardsPage: (context) => const MyRewardPage(),
        //   ScreenRoutes.addUserServiceCustomer: (context) =>
        //       const AddServiceCustomerFlow(),
        //   ScreenRoutes.getAllCustomerForUserService: (context) =>
        //       UikCustomerForUserService().page,
        //   ScreenRoutes.getAllAgentsForUserService: (context) =>
        //       UikAgentsForUserService().page,
        //   ScreenRoutes.apiCallerScreen: (context) => const ApiCallerScreen(),
        //   ScreenRoutes.notifyAgentsScreen: (context) => NotifyAgentsScreen(),
        //   ScreenRoutes.partnerTrainingHome: (context) => const PartnerTrainingHomeScreen(),
        //   ScreenRoutes.webScreenView: (context) =>  WebViewScreen(),
        //   ScreenRoutes.myAgentListScreen: (context) =>  MyAgentListScreen(),
        // },
      ),
    );
  }
}
