import 'package:flutter/material.dart';
// 
import '../../../../widgets/UikAvatar/uikAvatar.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';

class MyProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 190,
                height: 42,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 42),
                child: Text(
                  "Profile Card",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 581,
                width: 218,
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: UikAvatar(
                          backgroundColor: Colors.purple,
                          radius: 20,
                        ),
                      ),
                      Container(
                        width: 81,
                        height: 17,
                        margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Center(
                          child: Text(
                            "Tom Cruise",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 67,
                        height: 12,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Center(
                          child: Text(
                            "Ui Designer",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xFFBABFC5),
                        height: 1,
                      ),
                      Container(
                        width: 218,
                        height: 231,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            ListTile(
                              leading: Container(
                                width: 82,
                                height: 15,
                                child: Text(
                                  "Shared Files",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: Container(
                                width: 33,
                                height: 12,
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 0; i < 5; i++) ...[
                              Container(
                                height: 50,
                                width: 150,
                                margin: EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 26,
                                          height: 20,
                                          margin:
                                              EdgeInsets.fromLTRB(12, 5, 9, 0),
                                          child: Icon(
                                            Icons.folder_outlined,
                                            color: Color(0xFF9E9E9E),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 71,
                                              height: 12,
                                              child: Text(
                                                "Reference Zip",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              width: 71,
                                              height: 12,
                                              child: Text(
                                                "Oct 21,2021",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 29,
                                              height: 19,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                "1.8MB",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Container(
                        width: 218,
                        height: 165,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.red)),
                        child: ListView(
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          children: [
                            ListTile(
                              leading: Container(
                                width: 82,
                                height: 16,
                                child: Text(
                                  "Shared Links",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: Container(
                                width: 33,
                                height: 12,
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 0; i < 5; i++) ...[
                              Container(
                                height: 50,
                                width: 150,
                                margin: EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 38,
                                              height: 12,
                                              child: Text(
                                                "Dribble",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              width: 58,
                                              height: 12,
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                "Oct 21,2021",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 29,
                                              height: 19,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                "1.8MB",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



















// ListView.builder(
//                           controller: ScrollController(),
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               dense: true,
//                               leading: Container(
//                                 margin: EdgeInsets.all(0),
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.green)),
//                                 child: Icon(Icons.folder_zip),
//                               ),
//                               title: Text(
//                                 "Reference Zip",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF9E9E9E),
//                                 ),
//                               ),
//                               subtitle: Text("Oct 21,2021"),
//                               trailing: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     "1.0Mb",
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xFF9E9E9E),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           itemCount: 15,
//                         ),