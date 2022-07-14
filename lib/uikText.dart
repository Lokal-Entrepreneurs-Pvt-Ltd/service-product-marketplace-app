import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UikText extends StatelessWidget {
  final double size;
  final String text;
  final FontWeight weight;

  UikText({required this.size, required this.text, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.poppins(fontSize: size, fontWeight: weight),
    );
  }
}
