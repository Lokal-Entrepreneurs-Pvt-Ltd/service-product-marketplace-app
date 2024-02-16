import 'package:flutter/material.dart';
import 'package:lokal/constants/json_constants.dart';

import 'package:lokal/constants/strings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniOtherInfo extends StatefulWidget {
  const ApniOtherInfo({Key? key}) : super(key: key);

  @override
  State<ApniOtherInfo> createState() => _ApniOtherInfoState();
}

enum IndexType { relocate, license }

class _ApniOtherInfoState extends State<ApniOtherInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  TextEditingController controller = TextEditingController();
  int relocateIndex = -1;
  int bankIndex = -1;
  String selectedState = "Select Industry";
  TextEditingController locationController = TextEditingController();
  TextEditingController currentSalayController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();

  List<String> bike = ["Yes", "No"];
  List<String> license = ["2 Wheeler", "3 Wheeler", "4 Wheeler"];
  List<bool> boollicense = List.generate(3, (index) => false);
  List<String> stateList = ["Delivery", "seller", "Mumbai", "Bangalore"];

  bool isUpdating = false; // Added isUpdating variable

  // Future<Map<String, dynamic>?> fetchData() async {
  //   try {
  //     final response = await ApiRepository.getUserProfile({});
  //     if (response.isSuccess!) {
  //       final userDataMagento = response.data;
  //       final userData = response.data?['userModelData'];
  //       if (userData != null) {
  //         setState(() {
  //           controller.text = userDataMagento['firstName'] ?? '';
  //           datePicker = userDataMagento['dob'] != null
  //               ? DateTime.parse(userDataMagento['dob'])
  //               : DateTime.now();
  //           lat = userData['latitude'] ?? 0;
  //           long = userData['longitude'] ?? 0;
  //           // Assuming gender is either "Male" or "Female"
  //           genderIndex = userData['gender'] == "Male" ? 0 : 1;
  //         });
  //       }
  //     } else {
  //       UiUtils.showToast(response.error![MESSAGE]);
  //     }
  //   } catch (e) {
  //     print(e);
  //     UiUtils.showToast("Error fetching initial data");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //   _futureData = fetchData(); // Call fetchData when the widget is initialized
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
      child: Stack(children: [
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle("Other Details Bhare", 24, FontWeight.w600),
                buildTitle("Do you have Driving License?", 16, FontWeight.w500),
                buildMultiSelectable(license, boollicense, (index) {
                  updateSelectedIndex(index, IndexType.license);
                }),
                buildTitle("Want to Relocate", 16, FontWeight.w500),
                buildSelectable(bike, relocateIndex, (index) {
                  updateSelectedIndex(index, IndexType.relocate);
                }),
                SizedBox(height: 10),
                buildTextBox("Pereferred Location",
                    "Type your preferred location", locationController),
                builLocationsField(context, stateList, "Current Industry"),
                buildTextBox("Current Salary", "Type your current salary",
                    currentSalayController),
                buildTextBox("Expected Salary", "Type your expected salary",
                    expectedSalaryController),
              ],
            ),
          ),
        ),
        appBar()
      ]),
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

  Widget builLocationsField(
      BuildContext context, List<String> list, String name) {
    return GestureDetector(
      onTap: () {
        _showLocationDialog(context, list);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.only(top: 9.5, left: 16, right: 16),
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
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedState,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    //  Icon(Icons.chevron_right),
                  ],
                )
              ],
            ),
            Icon(Icons.location_searching_outlined),
          ],
        ),
      ),
    );
  }

  Future<void> _showLocationDialog(
      BuildContext context, List<String> list) async {
    return showModalBottomSheet<void>(
      backgroundColor: UikColors.WHITE,
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Your Current State",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    child: Icon(Icons.dangerous_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: TextFormField(
                controller: controller,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: "Search State",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                scribbleEnabled: false,
                onTap: () => updateState(),
                onFieldSubmitted: (_) => updateState(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length, // Change the itemCount as needed
                itemBuilder: (BuildContext context, int index) {
                  return _buildLocationItem(
                      context, list[index], index % 2 == 0);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationItem(
      BuildContext context, String state, bool isLightGrey) {
    return Container(
      color: isLightGrey ? Colors.grey[200] : Colors.white,
      child: ListTile(
        title: Text(state),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            selectedState = state;
          });
        },
      ),
    );
  }

  Widget appBar() {
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
                color: UikColor.gengar_500.toColor(),
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

  Widget buildTextBox(String fieldname, String hint,
      TextEditingController textEditingController) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(top: 9.5, left: 16, right: 16),
      height: 64,
      decoration: BoxDecoration(
        color: ("#F5F5F5").toColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldname,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ("#9E9E9E").toColor(),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: TextFormField(
              showCursor: false,
              controller: textEditingController,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
              scribbleEnabled: false,
              onTap: () => updateState(),
              onFieldSubmitted: (_) => updateState(),
            ),
          ),
        ],
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
        onClick: () {
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
