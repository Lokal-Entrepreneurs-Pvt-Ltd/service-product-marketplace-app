import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/screens/MainPage/ColumnCard.dart';
import 'package:login/widgets/UikSlider/UikSlider.dart';
import 'package:login/widgets/UikImage/uikImage.dart';
import 'package:login/widgets/UikSearchBar/searchbar.dart';
import 'package:login/widgets/UikSlider/UikSlider.dart';
import 'package:login/widgets/UikTabBar/tabBar.dart';

// import "../../assets/images/pic.png";

class MainPage extends StatefulWidget {
  final images;
  const MainPage({
    Key? key,
    this.images = "assets/images/row1.png",
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    var _token = "";
  void fetchData() async {
    try {
      // var uri = Uri.parse("http://localhost:5000/user/get");
      // var uri =Uri.parse("https://b652-223-233-77-4.in.ngrok.io/orders/user/get");
      var uri = Uri.parse(
          "https://5e64-104-28-193-172.in.ngrok.io/discovery/get");
      var response = await http.get(
        uri,
        headers: {
          // "token": _token,
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "ngrok-skip-browser-warning": "xyz",
        },
      );
      var parsed = json.decode(response.body);
      print(parsed["type"]);
    } on Exception catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.grey,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 375,
                height: 56,
              ),
              Container(
                width: 375,
                height: 56,
                //color: Colors.blue,
                child: const Text(
                  "LoKal",
                  style: TextStyle(
                    //fontFamily: 'Poppins-Medium',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff212121),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 343,
                height: 54,
                child: MySearchBar(
                    label: "Search",
                    borderColor: Colors.transparent,
                    iconColor: Color(0xff9E9E9E)),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 372,
                height: 380,
                child: ListView(
                  children: [
                    UikSlider(
                      heightSize: 88,
                      slide: [
                        {
                          "image": widget.images,
                          "text": "the golden hour"
                        },
                        {
                          "image": "assets/images/row2.png",
                          "text": "the golden hour"
                        },
                        {
                          "image": "assets/images/row3.png",
                          "text": "the golden hour"
                        },
                        {
                          "image": "assets/images/row3.png",
                          "text": "the golden hour"
                        },
                        {
                          "image": "assets/images/row3.png",
                          "text": "the golden hour"
                        },
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ColumnCard(
                      imgVal: Image.asset("assets/images/column1.png").image,
                      text: "ISP",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ColumnCard(
                      imgVal: Image.asset("assets/images/column2.png").image,
                      text: "Financing",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ColumnCard(
                      imgVal: Image.asset("assets/images/column1.png").image,
                      text: "EV",
                    ),
                  ],
                ),
              ),
              //Tab Bar
              Container(
                width: 375,
                height: 104,
                child: MyTabBar(
                  backgroundColor: Colors.grey.shade50,
                  indicatorColor: Colors.transparent,
                  ll: const [
                    Icons.home,
                    Icons.shopping_bag,
                    Icons.settings_suggest_sharp,
                    Icons.person_rounded,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
