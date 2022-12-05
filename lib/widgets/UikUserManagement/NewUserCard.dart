import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

class NewUserCard extends StatelessWidget {
  const NewUserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 1121,
          height: 101,
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
                        child: Text(
                          "Create a new user",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff3A3C40),
                          ),
                        ),
                      ),
                      SizedBox(height: 9),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 16),
                        child: Row(
                          children: [
                            Container(
                              child: Text("Dashboard",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                            SizedBox(width: 14.33),
                            Container(
                              child: Text("•",style: TextStyle(fontSize: 22,color: Color(0xff82868C)),),
                            ),
                            SizedBox(width: 14.33),
                            Container(
                              child: Text("User",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                            SizedBox(width: 14.33),
                            Container(
                              child: Text("•",style: TextStyle(fontSize: 22,color: Color(0xff82868C)),),
                            ),
                            SizedBox(width: 14.33),
                            Container(
                              child: Text("New User",style: TextStyle(fontSize: 14,color: Color(0xff82868C)),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 27, 30, 28),
                //   child: UikButton(
                //     text: "Add new user",
                //     widthSize: 124,
                //     heightSize: 38,
                //     stuck: true,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
