import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login/pages/splash.dart';
//import 'package:login/Splash.dart';
//import 'package:login/Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';
import 'package:login/screens/Membership/MembershipScreen.dart';
import 'package:login/screens/Onboarding/OnboardingScreen.dart';
import 'package:login/screens/Order/MyOrder.dart';
import 'package:login/screens/RegisterScreen/RegisterScreen.dart';
import 'package:login/screens/RegistrationTwoScreen/RegistrationTwoScreen.dart';
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
 import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'widgets/UikOtp/otpui.dart';
import "./widgets/UikSlidder/slidder.dart";
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/models/emptySdkObject.dart';
 import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:ui_sdk/utils/pubsub/localpubsub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'convertorFunctions/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) =>OnboardingScreen(),
        MyRoutes.otp: ((context) => Otp()),
        MyRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}

class HomePage extends StandardPage {
  @override
  Future<StandardScreenResponse> getData() {
    return fetchAlbum();
  }

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }
}

Future<StandardScreenResponse> fetchAlbum() async {

  final queryParameter = {
   "id" : "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  final response = await http.get(
    Uri.parse(
        'https://demo3348922.mockable.io/test123'),
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
  }
}