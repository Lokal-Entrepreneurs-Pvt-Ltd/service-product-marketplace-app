import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class SnackBarPage extends StatelessWidget {
  final title;
  final description;
  final Trigger;
  final backgroundColor;
  final leftElement;
  SnackBarPage({
    required this.title,
    this.description,
    this.leftElement,
    this.Trigger,
    this.backgroundColor = Colors.black,
  });
  SnackBar snackWidget() {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Container(
            child: (leftElement != null) ? leftElement : null,
            height: 40,
          ),

          SizedBox(width: 10),
          Container(
            height: 40,
            child: description != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 20),
                      ),
                      // if (description != null)
                      Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: TextStyle(fontSize: 28),
                  ),
          ),
          // SizedBox(width: 120),
          Spacer(),
          Container(
            child: Trigger,
          )
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(milliseconds: 5000),
      // action: SnackBarAction(
      //   label: "Action",
      //   disabledTextColor: Colors.white,
      //   textColor: Colors.yellow,
      //   onPressed: () {
      //     //function
      //   },
      // ),
    );
    return snackBar;
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
