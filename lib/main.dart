import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import './Components/mainfun.dart';
import './Components/tabBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => MyTabBar(
              shopping: "hello",
              favorite: "hello",
              notification: "hello",
              identity: "hello",
              settings: "hello",
              number: 5,
            ),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
