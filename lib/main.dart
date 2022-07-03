import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikSlidder/slidder.dart';

import 'package:login/widgets/UikSnackbar/snackbar.dart';
import 'package:login/widgets/UikiIcon/icon.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import "./widgets/UikSnackbar/snack.dart";
import "./widgets/UikChips/chips.dart";
import 'widgets/UikActionSheet/ActionSheet.dart';
import 'widgets/UikActionSheet/ActionSheetUtil.dart';
import 'widgets/UikChips/chipsUtil.dart';
import 'widgets/UikRadioButton/radio.dart';
import "./widgets/test.dart";
import 'widgets/UikOtp/otpui.dart';
import "./widgets/UikSlidder/slidder.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => Slidder(isRange: true),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
