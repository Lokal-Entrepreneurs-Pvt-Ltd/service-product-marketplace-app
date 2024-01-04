import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectableTextWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  SelectableTextWidget({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
