import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            color: Colors.red[300],
            child: const Center(
              child: Text('Page 3'),
            ),
          )),
    );
  }
}
