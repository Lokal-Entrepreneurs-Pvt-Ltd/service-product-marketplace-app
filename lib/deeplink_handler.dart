import 'package:flutter/material.dart';
import 'package:lokal/utils/routes.dart';

abstract class DeeplinkHandler {
  // https://localee.page.link/homescreen
  // Iterate
  static void homeScreenHandler(BuildContext context, String url) {
    final baseUrl = url.substring(0, 27);

    final host = url.substring(26);

    if (host == MyRoutes.homeScreen) {
      Navigator.pushNamed(context, host);
    } else {
      // TODO: Launch https://localee.co.in
    }
  }

  static void productsCatalogueScreenHandler(BuildContext context, String url) {
    final baseUrl = url.substring(0, 27);

    final host = url.substring(27);

    if (host == MyRoutes.productsCatalogueScreen) {
      Navigator.pushNamed(context, host);
    } else {
      // TODO: Launch https://localee.co.in
    }
  }

  static void searchProductsCatalogueScreenHandler(
      BuildContext context, String url) {
    final baseUrl = url.substring(0, 27);

    final host = url.substring(27);

    if (host == MyRoutes.searchCatalogueScreen) {
      Navigator.pushNamed(context, host);
    } else {
      // TODO: Launch https://localee.co.in
    }
  }

  static void productScreenHandler(BuildContext context, String url) {
    // https://www.localee.co.in/productScreen?categoryId=190
    final baseUrl = url.substring(0, 27);

    final host = url.substring(27, 40);
  }
}
