import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikDivider/UikDivider.dart';
import 'package:login/widgets/UikIcon/uikIcon.dart';
import 'package:login/widgets/UikNavbar/UikNavbar.dart';

// import 'package:login/widgets/UikNavbar/UikNavbar.dart';

class EmptyAccount extends StatefulWidget {
  @override
  State<EmptyAccount> createState() => _EmptyAccountState();
}

class _EmptyAccountState extends State<EmptyAccount> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: const UikNavbar(
          size: 'large',
          type: 'icon',
          transparent: false,
          titletxt: 'my account',
          titletxtColor: Color(0xff212121),
          titletxtSize: 32,
          iconVal: Icons.settings,
          iconColor: Color(0xff212121),
          bgcolor: Color(0xffffffff),
        ),
        body: Container(
          height: 654,
          color: Color(0xffffffff),
          // color: Colors.amber,
          child: ListView(
            children: [
              SizedBox(
                height: 108,
              ),
              Container(
                // width: 100,
                height: 98,
                // color: Colors.black,
                child: Image.asset("/images/shape.png"),
              ),
              SizedBox(
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
                            'come on in',
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
                            'view orders and update your details',
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
                  text: 'Continue with phone',
                  textColor: Color(0xff212121),
                  textSize: 16,
                  textWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xffEEEEEE))),
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
              // Container(
              //   width: 375,
              //   height: 104,
              //   child: MyTabBar(
              //     backgroundColor: const Color(0xffffffff),
              //     ll: const [
              //       Icons.home,
              //       Icons.shopping_bag,
              //       Icons.miscellaneous_services,
              //       Icons.person_rounded
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
