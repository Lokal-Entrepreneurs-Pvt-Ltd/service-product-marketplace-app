import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 44, 0, 0),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                Text(
                  "Help",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff212121)),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                "enter your phone number",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                // hintText: "Enter UserName",
                labelText: "Phone number",
                labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff9E9E9E)),
                fillColor: const Color(0xffF5F5F5),
                filled: true,

                // icon: Icon.,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color(0xffE0E0E0)),
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: UikButton(
                type: UikButtonType.primary,
                disabled: false,
                rightElement: const UikIcon(valIcon: Icons.favorite_border),
                leftElement: const UikIcon(valIcon: Icons.location_on),
                stuck: false,
                backgroundColor: Colors.yellow,
                borderColor: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: UikButton(
                stuck: true, widthSize: 98, textWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
