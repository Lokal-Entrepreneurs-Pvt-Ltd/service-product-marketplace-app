import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokal/constants/json_constants.dart';

import 'package:lokal/constants/strings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/State_and_district.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniOtherInfo extends StatefulWidget {
  const ApniOtherInfo({Key? key}) : super(key: key);

  @override
  State<ApniOtherInfo> createState() => _ApniOtherInfoState();
}

enum IndexType { relocate, license }

class _ApniOtherInfoState extends State<ApniOtherInfo> {
  int relocateIndex = -1;
  int bankIndex = -1;

  String preloc = "";
  String currS = "";
  String exepS = "";

  List<String> bike = ["Yes", "No"];
  List<String> license = ["2 Wheeler", "3 Wheeler", "4 Wheeler"];
  List<bool> boollicense = List.generate(3, (index) => false);
  List<String> industryList = ["Delivery", "seller", "Mumbai", "Bangalore"];
  int industryIndex = -1;

  bool isUpdating = false; // Added isUpdating variable

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
      persistentFooterButtons: [
        buildContinueButton(),
      ],
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child:
                        buildTitle("Other Details Bhare", 18, FontWeight.w500),
                  ),
                  buildTitle(
                      "Do you have Driving License?", 16, FontWeight.w500),
                  buildMultiSelectable(license, boollicense, (index) {
                    updateSelectedIndex(index, IndexType.license);
                  }),
                  buildTitle("Want to Relocate", 16, FontWeight.w500),
                  buildSelectable(bike, relocateIndex, (index) {
                    updateSelectedIndex(index, IndexType.relocate);
                  }),
                  SizedBox(height: 10),
                  TextInputContainer(
                    fieldName: "Pereferred Location",
                    hint: "Type your preferred location",
                    onFileSelected: (p0) {
                      setState(() {
                        preloc = p0 ?? "";
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await Bottomsheets.showLocationDialog(
                        context,
                        [],
                        "Current Industry",
                        () async {
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          return DataForFunction(
                              index: industryIndex, list: industryList);
                        },
                      );
                      // Handle the result, e.g., update selectedState
                      if (result != null && result >= 0) {
                        setState(() {
                          industryIndex = result + 1;
                        });
                      }
                      //  _showLocationDialog(context, list);
                    },
                    child: builbottomsheedtfield(
                        "Current Industry",
                        (industryIndex != -1)
                            ? industryList[industryIndex]
                            : ""),
                  ),
                  // builLocationsField(context, stateList, "Current Industry"),
                  TextInputContainer(
                    fieldName: "Current Salary",
                    hint: "Type your current salary",
                    textInputType: TextInputType.number,
                    onFileSelected: (p0) {
                      setState(() {
                        currS = p0 ?? "";
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Expected Salary",
                    hint: "Type your expected salary",
                    textInputType: TextInputType.number,
                    onFileSelected: (p0) {
                      setState(() {
                        exepS = p0 ?? "";
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar()
        ],
      ),
    );
  }

  Widget buildMultiSelectable(
      List<String> list, List<bool> selectedIndex, void Function(int) onTap) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: List.generate(
        list.length,
        (index) => SelectableTextWidget(
          text: list[index],
          isSelected: selectedIndex[index],
          onTap: () => onTap(index),
          border: 0,
        ),
      ),
    );
  }

  Widget buildSelectable(
      List<String> list, int selectedIndex, void Function(int) onTap) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: List.generate(
        list.length,
        (index) => SelectableTextWidget(
          text: list[index],
          isSelected: selectedIndex == index,
          onTap: () => onTap(index),
          border: 0,
        ),
      ),
    );
  }

  Widget builbottomsheedtfield(String name, String selectedname) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
      height: 64,
      decoration: BoxDecoration(
        color: ("#F5F5F5").toColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ("#9E9E9E").toColor(),
                ),
              ),
              (selectedname.isNotEmpty)
                  ? Text(selectedname,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400))
                  : Container()
            ],
          ),
          SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708195274263-chevron-down.svg"),
        ],
      ),
    );
  }

  double calculateProgress() {
    // List of completion status for each field
    List<bool> fieldCompletionStatus = [
      relocateIndex != -1,
      boollicense.any((completed) => completed),
      industryIndex != -1,
      preloc.isNotEmpty,
      currS.isNotEmpty,
      exepS.isNotEmpty,
    ];

    // Calculate progress based on the number of completed fields
    double progress =
        fieldCompletionStatus.where((completed) => completed).length /
            fieldCompletionStatus.length;

    return progress;
  }

  Widget appBar() {
    double progress = calculateProgress();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: UikColor.gengar_300.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: UikColor.gengar_400.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: UikColor.giratina_200.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                height: 5,
                width: progress * 80,
                decoration: BoxDecoration(
                  color: UikColor.gengar_500.toColor(),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: UikColor.giratina_200.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text, double fontSize, FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: CONTINUE,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        //     onClick: updatedata,
        onClick: () async {
          NavigationUtils.openScreen(ScreenRoutes.apniDocumentInfo);
          //   updatedata();
        },
      ),
    );
  }

  void updatedata() async {
    final relocate = (relocateIndex != -1) ? bike[relocateIndex] : null;

    if (relocate != null) {
      setState(() {
        isUpdating = true; // Set isUpdating to true while updating
      });

      try {
        final response = await ApiRepository.updateCustomerInfo(
          {
            "relocate": relocate,
          },
        );

        if (response.isSuccess!) {
          NavigationUtils.openScreen(ScreenRoutes.apniDocumentInfo);
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }
      } catch (e) {
        UiUtils.showToast("Error In Request");
      } finally {
        setState(() {
          isUpdating = false; // Set isUpdating to false after updating
        });
      }
    } else {
      UiUtils.showToast("Please fill in all required fields.");
    }
  }

  void updateSelectedIndex(int index, IndexType indexType) {
    setState(() {
      switch (indexType) {
        case IndexType.relocate:
          relocateIndex = index;
          break;
        case IndexType.license:
          boollicense[index] = !boollicense[index];
          break;
      }
    });
  }

  void updateState() {
    setState(() {});
  }
}
