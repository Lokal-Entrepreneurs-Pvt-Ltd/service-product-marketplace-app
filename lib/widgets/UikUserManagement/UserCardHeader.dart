import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';

class UserCardHeader extends StatelessWidget {
  const UserCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 1121,
          height: 93,
          child: Card(
            elevation: 10,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: Text("User Cards"),
                      ),
                      SizedBox(height: 9),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 16),
                        child: Row(
                          children: [
                            Container(
                              child: Text("Dashboard"),
                            ),
                            SizedBox(width: 14.33),
                            Container(
                              child: Text("User"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    //width: 124,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 27, 30, 28),
                    child: UikButton(
                      text: "Add User",
                      widthSize: 300,
                    ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
