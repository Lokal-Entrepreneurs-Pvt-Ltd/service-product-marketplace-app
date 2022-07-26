import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:login/widgets/UikIcon/uikIcon.dart';
import 'package:login/widgets/UikImage/uikImage.dart';
import 'package:login/widgets/UikTabBar/tabBar.dart';
//import "../../assets/images/pic.png";
import '../../widgets/UikNavbar/UikNavbar.dart';
import '../../widgets/UikSearchBar/searchbar.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //   height: 800,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          // ),
          child: Column(
            children: [
              //for navBar
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: const MyAppBar(
                  transparent: true,
                  size: "small",
                  titletxt: "My orders",
                  titletxtSize: 16,
                  lefticon: Icons.arrow_back,
                ),
              ),

              //.....................for search bar............................................
              Container(
                //width: 343,
                height: 55,
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                ),
                child: MySearchBar(
                  borderColor: const Color(
                    0xFFF5F5F5,
                  ),
                  iconColor: const Color(
                    0xFF9E9E9E,
                  ),
                ),
              ),

              //................Two Text.....................

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 270,
                    height: 24,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 24,
                      // right: 8,
                    ),
                    child: Text(
                      "Yesterday, 10:00 am",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      right: 40,
                      top: 24,
                    ),
                    child: Text(
                      "\$420.54",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //................Two Text(second).....................

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 270,
                    height: 24,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 2,
                      // right: 8,
                    ),
                    child: Text(
                      "Waiting for payment",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF9E9E9E,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      right: 40,
                      top: 2,
                    ),
                    child: Text(
                      "#23123",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF9E9E9E,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //..........Two Images................................
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 12,
                    ),
                    child: UikImage(
                      valImage: Image.asset("assets/images/pic.png").image,
                      iHeight: 73,
                      iWidth: 60,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      // left: 16,
                      top: 16,
                      // right: 12,
                    ),
                    child: UikImage(
                      valImage: Image.asset("assets/images/pic.png").image,
                      iHeight: 73,
                      iWidth: 60,
                    ),
                  ),
                ],
              ),

              //................Two Text(third).....................

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 270,
                    height: 24,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 32,
                      // right: 8,
                    ),
                    child: Text(
                      "December 25",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      right: 40,
                      top: 24,
                    ),
                    child: Text(
                      "\$420.54",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(
                          0xFF212121,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //................Two Text(forth).....................

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 270,
                    height: 24,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 2,
                      // right: 8,
                    ),
                    child: Text(
                      "Delivered",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF66BB6A,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    margin: const EdgeInsets.only(
                      right: 40,
                      top: 2,
                    ),
                    child: Text(
                      "#23123",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                          0xFF9E9E9E,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //................Three Images.......................
              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 12,
                      ),
                      child: UikImage(
                        valImage: Image.asset("assets/images/pic.png").image,
                        iHeight: 73,
                        iWidth: 60,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        // left: 16,
                        top: 16,
                        right: 12,
                      ),
                      child: UikImage(
                        valImage: Image.asset("assets/images/pic.png").image,
                        iHeight: 73,
                        iWidth: 60,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        // left: 16,
                        top: 16,
                        // right: 12,
                      ),
                      child: UikImage(
                        valImage: Image.asset("assets/images/pic.png").image,
                        iHeight: 73,
                        iWidth: 60,
                      ),
                    ),
                  ],
                ),
              ),

              //..........Divider...........................
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.pink,
                //   ),
                // ),
                margin: EdgeInsets.only(
                  top: 172,
                  //bottom: 103,
                ),
                child: Divider(
                  thickness: 1.0,
                  color: Color(
                    0xFFEEEEEE,
                  ),
                  height: 1.0,
                ),
              ),
              //.................Tabbar.......................

              Container(
                width: 375,
                height: 104,
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                // margin: EdgeInsets.only(
                //   top: 18.74,
                // ),
                child: MyTabBar(
                  backgroundColor: Colors.grey.shade50,
                  indicatorColor: Colors.transparent,
                  ll: const [
                    Icons.home,
                    Icons.shopping_bag,
                    Icons.abc,
                    Icons.settings,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
