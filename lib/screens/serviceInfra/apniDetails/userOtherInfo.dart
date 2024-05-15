import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokal/constants/json_constants.dart';

import 'package:lokal/constants/strings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserOtherInfo extends StatefulWidget {
  final dynamic args;
  const UserOtherInfo({Key? key, this.args}) : super(key: key);

  @override
  State<UserOtherInfo> createState() => _UserOtherInfoState();
}

enum IndexType { relocate, license }

class _UserOtherInfoState extends State<UserOtherInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  int relocateIndex = -1;
  String preferredLocation = "";
  String currentSalary = "";
  String expectedSalary = "";
  bool isProgressBarAndContinueFeature = false;

  List<String> relocate = ["Yes", "No"];
  List<String> license = ["2 Wheeler", "3 Wheeler", "4 Wheeler"];
  List<bool> licenseIndex = List.generate(3, (index) => false);
  List<String> industryList = [
    "Delivery",
    "Agriculture",
    "Animal Science",
    "Business ",
    "Cosmetology",
    "Customer Service",
    "Creative",
    "Education",
    "Finance",
    "Healthcare",
    "Hospitality",
    "Human Resources",
    "Sales",
    "IT"
  ];
  int industryIndex = -1;

  bool isUpdating = false; // Added isUpdating variable

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          print(userData["drivingLicence"]);
          setState(() {
            int hasRelocate = userData["relocate"] ?? -1;
            if (hasRelocate != -1) {
              relocateIndex = hasRelocate;
            }
            List<String> licensetype = (List<String>.from(
                json.decode(userData["drivingLicence"] ?? "")));
            if (licensetype.isNotEmpty) {
              for (int i = 0; i < licensetype.length; i++) {
                int index = license.indexOf(licensetype[i]);
                licenseIndex[index] = true;
              }
            }
            preferredLocation = userData["preferredLocation"] ?? "";

            String currentIndustry = userData["currentIndustry"] ?? "";
            if (currentIndustry.isNotEmpty) {
              industryIndex = industryList.indexOf(currentIndustry);
            }
            currentSalary = userData["currentSalary"] ?? "";

            expectedSalary = userData["expectedSalary"] ?? "";
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error fetching initial data");
    }
    setState(() {
      isProgressBarAndContinueFeature = widget.args["isProgress"] ?? false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Conditionally hide the app bar
      body: FutureBuilder<Map<String, dynamic>?>(
        // Use FutureBuilder to wait for the fetchData to complete
        future: _futureData,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the future has completed, build the body with fetched data
            return buildBody();
          } else if (snapshot.hasError) {
            // Handle any errors that occur during data fetching
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            // Show a loading indicator while fetching data
            return buildLoadingIndicator();
          }
        },
      ),
      persistentFooterButtons: [
        buildContinueButton(context)
      ], // Conditionally hide the footer
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
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
                  buildMultiSelectable(license, licenseIndex, (index) {
                    updateSelectedIndex(index, IndexType.license);
                  }),
                  buildTitle("Want to Relocate", 16, FontWeight.w500),
                  buildSelectable(relocate, relocateIndex, (index) {
                    updateSelectedIndex(index, IndexType.relocate);
                  }),
                  const SizedBox(height: 10),
                  TextInputContainer(
                    fieldName: "Pereferred Location",
                    hint: "Type your preferred location",
                    initialValue: preferredLocation,
                    onFileSelected: (p0) {
                      setState(() {
                        preferredLocation = p0 ?? "";
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await Bottomsheets.showBottomListDialog(
                        context: context,
                        name: "Current Industry",
                        call: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          return DataForFunction(
                              index: industryIndex, list: industryList);
                        },
                      );
                      // Handle the result, e.g., update selectedState
                      if (result != null && result >= 0) {
                        setState(() {
                          industryIndex = result;
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
                    initialValue: currentSalary,
                    textInputType: TextInputType.number,
                    onFileSelected: (p0) {
                      setState(() {
                        currentSalary = p0 ?? "";
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Expected Salary",
                    hint: "Type your expected salary",
                    textInputType: TextInputType.number,
                    initialValue: expectedSalary,
                    onFileSelected: (p0) {
                      setState(() {
                        expectedSalary = p0 ?? "";
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          (isProgressBarAndContinueFeature)
              ? Positioned(
                  top: 0, // Stick to the top
                  left: 0,
                  right: 0,
                  child: progressBar(),
                )
              : Container()
        ],
      ),
    );
  }

  double calculateCompletionPercentage() {
    int totalFields = 6; // Update this with the total number of fields
    int completedFields = 0;

    // Check each field's completion status
    if (licenseIndex.contains(true)) completedFields++;
    if (preferredLocation.isNotEmpty) completedFields++;
    if (currentSalary.isNotEmpty) completedFields++;
    if (relocateIndex != -1) completedFields++;
    if (industryIndex != -1) completedFields++;
    if (expectedSalary.isNotEmpty) completedFields++;
    // Add conditions for other fields...

    return completedFields / totalFields;
  }

  Widget progressBar() {
    double completionPercentage = calculateCompletionPercentage();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 1,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 1,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: completionPercentage,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 0,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 0,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding:
          const EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
      height: 64,
      decoration: BoxDecoration(
        color: ("#F5F5F5").toColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UikColor.giratina_300.toColor()),
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

  void updatedata() async {
    if (areAllFieldsSelected()) {
      setState(() {
        isUpdating = true; // Set isUpdating to true while updating
      });

      try {
        final List<String> selectedLicenseIndexes = [];
        for (int i = 0; i < licenseIndex.length; i++) {
          if (licenseIndex[i]) {
            selectedLicenseIndexes.add(license[i]);
          }
        }

        final response = await ApiRepository.updateCustomerInfo(
          {
            "drivingLicence": selectedLicenseIndexes,
            "relocate": relocateIndex,
            "preferredLocation": preferredLocation,
            "currentIndustry": industryList[industryIndex],
            "currentSalary": currentSalary,
            "expectedSalary": expectedSalary
          },
        );

        if (response.isSuccess!) {
          UiUtils.showToast("Other Details Updated");
          if (isProgressBarAndContinueFeature) {
            NavigationUtils.openScreen(
                ScreenRoutes.userDocumentInfo, {"isProgress": true});
          } else {
            NavigationUtils.pop();
          }
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

  bool areAllFieldsSelected() {
    return relocateIndex != -1 &&
        industryIndex != -1 &&
        preferredLocation.isNotEmpty &&
        currentSalary.isNotEmpty &&
        expectedSalary.isNotEmpty;
  }

  Widget buildContinueButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: SAVE_DETAILS,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: areAllFieldsSelected()
            ? Colors.yellow
            : Colors.grey, // Change button color based on field completion
        onClick: () {
          if (areAllFieldsSelected()) {
            updatedata();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fill in all required fields.'),
              ),
            );
          }
        },
      ),
    );
  }

  void updateSelectedIndex(int index, IndexType indexType) {
    setState(() {
      switch (indexType) {
        case IndexType.relocate:
          relocateIndex = index;
          break;
        case IndexType.license:
          licenseIndex[index] = !licenseIndex[index];
          break;
      }
    });
  }

  void updateState() {
    setState(() {});
  }
}
