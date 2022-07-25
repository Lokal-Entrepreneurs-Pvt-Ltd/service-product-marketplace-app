import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikImage/uikImage.dart';
import 'package:login/widgets/UikSwitch/UikSwitch.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 438,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(286, 20, 20, 0),
                  child: UikButton(
                    text: "Active",
                    textColor: Color(0xffE57373),
                    backgroundColor: Color(0xffFEF2A0),
                    widthSize: 52,
                    heightSize: 19,
                    textSize: 12,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 19),
                  child: Stack(
                    children: [
                      Container(
                        child: UikAvatar(
                            radius: 50,
                            backgroundImage:
                                Image.asset("assets/images/ProfileImage.png")
                                    .image),
                      ),
                      Positioned(
                        left: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffE57373),
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          width: 30,
                          height: 30,
                          child: UikIcon(
                            valIcon: Icons.camera_alt_rounded,
                            iconColor: Colors.white,
                            //backgroundColor: Color(0xffE57373),
                            iconSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 18),
                  width: 189,
                  height: 32,
                  child: Text(
                    "Allowed *.jpeg, *.jpg, *.png, *.gif max size of 3.1 MB",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff82868C),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 80, right: 89, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Banned",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            UikSwitch(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 145,
                          left: 70,
                        ),
                        child: const Text(
                          "Apply disable account",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff9E9E9E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 80, right: 89, top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email Verified",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            UikSwitch(),
                          ],
                        ),
                      ),
                      Container(
                        width: 222,
                        height: 32,
                        margin: EdgeInsets.only(left: 80, right: 58),
                        child: const Text(
                          "Disabling this will automatically send the user a verification email",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff9E9E9E),
                          ),
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
