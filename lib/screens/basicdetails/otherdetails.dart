import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';

class OtherDetails extends StatefulWidget {
  const OtherDetails({Key? key}) : super(key: key);

  @override
  State<OtherDetails> createState() => _OtherDetailsState();
}

class _OtherDetailsState extends State<OtherDetails> {
  List<int> selectedOptions = [-1, -1, -1];
  List<String> education = [
    "10th",
    "12th",
    "Diploma",
    "Graduation",
    "Postgraduation"
  ];
  List<String> work = ["less than 1 year", "1-3 years", "> 3 years"];
  List<String> relocation = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Create Profile",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              "2 of 3",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Other Details",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 25),
            buildCategory("Education", education, 0),
            SizedBox(height: 25),
            buildCategory("Work Experience", work, 1),
            SizedBox(height: 25),
            buildCategory("Are you willing to relocate", relocation, 2),
            SizedBox(height: 30),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: Alignment.center,
          child: UikButton(
            text: "Continue",
            textColor: Colors.black,
            textSize: 16.0,
            textWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget buildCategory(String title, List<String> options, int categoryIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            options.length,
            (index) => SelectableTextWidget(
              text: options[index],
              isSelected: selectedOptions[categoryIndex] == index,
              onTap: () => updateSelectedIndex(index, categoryIndex),
            ),
          ),
        ),
      ],
    );
  }

  void updateSelectedIndex(int index, int categoryIndex) {
    setState(() {
      selectedOptions[categoryIndex] = index;
    });
  }
}
