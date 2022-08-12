import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            height: 200,
            width: 200,
            color: Colors.yellow[300],
            child: const Center(
              child: Text('Page 2'),
            ),
          )),
    );
  }
}
