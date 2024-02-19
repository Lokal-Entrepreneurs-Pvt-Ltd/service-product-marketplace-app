import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/State_and_district.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniGeneralInfo extends StatefulWidget {
  const ApniGeneralInfo({Key? key}) : super(key: key);

  @override
  State<ApniGeneralInfo> createState() => _ApniGeneralInfoState();
}

enum IndexType { bike, bank }

class _ApniGeneralInfoState extends State<ApniGeneralInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  int bikeIndex = -1;
  int bankIndex = -1;
  String home = "";
  String road = "";

  List<String> bike = ["Yes", "No"];
  StateDataList stateDataList = StateDataList(args: {});
  int stateIndex = -1;
  DistrictDataList districtDataList = DistrictDataList();
  int districtIndex = -1;
  List<String> villageList = ["Rajasthan", "Pakistan", "Mumbai", "Bangalore"];
  int villageIndex = -1;

  bool isUpdating = false; // Added isUpdating variable

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
                Padding(
                  padding: const EdgeInsets.only(top: 21),
                  child:
                      buildTitle("General Details Bhare", 18, FontWeight.w500),
                ),
                buildTitle("Do you have a Bike?", 16, FontWeight.w500),
                buildSelectable(bike, bikeIndex, (index) {
                  updateSelectedIndex(index, IndexType.bike);
                }),
                buildTitle("Do you have Bank Accont?", 16, FontWeight.w500),
                buildSelectable(bike, bankIndex, (index) {
                  updateSelectedIndex(index, IndexType.bank);
                }),
                buildTitle("Permanent Addresses", 16, FontWeight.w500),
                GestureDetector(
                  onTap: () async {
                    int? result = await Bottomsheets.showLocationDialog(
                      context,
                      stateDataList.stateNameList,
                      "State",
                      () async {
                        await stateDataList.initialize();
                        return DataForFunction(
                            index: stateIndex,
                            list: stateDataList.stateNameList);
                      },
                    );
                    if (result != null && result >= 0) {
                      setState(() {
                        stateIndex = result;
                      });
                    }
                  },
                  child: builbottomsheedtfield(
                      "State",
                      (stateIndex != -1)
                          ? stateDataList.stateNameList[stateIndex]
                          : ""),
                ),
                GestureDetector(
                  onTap: () async {
                    if (stateIndex != -1) {
                      int? result = await Bottomsheets.showLocationDialog(
                        context,
                        stateDataList.stateNameList,
                        "District",
                        () async {
                          await districtDataList
                              .initialize(args: {"stateCode": stateIndex});
                          return DataForFunction(
                              index: districtIndex,
                              list: districtDataList.districtNameList);
                        },
                      );
                      print(districtDataList.districtNameList);
                      if (result != null && result >= 0) {
                        setState(() {
                          districtIndex = result;
                        });
                      }
                    } else {
                      UiUtils.showToast("Please Select State");
                    }
                  },
                  child: builbottomsheedtfield(
                      "District",
                      (districtIndex != -1)
                          ? districtDataList.districtNameList[districtIndex]
                          : ""),
                ),
                GestureDetector(
                  onTap: () async {
                    if (districtIndex != -1) {
                      int? result = await Bottomsheets.showLocationDialog(
                        context,
                        stateDataList.stateNameList,
                        "District",
                        () async {
                          Future.delayed(const Duration(milliseconds: 500));
                          return DataForFunction(
                              index: villageIndex, list: villageList);
                        },
                      );
                      if (result != null && result >= 0) {
                        setState(() {
                          villageIndex = result;
                        });
                      }
                    } else {
                      UiUtils.showToast("Please Select District");
                    }
                  },
                  child: builbottomsheedtfield("Village",
                      (villageIndex != -1) ? villageList[villageIndex] : ""),
                ),
                TextInputContainer(
                  fieldName: "Home No, Building Name",
                  hint: "Type your address",
                  onFileSelected: (p0) {
                    setState(() {
                      home = p0 ?? "";
                    });
                  },
                ),
                TextInputContainer(
                  fieldName: "Road name, Area, Colony",
                  hint: "Type your address",
                  onFileSelected: (p0) {
                    setState(() {
                      road = p0 ?? "";
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        appBar()
      ]),
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

  double calculateProgress() {
    // List of completion status for each field
    List<bool> fieldCompletionStatus = [
      bikeIndex != -1,
      bankIndex != -1,
      stateIndex != -1,
      villageIndex != -1,
      districtIndex != -1,
      home.isNotEmpty,
      road.isNotEmpty
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
        onClick: () {
          NavigationUtils.openScreen(ScreenRoutes.apniOtherInfo);
        },
      ),
    );
  }

  // void updatedata() async {
  //   final name = controller.text;

  //   String gender;
  //   if (bikeIndex == 0) {
  //     gender = "Male";
  //   } else if (bikeIndex == 1) {
  //     gender = "Female";
  //   } else {
  //     // Handle the case where no gender is selected or other possible values
  //     gender = ""; // You can change this default value as needed
  //   }
  //   if (name.isNotEmpty && dob.isNotEmpty ) {
  //     setState(() {
  //       isUpdating = true; // Set isUpdating to true while updating
  //     });

  //     try {
  //       final response = await ApiRepository.updateCustomerInfo(
  //         ApiRequestBody.getPersonalDetail(name, dob),
  //       );

  //       if (response.isSuccess!) {
  //         NavigationUtils.openScreen(ScreenRoutes.otherdetails);
  //       } else {
  //         UiUtils.showToast(response.error![MESSAGE]);
  //       }
  //     } catch (e) {
  //       UiUtils.showToast("Error In Request");
  //     } finally {
  //       setState(() {
  //         isUpdating = false; // Set isUpdating to false after updating
  //       });
  //     }
  //   } else {
  //     UiUtils.showToast("Please fill in all required fields.");
  //   }
  // }

  void updateSelectedIndex(int index, IndexType indexType) {
    setState(() {
      switch (indexType) {
        case IndexType.bike:
          bikeIndex = index;
          break;
        case IndexType.bank:
          bankIndex = index;
          break;
      }
    });
  }

  void updateState() {
    setState(() {});
  }
}
