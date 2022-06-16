import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/widgets.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: Widgets().widgetList1),
    );
  }
}
