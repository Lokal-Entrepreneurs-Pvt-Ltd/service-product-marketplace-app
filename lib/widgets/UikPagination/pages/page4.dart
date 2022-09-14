import 'package:flutter/material.dart';

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            color: Colors.green[300],
            child: const Center(
              child: Text('Page 4'),
            ),
          )),
    );
  }
}
