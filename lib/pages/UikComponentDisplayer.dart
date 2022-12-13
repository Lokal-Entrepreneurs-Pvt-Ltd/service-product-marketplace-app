import 'package:dio/dio.dart';
import 'package:lokal/utils/network/retrofit/api_client.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:dio/dio.dart';

import '../utils/network/retrofit/api_client.dart';
class UikComponentDisplayer extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<ApiResponse> getData() {
    return StandardScreenClient(Dio(BaseOptions(contentType: "application/json"))).getHomeScreen();
  }

  @override
  getPageCallBackForAction() {
    // TODO: implement getFunction
    // throw UnimplementedError();
    return of();
  }

  void of() {}
  
  @override
  getReference() {
    // TODO: implement getReference
    // throw UnimplementedError();
    return UikCatalogScreen();
    throw UnimplementedError();
  }

  @override
  getPageContext() {
    // TODO: implement getReference
    throw UnimplementedError();
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };

  print("Hello World!");

  final dio = Dio();

  dio.options.headers["ngrok-skip-browser-warning"] = "value";

  final client = StandardScreenClient(dio);

  ApiResponse response = await client.getResponse();

  return StandardScreenResponse.fromJson(response.data);
}
