import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lokal/pages/UikAddressBook.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';
import 'package:lokal/pages/UikCouponScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/screens/forgetPassword/ForgetPassword.dart';
import 'package:lokal/screens/setNewPassword/set_new_password_screen.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:lokal/utils/AppInitializer.dart';
//import 'package:lokal/utils/dio/models/product_provider.dart';
import 'routes.dart';
import 'screens/Onboarding/OnboardingScreen.dart';
import 'screens/login.dart';

import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/pages/UikFilter.dart';
import 'package:lokal/pages/UikOrder.dart';
import 'package:lokal/utils/storage/shared_prefs.dart';
import 'package:provider/provider.dart';

var appInit;

void main() async {
  appInit = new AppInitializer();
  await appInit.init();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final fcmToken = await FirebaseMessaging.instance.getToken();

  print(fcmToken);

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    fcmToken = fcmToken;
    print(fcmToken);
  }).onError((err) {
    print("error");
    throw Exception(err);
  });

  runApp(LokalApp());
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

class _LokalAppState extends State<LokalApp> {
  @override
  void initState() {
    super.initState();

    AppInitializer.initDynamicLinks(context, FirebaseDynamicLinks.instance);

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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print(message.data["link"]);

      DeeplinkHandler.openPage(
          NavigationService.navigatorKey.currentContext!, message.data["link"]);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          // "/": (context) => UikBottomNavigationBar(),
          //  "/": (context) => UikAddressBook().page,

          "/": (context) => UikCatalogScreen().page,

          // "/": (context) => const SetNewPasswordScreen(),

          MyRoutes.homeScreen: (context) => const UikHomeWrapper(),
          MyRoutes.cartScreen: (context) => UikCartScreen().page,
          MyRoutes.loginScreen: (context) => LoginPage(),
          MyRoutes.homeScreen: (context) => UikHome().page,
          MyRoutes.myAccountScreen: (context) => UikMyAccountScreen().page,
          MyRoutes.catalogueScreen: (context) => UikCatalogScreen().page,
          MyRoutes.productScreen: (context) => UikProductPage().page,
          MyRoutes.searchScreen: (context) => UikSearchCatalog().page,
          MyRoutes.orderScreen: (context) => UikOrder().page,
          MyRoutes.emptyCartScreen: (context) => UikEmptyCartScreen().page,
          MyRoutes.forgetPassword: (context) => const ForgetPasswordScreen(),
          MyRoutes.addressBook: (context) => UikAddressBook().page,
          MyRoutes.couponScreen: (context) => UikCouponScreen().page,
          MyRoutes.signUpScreen: (context) => const SignupScreen(),
          MyRoutes.otpScreen: (context) => const OtpScreen(),
          MyRoutes.setNewPasswordScreen: (context) =>
              const SetNewPasswordScreen(),
        },
      ),
    );
  }
}
