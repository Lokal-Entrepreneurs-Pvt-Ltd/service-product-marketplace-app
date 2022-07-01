import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class SnackBarPage extends StatelessWidget {
  final title;
  final description;
  final action;
  final iconVal;
  final secondIcon;
  final buttonText;
  SnackBarPage(
      {required this.title,
      this.description,
      this.action,
      this.iconVal,
      this.secondIcon,
      this.buttonText});
  SnackBar snackWidget() {
    final snackBar = SnackBar(
      content: Row(
        children: [
          (iconVal != null)
              ? Container(
                  child: Icon(
                    iconVal,
                    color: Colors.white,
                  ),
                )
              : Text(""),
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
          (secondIcon != null)
              ? Container(
                  child: Icon(
                    secondIcon,
                    color: Colors.white,
                  ),
                )
              : (action != null)
                  ? Container(
                      child: (GestureDetector(
                        child: Text(
                          action,
                          style: TextStyle(
                            color: Colors.yellow, fontSize: 20,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {},
                      )),
                    )
                  : (buttonText != null)
                      ? Container(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              onPrimary: Colors.white,
                            ),
                            child: const Text(
                              'Button',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : Text(""),
        ],
      ),
      backgroundColor: Colors.black,
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
