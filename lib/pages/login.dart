import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/pages/otp.dart';
import '../utils/routes.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 44, 0, 0),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  Text(
                    "Help",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121)),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  "enter your phone number",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  // hintText: "Enter UserName",
                  labelText: "Phone number",
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff9E9E9E)),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,

                  // icon: Icon.,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xffE0E0E0)),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE0E0E0)),
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(343, 64),
                        primary: Color(0xffFEE440),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(6))),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff212121)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.otp);
                    }))
          ],
        ));
  }
}
