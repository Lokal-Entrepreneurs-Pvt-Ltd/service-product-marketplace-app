import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikAdminEcommCards/ProductCard.dart';
import 'package:login/widgets/UikAdminEcommCards/test.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikPagination/testpagination.dart';

import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import 'widgets/UikNavbar/UikNavbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => MyCard(),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
