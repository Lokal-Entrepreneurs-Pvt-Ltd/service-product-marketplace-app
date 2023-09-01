import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _token = "";
  void fetchData() async {
    try {
      // var uri = Uri.parse("http://localhost:5000/user/get");
      // var uri =Uri.parse("https://b652-223-233-77-4.in.ngrok.io/orders/user/get");
      var uri =
          Uri.parse("https://b652-223-233-77-4.in.ngrok.io/orders/user/get");
      var response = await http.get(
        uri,
        headers: {
          "token": _token,
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "ngrok-skip-browser-warning": "xyz",
        },
      );
      var parsed = json.decode(response.body);
      print(parsed);
    } on Exception catch (e) {
      print(e);
    }
  }

  // dynamic get headers => {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $_token",
  //     };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 100,
            height: 100,
            child: ElevatedButton(
              child: const Text('Tap me'),
              onPressed: () {
                fetchData();
              },
            )),
      ),
    );
  }
}
