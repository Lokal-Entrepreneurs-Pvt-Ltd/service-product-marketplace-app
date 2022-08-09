import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/screens/Account.dart';
import 'package:login/screens/EmptyAccount.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _token = "abc";
  bool auth = false;
  var title = "";
  var subtitle = "";
  var buttonText = "";
  var navTitleText = "";
  void initState() {
    load();
  }

  void load() async {
    try {
      var uri = Uri.parse("https://df86-111-223-28-68.in.ngrok.io/user/get");
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
      // print(parsed["heading2"]["text"]);
      // print(parsed["Continue_button"]["textData"]["text"]);

      if (_token == "abc") {
        setState(() {
          auth = true;
        });
      } else {
        // print("hello" + title);
        setState(() {
          title = parsed["heading2"]["text"];
          subtitle = parsed["body"]["text"];
          buttonText = parsed["Continue_button"]["textData"]["text"];
          navTitleText = parsed["dataStore"]["navigationbar"]["leftElement"]
              ["titleData"]["title"];
          // buttonColor
        });
      }
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
        child: Container(
            child: (auth == true)
                ? Account()
                : EmptyAccount(
                    titleTxt: title,
                    subtitleTxt: subtitle,
                    btnText: buttonText,
                    navtitleText: navTitleText,
                    // btnColor: "",
                  )),
      ),
    );
  }
}
