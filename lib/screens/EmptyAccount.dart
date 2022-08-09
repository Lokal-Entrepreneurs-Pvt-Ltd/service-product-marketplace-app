import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikDivider/UikDivider.dart';
import 'package:login/widgets/UikIcon/uikIcon.dart';
import 'package:login/widgets/UikNavbar/UikNavbar.dart';

import '../widgets/UikTabBar/tabBar.dart';

// import 'package:login/widgets/UikNavbar/UikNavbar.dart';

class EmptyAccount extends StatefulWidget {
  final titleTxt;
  final subtitleTxt;
  final btnText;
  final navtitleText;
  // final btnColor;

  const EmptyAccount({
    super.key,
    this.titleTxt = "abc",
    this.subtitleTxt = "come on in",
    this.btnText = "continue to login",
    this.navtitleText = "my account",
    // required this.btnColor,
  });

  @override
  State<EmptyAccount> createState() => _EmptyAccountState();
}

class _EmptyAccountState extends State<EmptyAccount> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: false,
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  border: Border.all(color: Colors.black)),
              width: 375,
              height: 760,
              child: ListView(
                children: [
                  UikNavbar(
                    size: 'large',
                    rightElementType: 'icon',
                    transparent: false,
                    titletxt: widget.navtitleText,
                    titletxtColor: Color(0xff212121),
                    titletxtSize: 32,
                    iconVal: Icons.settings_outlined,
                    iconColor: Color(0xff212121),
                    bgcolor: Color(0xffffffff),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 108),
                    // width: 100,
                    height: 98,
                    // color: Colors.black,
                    child: Image.asset("/images/shape.png"),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                widget.titleTxt,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff212121),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                widget.subtitleTxt,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 177),
                    child: UikButton(
                      backgroundColor: Color(0xffFEE440),
                      widthSize: 343,
                      heightSize: 64,
                      text: widget.btnText,
                      textColor: Color(0xff212121),
                      textSize: 16,
                      textWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffEEEEEE))),
                    width: MediaQuery.of(context).size.width,
                    height: 1.0,
                    margin: const EdgeInsets.only(
                      top: 16,
                      //bottom: 103,
                    ),
                    child: Divider(
                      thickness: 1.0,
                      color: Color(0XFFEEEEEE),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color(0xffffffff)),
                    // margin: EdgeInsets.only(top: 17),
                    width: 374,
                    height: 50,
                    // color: Color(0xFFFFFFFF),
                    child: MyTabBar(
                      // heightsize: 100,
                      backgroundColor: const Color(0xFFFFFFFF),
                      ll: const [
                        Icons.home,
                        Icons.shopping_bag,
                        Icons.miscellaneous_services,
                        Icons.person_rounded,
                      ],
                    ),
                    // const Positioned(
                    //     top: 94,
                    //     bottom: 8,
                    //     left: 138,
                    //     right: 137,
                    //     child: Divider(
                    //       height: 4.0,
                    //       thickness: 4.0,
                    //       color: Color(0xff212121),
                    //     ))
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 5),
                      // color: Colors.amber,
                      width: 375,
                      height: 6,
                      // padding: EdgeInsets.only(bottom: ),
                      alignment: Alignment.bottomCenter,
                      // padding: EdgeInsets.only(top: 94, bottom: 8),
                      child: Divider(
                        height: 4.0,
                        thickness: 4.0,
                        indent: 138,
                        endIndent: 137,
                        color: Color(0xff212121),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
