import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';

import 'package:lokal/pages/UikComponentDisplayer.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/utils/AppInitializer.dart';

import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';

import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/pages/UikCart.dart';
import 'package:lokal/pages/UikFilter.dart';
import 'package:lokal/pages/UikOrder.dart';
import 'package:lokal/screens/Dio/models/product_provider.dart';
import 'package:lokal/screens/SharedPrefs/shared_prefs.dart';
import 'package:provider/provider.dart';

import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';

import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(LokalApp());
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
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProuctProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => UikBottomNavigationBar(),
          MyRoutes.otp: (context) => Otp(),
          MyRoutes.loginScreen: (context) => LoginPage(),
          // MyRoutes.homeScreen: (context) => UikComponentDisplayer().page,
          MyRoutes.filterScreen: (context) => UikFilter().page,
          MyRoutes.cartScreen: (context) => UikCart().page,
          MyRoutes.orderScreen: (context) => UikOrder().page,
          // MyRoutes.productsCatalogueScreen: (context) => UikProductPage().page,
          MyRoutes.productsCatalogueScreen: (context) =>
              UikCatalogScreen().page,
          MyRoutes.homeScreen: (context) => UikHome().page,
          MyRoutes.productScreen: (context) => UikProductPage().page,
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
