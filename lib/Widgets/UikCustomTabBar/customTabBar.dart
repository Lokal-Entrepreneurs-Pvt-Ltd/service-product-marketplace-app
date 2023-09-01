




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabElement extends StatefulWidget {
  final String text;
  final int index;
  bool isSelected;
  TabElement({
    super.key,
    required this.text,
    required this.index,
    this.isSelected = false,
  });

  @override
  State<TabElement> createState() => _TabElementState();
}

class _TabElementState extends State<TabElement> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        widget.text,
        style: GoogleFonts.poppins(
          color: widget.isSelected ? const Color(0xFF3F51B5) : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}