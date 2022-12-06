
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

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

import 'firebase_options.dart';

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
    AppInitializer.initDynamicLinks( context,FirebaseDynamicLinks.instance);
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
          // "/": (context) => const LoginPageScreen(),
          MyRoutes.otp: (context) => Otp(),
          MyRoutes.loginRoute: (context) => LoginPage(),
          MyRoutes.homeRoute: (context) => UikComponentDisplayer().page,
          MyRoutes.filterRoute: (context) => UikFilter().page,
          MyRoutes.cartRoute: (context) => UikCart().page,
          MyRoutes.orderRoute: (context) => UikOrder().page,
          MyRoutes.productsCatalogue: (context) => UikProductPage().page,
          MyRoutes.homeRoute: (context) => UikHome().page,
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
  getFunction() {
    // TODO: implement getFunction
    throw UnimplementedError();
  }

  @override
  getReference() {
    // TODO: implement getReference
    throw UnimplementedError();
  }
}


