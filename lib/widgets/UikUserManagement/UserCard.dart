// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikDivider/UikDivider.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';

class UserCard extends StatelessWidget {
  final userName;
  final designation;
  const UserCard({
    this.userName = "Natalie Dormer",
    this.designation = "Marketing Manager",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 359,
          height: 299,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 359,
                      height: 96,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xFFF5F5F5,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/UserCardTop.png",
                      ),
                    ),
                    Container(
                      child: Positioned(
                        left: 154,
                        height: 52,
                        width: 52,
                        top: 67,
                        child: Image.asset(
                          "assets/images/AvatarCircle.png",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(128, 31, 128, 0),
                  width: 103,
                  height: 16,
                  child: Text(
                    userName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3A3C40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(129, 0, 129, 0),
                  width: 101,
                  height: 12,
                  child: Text(
                    designation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff82868C),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 18.47, top: 18.47, left: 129.33),
                  child: Row(
                    children: [
                      UikIcon(valIcon: Icons.favorite),
                      UikIcon(valIcon: Icons.favorite),
                      UikIcon(valIcon: Icons.favorite),
                      UikIcon(valIcon: Icons.favorite),
                    ],
                  ),
                ),
                UikDivider(
                  corner: "rectangle",
                  dividerColor: Color(0xffE3E6EB),
                  dividerSize: "small",
                  widthSize: 359,
                ),
                SizedBox(height: 17),
                Container(
                  margin: EdgeInsets.only(bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "121",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("Post avg",
                                style: TextStyle(color: Color(0xff9E9E9E))),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "575",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("Followers",
                                style: TextStyle(color: Color(0xff9E9E9E))),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "632",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(color: Color(0xff9E9E9E)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
