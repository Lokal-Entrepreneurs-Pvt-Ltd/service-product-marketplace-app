import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import 'package:login/widgets/UikCell/UikCell.dart';
import 'package:login/widgets/UikIcon/uikIcon.dart';
import 'package:login/widgets/UikListItems/onHover.dart';
import 'package:login/widgets/UikNavbar/UikNavbar.dart';

import '../widgets/UikTabBar/tabBar.dart';

class NewAccount extends StatefulWidget {
  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const UikNavbar(
          size: 'large',
          rightElementType: 'icon',
          transparent: false,
          titletxt: 'my account',
          titletxtColor: Color(0xff212121),
          titletxtSize: 32,
          iconVal: Icons.settings_outlined,
          iconColor: Color(0xff212121),
          bgcolor: Color(0xffffffff),
        ),
        body: Container(
          color: Color(0xffffffff),
          width: 375,
          height: 654,
          child: Column(
            children: [
              Container(
                width: 375,
                height: 550,
                child: ListView(
                  children: [
                    // user description container
                    Container(
                      // color: Colors.amber,
                      margin: EdgeInsets.only(top: 17.5),
                      child: const Cell(
                        titleText: 'Tanya moreko',
                        titlesize: 16,
                        titleWeight: FontWeight.w500,
                        titleColor: Color(0xff212121),
                        subtitleText: '+7-282973979',
                        subtitlesize: 14,
                        subtitleWeight: FontWeight.w400,
                        subtitleColor: Color(0xff9E9E9E),
                        leftChild: UikAvatar(
                          shape: UikAvatarShape.circle,
                          size: UikSize.SMALL,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        ),
                      ),
                      // child: Row(
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(right: 16),
                      //       child: const UikAvatar(
                      //         shape: UikAvatarShape.circle,
                      //         size: UikSize.SMALL,
                      //         backgroundImage: NetworkImage(
                      //             "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                      //       ),
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Tanya Morenko',
                      //           style: GoogleFonts.poppins(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w500,
                      //               color: Color(0xff212121)),
                      //         ),
                      //         Text(
                      //           '+7 912 323-32-12',
                      //           style: GoogleFonts.poppins(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w400,
                      //             color: Color(0xff9E9E9E),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ),
                    // Container(
                    //   width: 375,
                    //   height: 355,
                    // color: Colors.amber,
                    // margin: EdgeInsets.only(top: 30),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      // color: Colors.blue,
                      width: 375,
                      // height: 384,
                      child: Column(
                        children: [
                          Container(
                              // color: Colors.pink,
                              width: 375,
                              height: 64,
                              child:
                                  //  ListTile(
                                  //   leading: const UikIcon(
                                  //     valIcon: Icons.shopping_bag_outlined,
                                  //     iconColor: Color(0xff212121),
                                  //   ),
                                  //   title: Text(
                                  //     'My orders',
                                  //     style: GoogleFonts.poppins(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: Color(0xff212121)),
                                  //   ),
                                  //   trailing: Text(
                                  //     '14',
                                  //     style: GoogleFonts.poppins(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: Color(0xff9E9E9E)),
                                  //   ),
                                  // ),
                                  const Cell(
                                titleText: 'My orders',
                                titlesize: 16,
                                titleWeight: FontWeight.w400,
                                titleColor: Color(0xff212121),
                                leftChild: UikIcon(
                                  valIcon: Icons.shopping_bag_outlined,
                                  iconColor: Color(0xff212121),
                                ),
                                rightChild: Text("14"),
                              )),
                          Container(
                              width: 375,
                              height: 64,
                              // margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: const UikIcon(
                                  valIcon: Icons.person_outline,
                                  iconColor: Color(0xff212121),
                                ),
                                title: Text(
                                  'My details',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              )),
                          Container(
                              width: 375,
                              height: 64,
                              // margin: EdgeInsets.only(top: 25),
                              // margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: const UikIcon(
                                  valIcon: Icons.favorite,
                                  iconColor: Color(0xff212121),
                                ),
                                title: Text(
                                  'My Wishlist',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              )),
                          Container(
                              width: 375,
                              height: 64,
                              // margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: const UikIcon(
                                  valIcon: Icons.location_pin,
                                  iconColor: Color(0xff212121),
                                ),
                                title: Text(
                                  'Address book',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              )),
                          Container(
                              width: 375,
                              height: 64,
                              // margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: const UikIcon(
                                  valIcon: Icons.credit_card_outlined,
                                  iconColor: Color(0xff212121),
                                ),
                                title: Text(
                                  'Payment Methods',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              )),
                          Container(
                              width: 375,
                              height: 64,
                              // margin: EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: const UikIcon(
                                  valIcon: Icons.logout,
                                  iconColor: Color(0xff212121),
                                ),
                                title: Text(
                                  'Sign out',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xffEEEEEE))),
                width: MediaQuery.of(context).size.width,
                height: 1.0,
                // margin: const EdgeInsets.only(
                //   top: 90,
                //bottom: 103,
                // ),
                child: Divider(
                  thickness: 1.0,
                  color: Color(0XFFEEEEEE),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xffffffff)),
                // margin: EdgeInsets.only(top: 10),
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
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 375,
                  height: 30,
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
        ));
  }
}
