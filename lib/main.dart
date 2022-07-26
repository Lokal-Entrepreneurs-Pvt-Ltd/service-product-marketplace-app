import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UIKGroupAvatar/groupAvatar.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikEcommerceCard/AddressCard.dart';
import 'package:login/widgets/UikEcommerceCard/CardDetailsCard.dart';
import 'package:login/widgets/UikEcommerceCard/CartCard.dart';
import 'package:login/widgets/UikEcommerceCard/CategoryCard.dart';
import 'package:login/widgets/UikEcommerceCard/OrderSummeryCard.dart';
import 'package:login/widgets/UikEcommerceCard/PaymentSuccesCard.dart';
import 'package:login/widgets/UikEcommerceCard/ProductCard.dart';
import 'package:login/widgets/UikEcommerceCard/ProductDetailsCard.dart';
import 'package:login/widgets/UikListItems/help.dart';
import 'package:login/widgets/UikListItems/onHover.dart';
import 'package:login/widgets/UikMyOrder/MyOrder.dart';
import 'package:login/widgets/UikSignInModule/signin.dart';
import 'package:login/widgets/UikSlidder/slidder.dart';

import 'package:login/widgets/UikSnackbar/snackbar.dart';
import 'package:login/widgets/UikTabs/tabs.dart';
import 'package:login/widgets/UikiIcon/icon.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';
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
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
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
        "/": (context) => MyOrder(),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
// const UikInput(
//               leftElement: UikIcon(valIcon: Icons.location_on_outlined),
//               rightElement: UikIcon(
//                 valIcon: Icons.close,
//               ),
//               labelText: "",
//               desText: "Description",
//             ),