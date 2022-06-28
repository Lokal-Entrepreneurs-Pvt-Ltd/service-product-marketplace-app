// import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import "./searchbar.dart";

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  TextEditingController textController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyWidget(iconVal: null),
      ),
    );
  }
}
