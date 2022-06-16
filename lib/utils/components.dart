import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Components {
  Stack slideItems(name, imageUrl) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 20,
          left: 15,
          child: Text(
            "$name",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
          ))
    ]);
  }

  ClipRRect listItemScreen1(String name, imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white70,
        height: 100,
        child: Stack(children: [
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              "$name",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
              left: 290,
              child: Container(
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: 82,
                  fit: BoxFit.cover,
                ),
              ))
        ]),
        width: 370,
      ),
    );
  }
}
