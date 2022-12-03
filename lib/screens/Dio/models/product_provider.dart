import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import 'product.dart';

class ProuctProvider extends ChangeNotifier {
  List<Prouct> _dummy = [];
  bool isLoading = false;

  List<Prouct> get getProuct => _dummy;

  Future<void> fetchProuct() async {
    try {
      final response = await Dio().get("https://dummyjson.com/products");
      // final response =
      //     await http.get(Uri.parse("https://dummyjson.com/products"));

      final body = json.decode(response.data) as Map<String, dynamic>;

      // for (var data in body["products"]) {
      // print(data);
      final Prouct dummy = Prouct.fromJson(body["products"][0]);

      _dummy.add(dummy);
      // }

      isLoading = true;

      notifyListeners();
    } catch (error) {
      throw Exception("ERROR: $error");
    }
  }
}
