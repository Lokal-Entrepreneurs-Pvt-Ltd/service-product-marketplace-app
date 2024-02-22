import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_sdk/utils/extensions.dart';

class SelectableTextWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double border;

  SelectableTextWidget({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ("#FEE440").toColor() : Colors.transparent,
          border: (border != 0)
              ? Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey,
                  width: border,
                )
              : null,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
