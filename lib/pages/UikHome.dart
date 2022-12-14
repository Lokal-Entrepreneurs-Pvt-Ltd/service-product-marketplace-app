
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../utils/network/retrofit/api_client.dart';

class UikHome extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    actionList.add("OPEN_ROUTE");
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    return ApiRepository.getHomescreen();
  }

  void onHomeScreenTapAction() {}

  @override
  getPageCallBackForAction() {
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return UikHome;
  }
}

