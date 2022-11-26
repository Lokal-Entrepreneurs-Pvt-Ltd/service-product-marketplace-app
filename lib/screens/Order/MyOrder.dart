// import "package:flutter/material.dart";
// import 'package:google_fonts/google_fonts.dart';


import 'package:login/widgets/UikIcon/uikIcon.dart';
import 'package:login/widgets/UikImage/uikImage.dart';
// import 'package:login/widgets/UikOrderDetails/uikOrderDetails.dart';
// import 'package:login/widgets/UikTabBar/tabBar.dart';
//import "../../assets/images/pic.png";
import '../../Widgets/UikOrderDetails/uikOrderDetails.dart';
import '../../Widgets/UikSearchBar/searchbar.dart';
import '../../Widgets/UikTabBar/tabBar.dart';
import '../../widgets/UikButton/UikButton.dart';
import '../../widgets/UikNavbar/UikNavbar.dart';
// import '../../widgets/UikSearchBar/searchbar.dart';

// import 'package:login/widgets/UikIcon/uikIcon.dart';
// import 'package:login/widgets/UikImage/uikImage.dart';
// import 'package:login/widgets/UikOrderDetails/uikOrderDetails.dart';
// import 'package:login/widgets/UikTabBar/tabBar.dart';
// //import "../../assets/images/pic.png";


// import '../../Widgets/UikNavbar/UikNavbar.dart';
// import '../../widgets/UikSearchBar/searchbar.dart';

// class MyOrder extends StatefulWidget {
//   final listOfImages;
//   MyOrder({this.listOfImages});

//   @override
//   State<MyOrder> createState() => _MyOrderState();
// }

// class _MyOrderState extends State<MyOrder> {
//   @override
//   Widget build(BuildContext context) {
//     return (widget.listOfImages.length > 0)
//         ? Scaffold(
//             body: SingleChildScrollView(
//               child: Container(
//                 //   height: 800,
//                 // decoration: BoxDecoration(
//                 //   color: Colors.white,
//                 // ),
//                 child: Column(
//                   children: [
//                     //for navBar
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 56.0,
//                       child: UikNavbar(
//                         transparency: true,
//                         size: "small",
//                         titleText: "My orders",
//                        // titletxtSize: 16.0,
//                         leftIcon: Icon(Icons.arrow_back),
//                       ),
//                     ),

//                     //.....................for search bar............................................
//                     Container(
//                       //width: 343,
//                       height: 55.0,
//                       margin: const EdgeInsets.only(
//                         left: 16.0,
//                         top: 8.0,
//                         right: 16.0,
//                       ),
//                       child: MySearchBar(
//                         borderColor: const Color(
//                           0xFFF5F5F5,
//                         ),
//                         iconColor: const Color(
//                           0xFF9E9E9E,
//                         ),
//                       ),
//                     ),

//                     //.........Order Details Component.......................
//                     OrderDetails(
//                       marginTop: 24.0,
//                       leftTitle: "Yesterday, 10:00 am",
//                       rightTitle: "\$215",
//                       leftSubtitle: "waiting for payment",
//                       rightSubtitle: "#23124",
//                       leftSubtitleColor: Color(0xFF9E9E9E),
//                       listOfImages: widget.listOfImages,
//                     ),

//                     //.............Order Details Component 2.....................
//                     OrderDetails(
//                       marginTop: 32.0,
//                       leftTitle: "December 25",
//                       rightTitle: "\$215",
//                       leftSubtitle: "Delivered",
//                       rightSubtitle: "#14124",
//                       listOfImages: widget.listOfImages,
//                     ),

//                     //..........Divider...........................
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 1.0,
//                       // decoration: BoxDecoration(
//                       //   border: Border.all(
//                       //     color: Colors.pink,
//                       //   ),
//                       // ),
//                       margin: EdgeInsets.only(
//                         top: 172.0,
//                         //bottom: 103,
//                       ),
//                       child: Divider(
//                         thickness: 1.0,
//                         color: Color(
//                           0xFFEEEEEE,
//                         ),
//                         height: 1.0,
//                       ),
//                     ),
//                     //.................Tabbar.......................

//                     Container(
//                       width: 375.0,
//                       height: 104.0,
//                       // decoration: BoxDecoration(
//                       //   border: Border.all(),
//                       // ),
//                       // margin: EdgeInsets.only(
//                       //   top: 18.74,
//                       // ),
//                       child: MyTabBar(
//                         backgroundColor: Colors.grey.shade50,
//                         indicatorColor: Colors.transparent,
//                         ll: const [
//                           Icons.home,
//                           Icons.shopping_bag,
//                           Icons.settings,
//                           Icons.image,
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         : Scaffold(
//             extendBodyBehindAppBar: false,
//             appBar:UikNavbar(
//               size: 'large',
//               type: 'icon',
//               transparent: false,
//               titletxt: 'my orders',
//               titletxtColor: Color(0xff212121),
//               titletxtSize: 32,
//               iconVal: Icons.settings,
//               iconColor: Color(0xff212121),
//               bgcolor: Color(0xffffffff),
//             ),
//             body: Container(
//               height: 654,
//               color: Color(0xffffffff),
//               // color: Colors.amber,
//               child: ListView(
//                 children: [
//                   const SizedBox(
//                     height: 108,
//                   ),
//                   SizedBox(
//                     // width: 100,
//                     height: 98,
//                     // color: Colors.black,
//                     child: Image.asset("/images/shape.png"),
//                   ),
//                   const SizedBox(
//                     height: 27,
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               child: Text(
//                                 'come on in',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xff212121),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(top: 4),
//                               child: Text(
//                                 'view orders and update your details',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xff9E9E9E),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 177),
//                     child: UikButton(
//                       backgroundColor: Color(0xffFEE440),
//                       widthSize: 343,
//                       heightSize: 64,
//                       text: 'Continue with phone',
//                       textColor: Color(0xff212121),
//                       textSize: 16,
//                       textWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Color(0xffEEEEEE))),
//                     width: MediaQuery.of(context).size.width,
//                     height: 1.0,
//                     margin: const EdgeInsets.only(
//                       top: 16,
//                       //bottom: 103,
//                     ),
//                     child: const Divider(
//                       thickness: 1.0,
//                       color: Color(0XFFEEEEEE),
//                     ),
//                   ),
//                   //.................Tabbar.......................

//                   Container(
//                     width: 375.0,
//                     height: 104.0,
//                     // decoration: BoxDecoration(
//                     //   border: Border.all(),
//                     // ),
//                     // margin: EdgeInsets.only(
//                     //   top: 18.74,
//                     // ),
//                     child: MyTabBar(
//                       backgroundColor: Colors.grey.shade50,
//                       indicatorColor: Colors.transparent,
//                       ll: const [
//                         Icons.home,
//                         Icons.shopping_bag,
//                         Icons.settings,
//                         Icons.image,
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
