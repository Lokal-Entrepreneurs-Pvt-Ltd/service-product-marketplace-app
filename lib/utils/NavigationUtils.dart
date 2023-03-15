import 'package:ui_sdk/props/UikAction.dart';
import '../main.dart';
import 'deeplink_handler.dart';

abstract class NavigationUtils {
  static void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  print(
      "_____________________________Catalogue call___________________________");
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
 }
}