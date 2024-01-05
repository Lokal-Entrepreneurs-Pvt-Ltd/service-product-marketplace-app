import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
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
    "Diploma/Certification",
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
            Column(
              children: getWidgetByUserType(),
            )
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
            onClick: updatedata,
          ),
        ),
      ],
    );
  }

  void updatedata() async {
    try {
      final response = await ApiRepository.updateCustomerInfo(
        ApiRequestBody.getOtherDetail(
          selectedOptions[0] == -1 ? "" : education[selectedOptions[0]],
          selectedOptions[1] == -1 ? "" : work[selectedOptions[1]],
          selectedOptions[2] == -1
              ? false
              : (relocation[selectedOptions[2]] == "Yes")
                  ? true
                  : false,
        ),
      );

      if (response.isSuccess!) {
        NavigationUtils.openScreen(ScreenRoutes.uploadDocuments);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      // Handle error
    }
  }

  List<Widget> getWidgetByUserType() {
    var user = UserDataHandler.getUserType();
    List<Widget> widget = [];
    switch (user) {
      case "PARTNER":
        widget.add(buildCategory("Education", education, 0));
        break;
      case "AGENT":
        widget.add(buildCategory("Education", education, 0));
        break;
      default:
        widget.add(buildCategory("Education", education, 0));
        widget.add(buildCategory("Work Experience", work, 1));
        widget.add(buildCategory("Are you willing to relocate", relocation, 2));
    }
    return widget;
  }

  Widget buildCategory(String title, List<String> options, int categoryIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
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
      ),
    );
  }

  void updateSelectedIndex(int index, int categoryIndex) {
    setState(() {
      selectedOptions[categoryIndex] = index;
    });
  }
}
