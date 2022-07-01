import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import "./snackbar.dart";

class Snack extends StatelessWidget {
  final obj = SnackBarPage(
    title: "Snackbar",
    //description: "yuvraj",
    //action: "Action",
    iconVal: Icons.rounded_corner_sharp,
    buttonText: "Action",
    //secondIcon: Icons.notification_add_rounded,
  );
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: _messangerKey,
        home: Scaffold(
            body: Container(
                child: Row(children: [
          ElevatedButton(
            onPressed: () {
              _messangerKey.currentState!.showSnackBar(obj.snackWidget());
            },
            child: Text('Show My'),
          )
        ]))));
  }
}
