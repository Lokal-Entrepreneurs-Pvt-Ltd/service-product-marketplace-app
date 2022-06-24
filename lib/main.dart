import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/components/UikAvatar/uikAvatar.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import './components/UikiIcon/icon.dart';
import 'components/UikAvatar/avatar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: {
        "/": (context) => Icone(),
        MyRoutes.otp:((context) => Otp()),
        MyRoutes.loginRoute:(context) => LoginPage()
      },
    );

   
  }
}