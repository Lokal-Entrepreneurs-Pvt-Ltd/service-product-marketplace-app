import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokal/configs/env_utils.dart';
import 'package:lokal/configs/environment_data_handler.dart';
import 'package:lokal/constants/environment.dart';
import 'package:lokal/pages/UikAddAddressScreen.dart';
import 'package:lokal/pages/UikAddressBook.dart';
import 'package:lokal/pages/UikBtsLocationFeasibilityScreen.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/pages/UikMyGames.dart';
import 'package:lokal/pages/UikOrderHistoryScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikPaymentDetailsScreen.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/utils/AppInitializer.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import 'package:lokal/utils/storage/preference_util.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'configs/environment.dart';
import 'screen_routes.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/shared_prefs.dart';
import 'package:provider/provider.dart';

import 'screens/detailScreen/UikMyDetailsScreen.dart';
import 'package:shake/shake.dart';

var appInit;

void main() async {
  appInit = new AppInitializer();
  await appInit.init();

  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  String environment = String.fromEnvironment(
    ENVIRONMENT_KEY,
    defaultValue: EnvironmentDataHandler.getDefaultEnvironment(),
  );
  Environment().initConfig(environment);

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
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  //
  // print(fcmToken);
  //
  // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  //   fcmToken = fcmToken;
  //   print(fcmToken);
  // }).onError((err) {
  //   print("error");
  //   throw Exception(err);
  // });

  // SharedPreferences.getInstance().then((instance) {
  //   StorageService().sharedPreferencesInstance = instance; // Storage service is a service to manage all shared preferences stuff. I keep the instance there and access it whenever i wanted.
  //   runApp(MyApp());
  // });

  runApp(MaterialApp(home: LokalApp()));
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
     detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        // Do stuff on phone shake
        if(kDebugMode)
          displayTextInputDialog(context);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    //AppInitializer.initDynamicLinks(context, FirebaseDynamicLinks.instance);

    /*
      // Postman -> Headers
      Authorization - key=<Server Key>
      Content-Type - application/json

      // Postman -> Body -> RAW -> JSON
      {
        "to" : "dRuG1cAsR6ife4qFF_rA2w:APA91bGY4qI-Pv1-DWQIRsBMou6pwL9OXtzOmKSKcbAq82Tr6Xdk5I4vyTCechYS4NqbCF8qkeb2YC-j1GhjXMXlrJaaBbwCWjup5aIQKproS4B49Zzrte4HCW1ZhwoMxeNQpqH23N7g",
        "notification" : {
            "title": "Login Screen",
            "body" : "Login Screen"
        },
        "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "link": "https://localee.page.link/loginscreen"
        }
      }
     */

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   // print(message.data["link"]);
    //
    //   DeeplinkHandler.openPage(
    //       NavigationService.navigatorKey.currentContext!, message.data["link"]);
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detector.stopListening();
  }



   displayTextInputDialog(BuildContext context) async {
    var tempLocalUrl=EnvironmentDataHandler.getLocalBaseUrl();
    return showDialog(
        context: context,
        builder: (context) {
          var _textFieldController = TextEditingController(text: EnvironmentDataHandler.getLocalBaseUrl());
          return AlertDialog(
            title: Text('Set Ngrok URL'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempLocalUrl = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration( hintText: "Enter the local url"),
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
                    EnvUtils.setEnvironmentAndResetApp(context,Environment.PROD,"");
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Set Dev'),
                onPressed: () {
                  setState(() {
                    EnvUtils.setEnvironmentAndResetApp(context, Environment.DEV,"");
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Set Lokal'),
                onPressed: () {
                  setState(() {
                    if(tempLocalUrl.isNotEmpty && tempLocalUrl.endsWith("ngrok.io"))
                    {
                      EnvUtils.setEnvironmentAndResetApp(context,Environment.LOCAL,tempLocalUrl);
                    }
                    else
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
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        routes: {
          // "/": (context) => success(),
          //   "/": (context) => UikOrderHistoryScreen().page,
          // "/": (context) => LoginPageScreen(),
          //  "/": (context) => UikAddressBook().page,

          // "/": (context) => UikHome().page,


          "/": (context) => UserDataHandler.getUserToken().isEmpty ?  OnboardingScreen() : UikBottomNavigationBar(),
        //  "/": (context) => UikPaymentDetailsScreen().page,

       //   "/": (context) => UserDataHandler.getUserToken().isEmpty
            //  ? OnboardingScreen()
        ///      : UikBottomNavigationBar(),
         // "/": (context) => UikBtsLocationFeasibilityScreen().page,

          ScreenRoutes.homeScreen: (context) => const UikHomeWrapper(),
          ScreenRoutes.catalogueScreen: (context) => UikCatalogScreen().page,
          ScreenRoutes.productScreen: (context) => UikProductPage().page,
          ScreenRoutes.cartScreen: (context) => UikCartScreen().page,
          ScreenRoutes.addressBookScreen: (context) => UikAddressBook().page,
          ScreenRoutes.myAccountScreen: (context) => UikMyAccountScreen().page,
          ScreenRoutes.myDetailsScreen: (context) => const MyDetailsScreen(),
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
          // "/": (context) => UikServiceScreen().page,
          //    ScreenRoutes.searchScreen: (context) => UikSearchCatalog().page,
          // MyApiRoutes.searchScreen: (context) => UikSearchCatalog().page,
          // MyApiRoutes.orderScreen: (context) => UikOrderScreen().page,
          // MyApiRoutes.emptyCartScreen: (context) => UikEmptyCartScreen().page,
          // MyApiRoutes.forgetPassword: (context) => const ForgetPasswordScreen(),
          // MyApiRoutes.couponScreen: (context) => UikCouponScreen().page,

          // MyApiRoutes.addAddressScreen: (context) => UikAddAddressScreen().page,
          // MyApiRoutes.paymentDetailsScreen: (context) =>
          //     UikPaymentDetailsScreen().page,
          // MyApiRoutes.paymentStatusScreen: (context) => OrderSuccessScreen()
        },
      ),
    );
  }
}
