
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../utils/network/retrofit/api_client.dart';

class UikOrderHistoryScreen extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    actionList.add("OPEN_ROUTE");
    return actionList;
  }

  @override
  dynamic getData() {
    return ApiRepository.getOrderHistoryScreen;
  }

  void onOrderHistoryScrenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onOrderHistoryScrenTapAction;
  }

  @override
  getPageContext() {
    return UikOrderHistoryScreen;
  }
}
