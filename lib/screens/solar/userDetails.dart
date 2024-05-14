import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/State_and_district.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/Uikmulti.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserSolarInfoScreen extends StatefulWidget {
  final dynamic args;
  const UserSolarInfoScreen({super.key, this.args});

  @override
  State<UserSolarInfoScreen> createState() => _UserSolarInfoScreenState();
}

class _UserSolarInfoScreenState extends State<UserSolarInfoScreen> {
  bool bankAccError = false;
  bool bankAccSuccess = false;
  Future<Map<String, dynamic>?>? _futureData;

  StateDataList stateDataList = StateDataList(args: {});
  StateData? state;
  int stateIndex = -1;
  DistrictDataList districtDataList = DistrictDataList();
  DisctrictData? district;
  int districtIndex = -1;
  BlockDataList blockDataList = BlockDataList();
  BlockData? blockData1;
  int block1Index = -1;
  BlockData? blockData2;
  int block2Index = -1;
  BlockData? blockData3;
  int block3Index = -1;
  String firmName = "";
  String gstNo = "";

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});

      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['companyDetails'];
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
              String block1 = userData["block1"] ?? "";
              if (block1.isNotEmpty && dis != -1) {
                await blockDataList.initialize(
                    district: district!.districtCode);
                int bl1 = blockDataList.list
                    .indexWhere((element) => element.blockName == block1);
                if (bl1 != -1) {
                  blockData1 = blockDataList.list[bl1];
                  block1Index = blockDataList.blockNameList.indexOf(block1);
                }
                String block2 = userData["block2"] ?? "";
                if (block2.isNotEmpty) {
                  // await blockDataList.initialize(district: district!.districtCode);
                  int bl2 = blockDataList.list
                      .indexWhere((element) => element.blockName == block2);
                  if (bl2 != -1) {
                    blockData2 = blockDataList.list[bl2];
                    block2Index = blockDataList.blockNameList.indexOf(block2);
                  }
                  String block3 = userData["block3"] ?? "";
                  if (block3.isNotEmpty) {
                    // await blockDataList.initialize(district: district!.districtCode);
                    int bl3 = blockDataList.list
                        .indexWhere((element) => element.blockName == block3);
                    if (bl3 != -1) {
                      blockData3 = blockDataList.list[bl3];
                      block3Index = blockDataList.blockNameList.indexOf(block3);
                    }
                  }
                }
              }
            }
          }
          setState(() {
            firmName = userData['firmName'] ?? '';
            gstNo = userData["gstNumber"] ?? "";
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
    return null;
  }

  @override
  void initState() {
    _futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      persistentFooterButtons: [buildContinueButton(context)],
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle("Fill Your Details", 18, FontWeight.w500),
              TextInputContainer(
                fieldName: "Enter Your Firm Name",
                initialValue: firmName,
                isEnterYourEnabled: false,
                enabled: true,
                showCursor: true,
                onFileSelected: (p0) {
                  setState(() {
                    firmName = p0 ?? "";
                  });
                },
              ),
              TextInputContainer(
                fieldName: "GST Number",
                initialValue: gstNo,
                isEnterYourEnabled: false,
                enabled: true,
                showCursor: true,
                textInputType: TextInputType.number,
                onFileSelected: (p0) {
                  setState(() {
                    gstNo = p0 ?? "";
                  });
                },
              ),
              GestureDetector(
                onTap: () async {
                  int? result = await Bottomsheets.showBottomListDialog(
                    context: context,
                    name: "state",
                    call: () async {
                      // await Future.delayed(
                      //     const Duration(milliseconds: 500));
                      await stateDataList.initialize();
                      return DataForFunction(
                          index: stateIndex, list: stateDataList.stateNameList);
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
                        district = districtDataList.list.firstWhere((element) =>
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
              GestureDetector(
                onTap: () async {
                  if (stateIndex != -1) {
                    if (districtIndex != -1) {
                      int? result = await Bottomsheets.showBottomListDialog(
                        context: context,
                        name: "Block Preference 1",
                        call: () async {
                          await blockDataList.initialize(
                              district: district!.districtCode);
                          return DataForFunction(
                              index: block1Index,
                              list: blockDataList.blockNameList);
                        },
                      );
                      //   print(districtDataList.districtNameList);
                      if (result != null && result >= 0) {
                        setState(() {
                          blockData1 = blockDataList.list.firstWhere(
                              (element) =>
                                  element.blockName ==
                                  blockDataList.blockNameList[result]);
                          block1Index = result;
                        });
                      }
                    } else {
                      UiUtils.showToast("Please Select District");
                    }
                  } else {
                    UiUtils.showToast("Please Select State");
                  }
                },
                child: builbottomsheedtfield("Choose Block Prefernece 1",
                    (blockData1 != null) ? blockData1!.blockName : ""),
              ),
              GestureDetector(
                onTap: () async {
                  if (stateIndex != -1) {
                    if (districtIndex != -1) {
                      if (block1Index != -1) {
                        int? result = await Bottomsheets.showBottomListDialog(
                          context: context,
                          name: "Block Preference 2",
                          call: () async {
                            // await blockDataList.initialize(
                            //     district: district!.districtCode);
                            return DataForFunction(
                                index: block2Index,
                                list: blockDataList.blockNameList);
                          },
                        );
                        //   print(districtDataList.districtNameList);
                        if (result != null && result >= 0) {
                          setState(() {
                            blockData2 = blockDataList.list.firstWhere(
                                (element) =>
                                    element.blockName ==
                                    blockDataList.blockNameList[result]);
                            block2Index = result;
                          });
                        }
                      } else {
                        UiUtils.showToast("Please Select Block 1");
                      }
                    } else {
                      UiUtils.showToast("Please Select District");
                    }
                  } else {
                    UiUtils.showToast("Please Select State");
                  }
                },
                child: builbottomsheedtfield("Choose Block Prefernece 2",
                    (blockData2 != null) ? blockData2!.blockName : ""),
              ),
              GestureDetector(
                onTap: () async {
                  if (stateIndex != -1) {
                    if (districtIndex != -1) {
                      if (block1Index != -1) {
                        if (block2Index != -1) {
                          int? result = await Bottomsheets.showBottomListDialog(
                            context: context,
                            name: "Block Preference 3",
                            call: () async {
                              // await blockDataList.initialize(
                              //     district: district!.districtCode);
                              return DataForFunction(
                                  index: block3Index,
                                  list: blockDataList.blockNameList);
                            },
                          );
                          //   print(districtDataList.districtNameList);
                          if (result != null && result >= 0) {
                            setState(() {
                              blockData3 = blockDataList.list.firstWhere(
                                  (element) =>
                                      element.blockName ==
                                      blockDataList.blockNameList[result]);
                              block3Index = result;
                            });
                          }
                        } else {
                          UiUtils.showToast("Please Select Block 2");
                        }
                      } else {
                        UiUtils.showToast("Please Select Block 1");
                      }
                    } else {
                      UiUtils.showToast("Please Select District");
                    }
                  } else {
                    UiUtils.showToast("Please Select State");
                  }
                },
                child: builbottomsheedtfield("Choose Block Prefernece 3",
                    (blockData3 != null) ? blockData3!.blockName : ""),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContinueButton(BuildContext context) {
    bool allFieldsFilled = firmName.isNotEmpty &&
        gstNo.isNotEmpty &&
        state != null &&
        district != null;

    final Map<String, String> errorMessages = {
      if (firmName.isEmpty) 'firmName': 'Please fill in the firm name field.',
      if (gstNo.isEmpty) 'gstNo': 'Please fill in the GST number field.',
      if (state == null) 'state': 'Please select a state.',
      if (district == null) 'district': 'Please select a district.',
    };
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Submit",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFieldsFilled ? Colors.yellow : Colors.grey,
        onClick: allFieldsFilled
            ? updatedata
            : () {
                for (var message in errorMessages.values) {
                  UiUtils.showToast(message);
                  break;
                }
              },
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

  void updatedata() async {
    try {
      NavigationUtils.openScreen(ScreenRoutes.userSolarInfo2Screen, {
        "firmName": firmName,
        "gstNumber": gstNo,
        "state": state!.stateName,
        "district": district!.districtName,
        "block1": blockData1?.blockName,
        "block2": blockData2?.blockName,
        "block3": blockData3?.blockName,
      });
    } catch (e) {
      UiUtils.showToast("Error In Request");
    }
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
}
