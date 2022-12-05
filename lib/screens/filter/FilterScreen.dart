import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikListTile/UikListTile.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';
import '../../widgets/UikSlidder/slidder.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UikIcon(
                    valIcon: Icons.close,
                    iconSize: 32.0,
                  ),
                  Text(
                    "Filter",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Clear",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Slidder(
                maximum: 500000.0,
                isRange: false,
              ),
              UikListTile(
                lead: Text(
                  "Category",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                trail: Text(
                  "furniture",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E)),
                ),
                pdng: 12.0,
              ),
              UikListTile(
                lead: Text(
                  "Product Type",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                trail: Text(
                  "All",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E)),
                ),
                pdng: 12.0,
              ),
              UikListTile(
                lead: Text(
                  "Color",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                trail: Text(
                  "All",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E)),
                ),
                pdng: 12.0,
              ),
              UikListTile(
                lead: Text(
                  "Size",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                trail: Text(
                  "All",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E)),
                ),
                pdng: 12.0,
              ),
              UikListTile(
                lead: Text(
                  "Quality",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                trail: Text(
                  "All",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E)),
                ),
                pdng: 12.0,
              ),
              const SizedBox(
                height: 80,
              ),
              UikButton(
                text: "Show 25 Items",
                textWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
