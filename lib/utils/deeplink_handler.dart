import 'package:flutter/material.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/lokal_events.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'storage/product_data_handler.dart';

abstract class DeeplinkHandler {
  static void openPage(BuildContext context, String url) async {
    //https://localee.co.in/routName?args1=10&arg2=20
    print("__________________url____________________");
    print(url);
    Map<String, dynamic>? args = {};
    String route = "";
    try {
      int index = url.indexOf("://");
      String string = url.substring(index + 3);
      List<String> strList = string.split(RegExp(r'[/|?|&]'));
      route = "/${strList[1]}";
      for (int i = 2; i < strList.length; i++) {
        List<String> keyValuePair = strList[i].split("=");
        args[keyValuePair[0]] = keyValuePair[1];
      }
    } catch (e) {
      print(e);
    }

    print(route);
    if (args["cartId"] == "") args["cartId"] = null;
    print(args);
    LokalEvents.logEvent('open_page_event', {'url': url});

    // /checkout
    switch (route) {
      case ScreenRoutes.homeScreen:
        {
          _pushScreen(context, ScreenRoutes.homeScreen, args);
        }
        break;
      case ScreenRoutes.loginScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, ScreenRoutes.loginScreen);
          }
        }
        break;
      case ScreenRoutes.homeScreen:
        {
          if (args.isEmpty) {
            _pushScreen(context, ScreenRoutes.homeScreen);
          }
        }
        break;
      case ScreenRoutes.catalogueScreen:
        {
          if (args["categoryId"] != null) {
            _pushScreen(context, ScreenRoutes.catalogueScreen, args);
          }
        }
        break;
      case ScreenRoutes.searchScreen:
        {
          _pushScreen(context, ScreenRoutes.searchScreen, args);
        }
        break;
      case ScreenRoutes.productScreen:
        {
          if (args["skuId"] != null) {
            ProductDataHandler.saveProductSkuId(args['skuId']);
            _pushScreen(context, ScreenRoutes.productScreen, args);
          }
        }
        break;
      case ScreenRoutes.serviceScreen:
        {
          if (args["serviceId"] != null) {
            ProductDataHandler.saveProductSkuId(args['serviceId']);
            ProductDataHandler.saveServiceCode(args['serviceCode']);
            args["serviceId"] = int.parse(args["serviceId"]);
            _pushScreen(context, ScreenRoutes.serviceScreen, args);
          }
        }
        break;
      case ScreenRoutes.cartScreen:
        {
          String cartId = await CartDataHandler.getCartId();
          args = {"cartId": cartId};
          _pushScreen(context, ScreenRoutes.cartScreen, args);
        }
        break;

      case ScreenRoutes.addressBookScreen:
        {
          _pushScreen(context, ScreenRoutes.addressBookScreen, args);
        }
        break;

      case ScreenRoutes.couponScreen:
        {
          _pushScreen(context, ScreenRoutes.couponScreen, args);
        }
        break;
      case ScreenRoutes.isp:
        {
          _pushScreen(context, ScreenRoutes.ispHome, args);
        }
        break;
      case ScreenRoutes.membershipLanding:
        {
          _pushScreen(context, ScreenRoutes.membershipLanding, args);
        }
        break;

      case ScreenRoutes.paymentDetailsScreen:
        {
          _pushScreen(context, ScreenRoutes.paymentDetailsScreen, args);
        }
        break;
      case ScreenRoutes.orderScreen:
        {
          _pushScreen(context, ScreenRoutes.orderScreen, args);
        }
        break;

      case ScreenRoutes.orderScreen:
        {
          _pushScreen(context, ScreenRoutes.orderScreen, args);
        }
        break;
      case ScreenRoutes.orderHistoryScreen:
        {
          _pushScreen(context, ScreenRoutes.orderHistoryScreen, args);
        }
        break;
      case ScreenRoutes.myDetailsScreen:
        {
          _pushScreen(context, ScreenRoutes.myDetailsScreen, args);
        }
        break;
      case ScreenRoutes.myAddressScreen:
        {
          _pushScreen(context, ScreenRoutes.myAddressScreen, args);
        }
        break;

      case ScreenRoutes.myAccountScreen:
        {
          _pushScreen(context, ScreenRoutes.myAccountScreen, args);
        }
        break;
      case ScreenRoutes.signUpScreen:
        {
          _pushScreen(context, ScreenRoutes.signUpScreen, args);
        }
        break;
      case ScreenRoutes.otpScreen:
        {
          _pushScreen(context, ScreenRoutes.otpScreen, args);
        }
        break;
      case ScreenRoutes.addAddressScreen:
        {
          _pushScreen(context, ScreenRoutes.addAddressScreen, args);
        }
        break;
      case ScreenRoutes.myGames:
        {
          _pushScreen(context, ScreenRoutes.myGames, args);
        }
        break;
      case ScreenRoutes.serviceLandingScreen:
        {
          _pushScreen(context, ScreenRoutes.serviceLandingScreen, args);
        }
        break;
      case ScreenRoutes.samhitaDataCollector:
        {
          _pushScreen(context, ScreenRoutes.samhitaDataCollector, args);
        }
        break;
      case ScreenRoutes.samhitaLandingPage:
        {
          _pushScreen(context, ScreenRoutes.samhitaLandingPage, args);
        }
        break;
      case ScreenRoutes.samhitaAddParticipantForm:
        {
          _pushScreen(context, ScreenRoutes.samhitaAddParticipantForm, args);
        }
        break;
      case ScreenRoutes.samhitaBecomeParticipantForm:
        {
          _pushScreen(context, ScreenRoutes.samhitaBecomeParticipantForm, args);
        }
        break;
      case ScreenRoutes.samhitaVerifyParticipantForm:
        {
          _pushScreen(context, ScreenRoutes.samhitaVerifyParticipantForm, args);
        }
        break;
      case ScreenRoutes.samhitaOtp:
        {
          _pushScreen(context, ScreenRoutes.samhitaOtp, args);
        }
        break;
      case ScreenRoutes.addAgentScreen:
        {
          _pushScreen(context, ScreenRoutes.addAgentScreen, args);
        }
        break;
      case ScreenRoutes.manageAgentScreen:
        {
          _pushScreen(context, ScreenRoutes.manageAgentScreen, args);
        }
        break;
      case ScreenRoutes.addAgentOtpScreen:
        {
          _pushScreen(context, ScreenRoutes.addAgentOtpScreen, args);
        }
        break;
      case ScreenRoutes.extraPayOptInScreen:
        {
          _pushScreen(context, ScreenRoutes.extraPayOptInScreen, args);
        }
        break;
      case ScreenRoutes.myRewardsPage:
        {
          _pushScreen(context, ScreenRoutes.myRewardsPage, args);
        }
        break;
      case ScreenRoutes.addServiceCustomer:
        {
          _pushScreen(context, ScreenRoutes.addServiceCustomer, args);
        }
        break;
      default:
        launchUrl(Uri.parse(url));
    }
  }

  static void _pushScreen(BuildContext context, String route,
      [Map<String, dynamic>? args]) {
    print("pushed route ${route}");
    print("pushed args ${args}");
    Navigator.pushNamed(context, route, arguments: args);
  }
}
