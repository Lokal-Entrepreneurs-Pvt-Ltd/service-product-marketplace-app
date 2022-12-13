
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
    // TODO: implement getFunction
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return UikHome;
  }
}

// Future<StandardScreenResponse> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse('http://demo6521867.mockable.io/newHomeScreen'),
//     headers: {
//       "ngrok-skip-browser-warning": "value",
//     },
//   );
//
//   // StandardScreenResponse
//   if (response.statusCode == 200) {
//     return StandardScreenResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
