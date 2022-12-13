import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lokal/deeplink_handler.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';

import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:lokal/utils/crashlytics.dart';
import 'package:lokal/utils/AppInitializer.dart';
import 'package:lokal/utils/Dio/models/product_provider.dart';
import 'package:ui_sdk/main.dart';
import 'package:lokal/utils/AppInitializer.dart';

import 'routes.dart';
import 'screens/login.dart';
import 'screens/otp.dart';

import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/pages/UikCart.dart';
import 'package:lokal/pages/UikFilter.dart';
import 'package:lokal/pages/UikOrder.dart';
import 'package:lokal/storage/shared_prefs.dart';
import 'package:provider/provider.dart';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';

import 'routes.dart';
import 'screens/login.dart';
import 'screens/otp.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/UikCatalogScreen.dart';

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

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    fcmToken = fcmToken;
    print(fcmToken);
  }).onError((err) {
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
  bool _isCreatingLink = false;

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

      DeeplinkHandler.openDeeplink(
          NavigationService.navigatorKey.currentContext!, message.data["link"]);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProuctProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        routes: {
          "/": (context) => UikBottomNavigationBar(),
          MyRoutes.loginScreen: (context) => LoginPage(),
          MyRoutes.homeScreen: (context) => UikHome().page,
          MyRoutes.catalogueScreen: (context) => UikCatalogScreen().page,
          MyRoutes.productScreen: (context) => UikProductPage().page,
          MyRoutes.searchCatalogueScreen: (context) => UikSearchCatalog().page,
          MyRoutes.orderScreen: (context) => UikOrder().page,
          MyRoutes.filterScreen: (context) => UikFilter().page,
          MyRoutes.cartScreen: (context) => UikCart().page,
        },
      ),
    );
  }
}

class HomePage extends StandardPage {
  @override
  Future<StandardScreenResponse> getData() {
    return null!;
  }

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  getPageCallBackForAction() {
    // TODO: implement getPageCallBackForAction
    return of;
  }

  void of() {}

  @override
  getPageContext() {
    // TODO: implement getPageContext
    return HomePage;
  }
}

