import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikImage/uikImage.dart';
import 'package:login/widgets/UikSearchBar/searchbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.grey,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff212121),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 343,
                height: 54,
                child: MySearchBar(
                    label: "Search", borderColor: Colors.transparent),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                width: 372,
                height: 266,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: 104,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 88,
                            height: 88,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 88,
                            height: 88,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 88,
                            height: 88,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    Container(
                      width: 343,
                      height: 100,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 343,
                      height: 100,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 343,
                      height: 100,
                      color: Colors.blueGrey,
                    ),
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
