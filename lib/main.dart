import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:login/pages/UikComponentDisplayer.dart';
// import 'package:login/Splash.dart';
// import 'package:login/Widgets/UikCell/UikCell.dartimport 'package:login/widgets/UikAvatar/uikAvatar.dart';';
// import 'package:login/Widgets/UikIcon/uikIcon.dart';
import 'package:login/pages/UikMyAccountScreen.dart';
// import 'package:login/Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';

import 'package:login/pages/splash.dart';
import 'package:login/screens/Filter/FilterScreen.dart';
//import 'package:login/Splash.dart';
//import 'package:login/Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';
import 'package:login/screens/Membership/MembershipScreen.dart';
import 'package:login/screens/Onboarding/OnboardingScreen.dart';
import 'package:login/screens/Order/MyOrder.dart';
import 'package:login/screens/RegisterScreen/RegisterScreen.dart';
import 'package:login/screens/RegistrationTwoScreen/RegistrationTwoScreen.dart';
import 'package:login/testing/fire.dart';
import 'package:login/testing/notificationController.dart';
import 'package:login/widgets/UikAdminEcommCards/ProductCard.dart';
import 'package:login/widgets/UikAdminEcommCards/test.dart';
// import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikPagination/testpagination.dart';
// import './Widgets/UikAvatar/uikAvatar.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';

import 'package:login/pages/UikBottomNavigationBar.dart';
import 'package:login/pages/UikCart.dart';
import 'package:login/pages/UikFilter.dart';
import 'package:login/pages/UikOrder.dart';
import 'package:login/screens/Dio/models/product_provider.dart';
import 'package:login/screens/Dio/view/try_dio.dart';
import 'package:login/screens/Location/location.dart';
import 'package:login/screens/Login/login.dart';
import 'package:login/screens/SharedPrefs/shared_prefs.dart';
import 'package:login/widgets/UikSignInModule/signin.dart';
import 'package:provider/provider.dart';

//import 'package:login/screens/Login/login.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
//import 'package:login/Splash.dart';
//import 'package:login/Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';


import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';

void main() async {
  AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
      onFcmTokenHandle: NotificationController.myFcmTokenHandle,
      onNativeTokenHandle: NotificationController.myNativeTokenHandle);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      '',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  checkNotificationPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);

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
        },
      ),
    );
  }
}

class HomePage extends StandardPage {
  @override
  Future<StandardScreenResponse> getData() {
    // return fetchAlbum();
    return null!;
  }

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }
}

/* Future<StandardScreenResponse> fetchAlbum() async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  /* final response = await http.get(
    Uri.parse('https://demo3348922.mockable.io/test123'),
    // Uri.parse('https://demo7099810.mockable.io/'),
    headers: {
      "ngrok-skip-browser-warning": "value",
      //"id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
      //"token" : "kPvSO_ItE-6Oun01yHlJ5VcUXapnGqCxAy3t6LWDmVw.eyJpbnN0YW5jZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2IiwiYXBwRGVmSWQiOiIyMmJlZjM0NS0zYzViLTRjMTgtYjc4Mi03NGQ0MDg1MTEyZmYiLCJtZXRhU2l0ZUlkIjoiZGQ2YjVjMDEtNWNlNC00ZTc1LWE1MmUtOWM0YmM1Zjc4ZjI2Iiwic2lnbkRhdGUiOiIyMDIyLTA5LTEyVDE0OjM1OjU2LjQwMloiLCJ1aWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgiLCJwZXJtaXNzaW9ucyI6Ik9XTkVSIiwiZGVtb01vZGUiOmZhbHNlLCJzaXRlT3duZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsInNpdGVNZW1iZXJJZCI6ImU2ZGI3NTAwLTlmNzUtNDA5NS04OWU0LTYxNWVjYjg5MWY3OCIsImV4cGlyYXRpb25EYXRlIjoiMjAyMi0wOS0xMlQxODozNTo1Ni40MDJaIiwibG9naW5BY2NvdW50SWQiOiJlNmRiNzUwMC05Zjc1LTQwOTUtODllNC02MTVlY2I4OTFmNzgifQ"
    },
  );

  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  } */

  final dio = Dio();

  dio.options.headers["ngrok-skip-browser-warning"] = "value";

  final client = StandardScreenClient(dio);

  return client.getResponse();
} */

/* 

{
  "isSuccess": true,
  "data": {
    "authToken": "12345"
  },
  "error": {
    "code": 1001,
    "message": "Some Internal Server Error Occurred"
  }
}

 */