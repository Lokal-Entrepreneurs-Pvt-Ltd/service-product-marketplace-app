import 'dart:developer';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/screens/MainPage/userModel.dart';
import '../MainPage/constants.dart';
import '../MainPage/apiServices.dart';

class ApiService {
  Future<List<Product>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Product> _model = json.decode(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
