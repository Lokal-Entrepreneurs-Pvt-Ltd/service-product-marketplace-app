import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';

import '../../pages/UikBottomNavigationBar.dart';
import '../../utils/NavigationUtils.dart';

class ConfirmTowers extends StatelessWidget {
  const ConfirmTowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEEB70),
      body: ListView(
        children: [
          Image.asset('assets/images/friendly.png'),
          Text(
            "Congratulations",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(
            "Your BTS Location request has been taken",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff9e9e9e)),
            textAlign: TextAlign.center,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 200),
              child: UikButton(
                text: "Done",
                textWeight: FontWeight.w500,
                textSize: 16.0,
                textColor: Color(0xff212121),
                backgroundColor: Color(0xffFEEB70),
                type: "outline",
                borderColor: Color(0xff212121),
                onClick: () {
                  // NavigationUtils.pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UikBottomNavigationBar(),
                    ),
                    // arguments: args,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
