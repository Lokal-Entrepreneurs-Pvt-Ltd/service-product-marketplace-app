import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccount extends StatelessWidget {
  final List<Widget> ll;
  // final heading;

  MyAccount({required this.ll});
  // const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: 375,
            height: 114,
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  top: 56,
                  left: 16,
                  child: Container(
                    width: 343,
                    height: 42,
                    // margin: EdgeInsets.only(top: 100, left: 16),
                    child: Text(
                      "my account",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 32),
                    ),
                  ),
                ),
                Positioned(
                  top: 18.28,
                  left: 337.28,
                  child: Container(
                    width: 19.44,
                    height: 19.44,
                    // margin: EdgeInsets.only(top: 100, left: 16),
                    child: Icon(Icons.settings),
                  ),
                )
              ],
            ),
          ),
          for (int i = 0; i < ll.length; i++) ...[
            ll[i],
          ]
        ],
      ),
    );
  }
}
