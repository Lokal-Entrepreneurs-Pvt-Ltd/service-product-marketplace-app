import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'UikPopover.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:ffi';

class MyPopover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Button(),
    ));
  }
}

class Button extends StatelessWidget {
  var obj = const Popover(
    headlineText: "popover widget",
    desc: true,
    descText: "description",
    textField: false,
    textFieldText: "enter your name",
    buttons: [
      // ["Active", 0xffFEE440],
      // ["Disabled", 0xffF5F5F5]
    ],
    imageBool: false,
    inputImg:
        "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    // popoverWidth: ,
    // popoverHeight: 400,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15),
      width: 60,
      height: 40,
      color: Colors.white,
      child: GestureDetector(
        child: const Center(child: Text('Click Me')),
        onTap: () {
          obj.UikPopover(context);
        },
      ),
    );
  }
}
