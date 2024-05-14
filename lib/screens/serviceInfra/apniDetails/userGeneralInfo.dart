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
import 'package:ui_sdk/utils/extensions.dart';

import '../../../constants/json_constants.dart';
import '../../../utils/network/ApiRepository.dart';

class UserGeneralInfo extends StatefulWidget {
  final dynamic args;
  const UserGeneralInfo({Key? key, this.args}) : super(key: key);

  @override
  State<UserGeneralInfo> createState() => _UserGeneralInfoState();
}

enum IndexType { bike, bank }

class _UserGeneralInfoState extends State<UserGeneralInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  int bikeIndex = -1;
  int bankIndex = -1;
  String home = "";
  String road = "";

  List<String> bike = ["Yes", "No"];
  List<String> bank = ["Yes", "No"];
  StateDataList stateDataList = StateDataList(args: {});
  StateData? state;
  int stateIndex = -1;
  DistrictDataList districtDataList = DistrictDataList();
  DisctrictData? district;
  int districtIndex = -1;
  List<String> villageList = ["Rajasthan", "Pakistan", "Mumbai", "Bangalore"];
  int villageIndex = -1;
  bool isProgressBarAndContinueFeature = false;

  bool isUpdating = false; // Added isUpdating variable

  @override
  void initState() {
    super.initState();
    _futureData = fetchData(); // Call fetchData when the widget is initialized
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});

      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          String stateName = userData["state"] ?? "";
          await stateDataList.initialize();
          if (stateName.isNotEmpty) {
            int sra = stateDataList.list
                .indexWhere((element) => element.stateName == stateName);
            if (sra != -1) {
              state = stateDataList.list[sra];
              stateIndex = stateDataList.stateNameList.indexOf(stateName);
            }
            String districtName = userData["district"] ?? "";
            if (districtName.isNotEmpty && sra != -1) {
              await districtDataList.initialize(stateCode: state!.stateCode);
              int dis = districtDataList.list.indexWhere(
                  (element) => element.districtName == districtName);
              if (dis != -1) {
                district = districtDataList.list[dis];
                districtIndex =
                    districtDataList.districtNameList.indexOf(districtName);
              }
            }
          }

          setState(() {
            int hasbike = userData["hasBike"] ?? -1;
            if (hasbike != -1) {
              bikeIndex = hasbike;
            }
            int bankAvailable = userData["hasBankAccount"] ?? -1;
            if (bankAvailable != -1) {
              bankIndex = bankAvailable;
            }
            home = userData["homeAddress"] ?? "";
            road = userData["roadAddress"] ?? "";
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
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
            return isUpdating ? buildLoadingIndicator() : buildBody();
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
      persistentFooterButtons: isUpdating
          ? null
          : [buildContinueButton(context)], // Conditionally hide the footer
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  double calculateCompletionPercentage() {
    int totalFields = 6; // Update this with the total number of fields
    int completedFields = 0;

    // Check each field's completion status
    if (bikeIndex != -1) completedFields++;
    if (home.isNotEmpty) completedFields++;
    if (road.isNotEmpty) completedFields++;
    if (bankIndex != -1) completedFields++;
    if (state != null) completedFields++;
    if (district != null) completedFields++;
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
                    child: buildTitle(
                        "General Details Bhare", 18, FontWeight.w500),
                  ),
                  buildTitle("Do you have a Bike?", 16, FontWeight.w500),
                  buildSelectable(bike, bikeIndex, (index) {
                    updateSelectedIndex(index, IndexType.bike);
                  }),
                  buildTitle("Do you have Bank Accont?", 16, FontWeight.w500),
                  buildSelectable(bank, bankIndex, (index) {
                    updateSelectedIndex(index, IndexType.bank);
                  }),
                  buildTitle("Permanent Addresses", 16, FontWeight.w500),
                  GestureDetector(
                    onTap: () async {
                      int? result = await Bottomsheets.showBottomListDialog(
                        context: context,
                        name: "state",
                        call: () async {
                          // await Future.delayed(
                          //     const Duration(milliseconds: 500));
                          return DataForFunction(
                              index: stateIndex,
                              list: stateDataList.stateNameList);
                        },
                      );
                      if (result != null && result >= 0) {
                        setState(() {
                          state = stateDataList.list.firstWhere((element) =>
                              element.stateName ==
                              stateDataList.stateNameList[result]);
                          stateIndex = result;
                          districtIndex = -1;
                          district = null;
                        });
                      }
                    },
                    child: builbottomsheedtfield(
                      "State",
                      (state != null) ? state!.stateName : "",
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (stateIndex != -1) {
                        int? result = await Bottomsheets.showBottomListDialog(
                          context: context,
                          name: "District",
                          call: () async {
                            await districtDataList.initialize(
                                stateCode: state!.stateCode);
                            return DataForFunction(
                                index: districtIndex,
                                list: districtDataList.districtNameList);
                          },
                        );
                        //   print(districtDataList.districtNameList);
                        if (result != null && result >= 0) {
                          setState(() {
                            district = districtDataList.list.firstWhere(
                                (element) =>
                                    element.districtName ==
                                    districtDataList.districtNameList[result]);
                            districtIndex = result;
                          });
                        }
                      } else {
                        UiUtils.showToast("Please Select State");
                      }
                    },
                    child: builbottomsheedtfield("District",
                        (district != null) ? district!.districtName : ""),
                  ),
                  TextInputContainer(
                    fieldName: "Home No, Building Name",
                    hint: "Type your address",
                    initialValue: home,
                    onFileSelected: (p0) {
                      setState(() {
                        home = p0 ?? "";
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Road name, Area, Colony",
                    hint: "Type your address",
                    initialValue: road,
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

  Widget builbottomsheedtfield(String name, String selectedname) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
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

  bool areAllFieldsSelected() {
    return bikeIndex != -1 &&
        bankIndex != -1 &&
        stateIndex != -1 &&
        districtIndex != -1 &&
        home.isNotEmpty &&
        road.isNotEmpty;
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

  void updatedata() async {
    if (areAllFieldsSelected()) {
      setState(() {
        isUpdating = true; // Set isUpdating to true while updating
      });
      try {
        final response = await ApiRepository.updateCustomerInfo(
          {
            "hasBike": bikeIndex,
            "hasBankAccount": bankIndex,
            "state": state!.stateName,
            "district": district!.districtName,
            "homeAddress": home,
            "roadAddress": road
          },
        );

        if (response.isSuccess!) {
          print(state!.stateName);
          print(district!.districtName);
          UiUtils.showToast("General Details Updated");
          if (isProgressBarAndContinueFeature) {
            NavigationUtils.openScreen(
                ScreenRoutes.userOtherInfo, {"isProgress": true});
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
