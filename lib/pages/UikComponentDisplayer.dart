// import 'package:dio/dio.dart';
// import 'package:lokal/pages/UikCatalogScreen.dart';
// import 'package:ui_sdk/StandardPage.dart';
// import 'package:ui_sdk/props/ApiResponse.dart';
// import 'package:ui_sdk/props/StandardScreenResponse.dart';
// import 'package:dio/dio.dart';
// import '../actions.dart';
//
// class UikComponentDisplayer extends StandardPage {
//   @override
//   Set<String?> getActions() {
//     Set<String?> actionList = Set();
//     actionList.add(UIK_ACTION.OPEN_WEB);
//     actionList.add(UIK_ACTION.OPEN_HALA);
//     return actionList;
//   }
//
//   @override
//   Future<ApiResponse> getData() {
//     return StandardScreenClient(
//             Dio(BaseOptions(contentType: "application/json")))
//         .getHomeScreen("");
//   }
//
//   @override
//   getPageCallBackForAction() {
//     return of;
//   }
//
//   void of() {}
//
//   @override
//   getPageContext() {
//     return UikComponentDisplayer;
//   }
// }
//
// Future<StandardScreenResponse> getMockedApiResponse() async {
//   final queryParameter = {
//     "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
//   };
//
//   print("Hello World!");
//
//   final dio = Dio();
//
//   dio.options.headers["ngrok-skip-browser-warning"] = "value";
//
//   final client = StandardScreenClient(dio);
//
//   ApiResponse response = await client.getResponse();
//
//   return StandardScreenResponse.fromJson(response.data);
// }
