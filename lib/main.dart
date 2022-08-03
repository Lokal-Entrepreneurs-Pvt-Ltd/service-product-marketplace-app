import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/screens/Order/MyOrder.dart';
import 'package:login/widgets/UikAdminEcommCards/ProductCard.dart';
import 'package:login/widgets/UikAdminEcommCards/test.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikPagination/testpagination.dart';

import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import 'widgets/UikNavbar/UikNavbar.dart';
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
import 'package:login/widgets/UikInput/UikInput.dart';
import 'package:login/widgets/UikListItems/help.dart';
import 'package:login/widgets/UikListItems/onHover.dart';
//import 'package:login/widgets/UikMyOrder/MyOrder.dart';
import 'package:login/widgets/UikSignInModule/signin.dart';
import 'package:login/widgets/UikSlidder/slidder.dart';

import 'package:login/widgets/UikSnackbar/snackbar.dart';
import 'package:login/widgets/UikUserManagement/NewUserInfo.dart';
import 'package:login/widgets/UikUserManagement/ProfileCard.dart';
import 'package:login/widgets/UikUserManagement/UserCard.dart';
import 'package:login/widgets/UikUserManagement/UserCardHeader.dart';
import 'package:login/widgets/UikUserManagement/NewUserCard.dart';
import 'package:login/widgets/UikUserManagement/UserListCard.dart';
import 'package:login/widgets/UikiIcon/icon.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';
import "./utils/routes.dart";
import './pages/login.dart';
import './pages/otp.dart';
import "./widgets/UikSnackbar/snack.dart";
import "./widgets/UikChips/chips.dart";
import 'Widgets/UikAvatar/UikAvatar.dart';
import 'Widgets/UikAvatar/avatar.dart';
import 'Widgets/UikCardComponents/UikChatCard/ChatBubble.dart';
import 'Widgets/UikCardComponents/UikMyAccountCard/MyAccountCard.dart';
import 'Widgets/UikCardComponents/UikMyAccountCard/UikProfileCard/MyProfileCard.dart';
import 'Widgets/UikSearchBar/searchbar.dart';
import 'Widgets/UikSelect/select.dart';
import 'Widgets/UikTabBar/tabBar.dart';
import 'Widgets/UikToolTip/myapp.dart';
import 'Widgets/UikToolTip/toolTip.dart';
import 'widgets/UikActionSheet/ActionSheet.dart';
import 'widgets/UikActionSheet/ActionSheetUtil.dart';
import 'widgets/UikChips/chipsUtil.dart';
import 'widgets/UikRadioButton/radio.dart';
import "./widgets/test.dart";
// import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'widgets/UikOtp/otpui.dart';
import "./widgets/UikSlidder/slidder.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Avatar(),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}
