import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login/components/UikSnackbar/snackbar.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import "./components/UikSnackbar/snack.dart";
import "./components/UikChips/chips.dart";
import 'components/UikActionSheet/ActionSheet.dart';
import 'components/UikActionSheet/ActionSheetUtil.dart';
import 'components/UikChips/chipsUtil.dart';
import 'components/UikRadioButton/radio.dart';
import "./components/test.dart";
import 'components/UikOtp/otpui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => OtpUi(),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
