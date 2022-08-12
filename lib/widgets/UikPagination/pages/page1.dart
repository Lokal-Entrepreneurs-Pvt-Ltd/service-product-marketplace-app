import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.blue[300],
            child: const Center(
              child: Text('Page 1'),
            ),
          )),
    );
  }
}
