// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:login/screens/Membership/MembershipScreen.dart';
// import 'package:login/screens/RegistrationTwoScreen/RegistrationTwoScreen.dart';
// import 'package:pinput/pinput.dart';
// import 'dart:async';


// class OtpScreen extends StatefulWidget {
//   String mobileNumber ;
//  OtpScreen(@required this.mobileNumber);
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {

//  int Seconds = 20;
//  String digitSeconds = "20";
//  Timer? timer;
//  bool started = true;
//   @override
//   void initState() {
//     super.initState();
//       start();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_outlined,
//                 color: Colors.black,
//                 size: 34,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           body: Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Welcome!",
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         "enter code from sms",
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 8,),
//                       Text(
//                         "We sent it to +91-${widget.mobileNumber}",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: HexColor("#9E9E9E")),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 Center(

//                   child: Pinput(
//                     length: 6,
//                     defaultPinTheme: PinTheme(
//                         height: 64,
//                         width: 48,
//                         decoration: BoxDecoration(
//                           borderRadius:BorderRadius.all(Radius.circular(8)),
//                           color: HexColor("#F5F5F5")
//                         ),
//                         textStyle: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w400,
//                         )
//                     ),
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.all(16),
//                   child:   Container(
//                     height: 64,
//                     width: 343,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder:(context)=>RegistrationScreen()));
//                       },
//                       child: Text(
//                         "Continue",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: HexColor("#212121")),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           HexColor("#FEE440"),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 18,),
//                 Center(
//                   child: Text(
//                     "New code 00:$digitSeconds",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: HexColor("#9E9E9E")),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }

//   void start() {
//     timer = Timer.periodic(Duration(seconds:1), (timer) {

//       if(Seconds>0){
//         int localSeconds = Seconds-1 ;
//         setState(() {
//           Seconds = localSeconds ;
//           digitSeconds = (Seconds>=10)?"$Seconds":"0$Seconds";
//         });
//       }
//     });
//   }
// }
