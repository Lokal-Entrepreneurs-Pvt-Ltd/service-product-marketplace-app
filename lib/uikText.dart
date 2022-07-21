import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UikText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final double wordSpacing;
  final Color backgroundColor;
  final Color decorationColor;
  final FontStyle fontStyle;

 UikText({
    required this.text,
    this.size = 18,
    this.weight = FontWeight.w400,
    this.color = Colors.black,
  this.wordSpacing = 1.15,
   this.backgroundColor = Colors.transparent,
   this.decorationColor = Colors.transparent,
   this.fontStyle = FontStyle.normal,
 });

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
    wordSpacing: wordSpacing,
    backgroundColor: backgroundColor,
    decorationColor: decorationColor,
    fontStyle: fontStyle,
    ),
    );
  }
}
