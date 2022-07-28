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
  final bool delete;
  final bool disabled;
  final bool underlined;
  final bool italic;
  final bool marked;

 UikText({
    required this.text,
    this.size = 18,
    this.weight = FontWeight.w400,
    this.color = Colors.black,
  this.wordSpacing = 1.15,
   this.backgroundColor = Colors.transparent,
   this.decorationColor = Colors.transparent,
   this.fontStyle = FontStyle.normal,
   this.delete = false,
   this.disabled = false,
   this.underlined = false,
   this.italic = false,
   this.marked = false,
  });

 @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: (() {
          if(disabled == true) {
return Colors.grey;
          }
        else {
          return color;
          }
        } ()),
    wordSpacing: wordSpacing,
    fontStyle: (() {
      if(italic == true) {
        return FontStyle.italic;
      }
    } ()),
    backgroundColor: (() {
      if(marked == true) {
        return Colors.yellow;
      }
      else {
        return backgroundColor;
      }
    } ()),
    decorationColor: decorationColor,
        decoration: (() {
          if(delete == true) {
            return TextDecoration.lineThrough;
          }
          else if(underlined == true) {
            return TextDecoration.underline;
          }
          else {
            return TextDecoration.none;
          }
        } ()),
    ),
    );
  }
}

