import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:login/Widgets/slider.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
// import './Widgets/mainfun.dart';
import 'Widgets/UikTabBar/tabBar.dart';
import 'Widgets/UikSearchBar/searchbar.dart';

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
              //settings: "hello",
              number: 4,
            ),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
