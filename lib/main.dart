import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Widgets/UikButton/UikButton.dart';
import 'package:login/Widgets/UikChips/chips.dart';
import 'package:login/Widgets/UikRadioButton/radio.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikSlidder/slidder.dart';

import 'package:login/widgets/UikSnackbar/snackbar.dart';
import 'package:login/widgets/UikiIcon/icon.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import "./widgets/UikSnackbar/snack.dart";
import "./widgets/UikChips/chips.dart";
import 'Widgets/UikSearchBar/searchbar.dart';
import 'Widgets/UikTabBar/tabBar.dart';
import 'Widgets/UikToolTip/myapp.dart';
import 'Widgets/UikToolTip/toolTip.dart';
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
        "/": (context) =>
            // Test(),
            ToolTip(
              ll: ["tooltip1", "tooltip2", "tooltip3", "tooltip4"],
              s: AxisDirection.up,
              taillength: 0,
              child: Container(child: MySearchBar()),
            ),

        //  MySearchBar(
        //       label: "Search",
        //     ),
        // MyTabBar(
        //   ll: [
        //     Icons.shopping_bag_outlined,
        //     Icons.favorite_border_outlined,
        //     Icons.notifications_none_rounded,
        //     Icons.perm_identity_rounded,
        //     Icons.settings_outlined,
        //   ],
        // ),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
