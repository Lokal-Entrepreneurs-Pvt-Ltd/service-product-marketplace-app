import 'package:dio/dio.dart';
import 'package:lokal/StandardScreenClient.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';

class UikComponentDisplayer extends StandardPage {

  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<StandardScreenResponse> getData() {
    // TODO: implement getData
    return fetchAlbum();
  }

  @override
  getFunction() {
    // TODO: implement getFunction
    throw UnimplementedError();
  }

  @override
  getReference() {
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
