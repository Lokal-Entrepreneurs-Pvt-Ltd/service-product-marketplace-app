import 'package:dio/dio.dart';
import 'package:lokal/utils/network/NetworkInterceptor.dart';
import 'package:lokal/utils/network/retrofit/api_client.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../storage/user_data_handler.dart';

class ApiRepository {
    static Dio getDio() {
      Dio dio = Dio(BaseOptions(contentType: "application/json"));
      String authToken = "";
      UserDataHandler.getUserToken().then((value) {
        authToken = value;
      });
      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken'
      };
      dio.options.headers = headers;
     // dio.interceptors.add(NetworkInterceptor());
      return dio;
    }

   static Future<ApiResponse> getHomescreen(){
      return StandardScreenClient(getDio()).getHomeScreen();
    }
 }


