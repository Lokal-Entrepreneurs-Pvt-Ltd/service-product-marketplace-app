import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/solar/addNewLeads/fieldData.dart';
import 'package:lokal/utils/NavigationUtils.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/State_and_district.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/Uikmulti.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class FieldScreen extends StatefulWidget {
  final String routeParams;
  final dynamic args;
  const FieldScreen({Key? key, this.args, required this.routeParams})
      : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final dataFunctions = {
    "state": () => {"list": StateDataList(args: {}), "index": -1, "data": null},
    "district": () => {"list": DistrictDataList(), "index": -1, "data": null},
    "block": () => {"list": BlockDataList(), "index": -1, "data": null},
  };
  Map<String, dynamic> filterLocationData(Map<String, dynamic> list) {
    final filteredEntries = list.entries.where((e) =>
        e.value["id"] == "state" ||
        e.value["id"] == "district" ||
        e.value["id"] == "block");

    final data = <String, dynamic>{};

    for (final entry in filteredEntries) {
      final id = entry.value["id"];
      if (dataFunctions.containsKey(id)) {
        data[entry.key] = dataFunctions[id]!();
      }
    }

    return data;
  }

  Future? _futureData;
  Map<String, String?> error = {};
  double lat = 0;
  double long = 0;
  Placemark? place;
  bool locationLoading = false;
  Map<String, dynamic> locationData = {};
  late Map<String, dynamic> variableData;
  late Map<String, bool> mandatoryfield;
  late Map<String, dynamic> joinTo = {};
  Map<String, dynamic> mainMap = {};

  fetchData() async {
    try {
      Map<String, dynamic> responses = {};
      for (String endpoint in api.keys) {
        final response =
            await ApiRepository.fieldScreenApi(endpoint, api[endpoint]["args"]);
        if (response.isSuccess!) {
          responses[endpoint] = response.data;
        } else {
          print("Error fetching data from $endpoint: ${response.isSuccess}");
        }
      }
      if (mounted) {
        setState(() {
          for (String endpoint in responses.keys) {
            Map<String, dynamic> mappings = api[endpoint]["populate"];
            for (String boxKey in mappings.keys) {
              Map<String, dynamic>? dataValues = mappings[boxKey];
              String? value = dataValues?["value"];
              String? type = dataValues?["type"];
              switch (type) {
                case "string":
                  var values =
                      FieldData.getDataFromPath(responses[endpoint], value);
                  list[boxKey]["initData"] = values;
                  variableData[boxKey] = values;
                  break;
                case "state":
                default:
              }
            }
          }
        });
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error fetching initial data");
    }
  }

  Map<String, dynamic> api = {};
  Map<String, dynamic> list = {};
  Map<String, dynamic> selectableMap = {};
  List<Widget> widgetList = [];

  mapProcessing(Map<String, dynamic> bodyMap) {
    variableData = {for (var key in list.keys) key: null};
    mandatoryfield = {
      for (var key in list.keys) key: list[key]["isMandatory"] ?? false
    };
    api = mainMap["api"] ?? {};
    for (var element in bodyMap.entries) {
      final key = element.key;
      final id = element.value["id"];
      final errorText = element.value?["errorText"];
      final type = element.value["type"];
      final validation = element.value["validation"];
      final name = element.value["name"];
      final hint = element.value["hint"];
      final text = element.value["text"];
      final dependency = element.value["dependency"];
      final function = element.value["function"];
      final populateTo = element.value["populateTo"];
      final isSingleSelected = element.value["isSingleSelected"];
      final lists = element.value["list"];
      final joinToData = element.value["joinTo"];
      WidgetType widgetType = FieldData.getWidgetType(id);
      switch (widgetType) {
        case WidgetType.textInputContainer:
          // testInputContainerMap[key] = bodyMap[key];
          if (joinToData != null) {
            joinTo[key] = joinToData;
          }
          break;
        case WidgetType.locationBox:
          break;
        case WidgetType.state:
          locationData[key] = dataFunctions[id]!();
          break;
        case WidgetType.district:
          locationData[key] = dataFunctions[id]!();
          break;
        case WidgetType.block:
          locationData[key] = dataFunctions[id]!();
          break;
        case WidgetType.selectionBox:
          break;
        case WidgetType.selectableBox:
          //    if (isSingleSelected!= null &&
          //     isSingleSelected == false) {
          //   selectableMap[key] =
          //       List.generate(lists.length, (index) => false);
          // } else {
          //   selectableMap[key] = entry.value["data"] ?? null;
          // }

          break;
        case WidgetType.uploadBox:
          break;
        default:
          throw Exception("Invalid widget type");
      }
    }
  }

  // Widget wrapper(Map<String, dynamic> values, Widget child) {
  //   String dependentOnAtWork = values.toString();
  //   return Visibility(
  //     key: ValueKey(dependentOnAtWork),
  //     visible: values.containsKey("visibility")
  //         ? variableData[values["visibility"]] ?? true
  //         : true,
  //     child: child,
  //   );
  // }

  @override
  void initState() {
    super.initState();

    mainMap = FieldScreenData.mainData(widget.routeParams ?? "");
    list = mainMap["body"];
    mapProcessing(list);
    // variableData = {for (var key in list.keys) key: null};
    // mandatoryfield = {
    //   for (var key in list.keys) key: list[key]["isMandatory"] ?? false
    // };
    // api = mainMap["api"] ?? {};
    // locationData = filterLocationData(list);
    // final filteredEntries =
    //     list.entries.where((e) => e.value["id"] == "selectableBox");
    // for (final entry in filteredEntries) {
    //   if (entry.value["isSingleSelected"] != null &&
    //       entry.value["isSingleSelected"] == false) {
    //     selectableMap[entry.key] =
    //         List.generate(entry.value["list"].length, (index) => false);
    //   } else {
    //     selectableMap[entry.key] = entry.value["data"] ?? null;
    //   }
    // }
    // final joinToEntries = list.entries.where((e) =>
    //     e.value["id"] == "textInputContainer" &&
    //     e.value.keys.contains("joinTo"));
    // for (final entry in joinToEntries) {
    //   joinTo[entry.key] = entry.value["joinTo"];
    // }
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Conditionally hide the app bar
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            NavigationUtils.pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1715678068186-shape.svg",
              height: 16,
              width: 20,
            ),
          ),
        ),
        title: Text(
          mainMap["appBar"]["text"],
          style: TextStyles.poppins.body0.medium,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
      persistentFooterButtons: (mainMap["footer"] != null)
          ? [
              Column(
                children: [
                  buildContinueButton(),
                ],
              )
            ]
          : null, // Conditionally hide the footer
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUploadButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildUploadButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list.entries.map((entry) {
        String dependentOnAtWork = entry.value.toString();

        return Visibility(
          key: ValueKey(dependentOnAtWork),
          visible: entry.value.containsKey("visibility")
              ? variableData[entry.value["visibility"]] ?? true
              : true,
          child: widgetFromList(
            entry.value["id"],
            entry.value,
            entry.key,
          ),
        );
      }).toList(),
    );
  }

  Container buildContinueButton() {
    bool allFilesUploaded = variableData.values.every((file) => file != null);
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Continue",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFilesUploaded ? Colors.yellow : Colors.grey,
        onClick: () {
          allFilesUploaded ? updatedata() : errorMessage();
        },
      ),
    );
  }

  errorMessage() {
    List<String> missingFiles = variableData.entries
        .where((entry) => entry.value == null)
        .map((entry) => entry.key)
        .toList();

    UiUtils.showToast(list[missingFiles[0]]["errorText"] ?? "Please fix error");
  }

  Widget widgetFromList(String id, Map value, String key) {
    WidgetType widgetType = FieldData.getWidgetType(id);

    switch (widgetType) {
      case WidgetType.textInputContainer:
        return buildTextInputContainer(value, key);
      case WidgetType.locationBox:
        return buildLocationBox(value["text"]);
      case WidgetType.state:
        return buildState(value, key);
      case WidgetType.district:
        return buildDistrict(value, key);
      case WidgetType.block:
        return buildBlock(value, key);
      case WidgetType.selectionBox:
        return buildSelectionBox(value, key);
      case WidgetType.selectableBox:
        return buildSelectableBox(value, key);
      case WidgetType.uploadBox:
        return buildUploadBox(value, key);
      default:
        throw Exception("Invalid widget type");
    }
  }

  Widget buildTextInputContainer(Map value, String key) {
    return TextInputContainer(
      fieldName: value["name"],
      hint: value["hint"] ?? "",
      initialValue: value["initData"] ?? variableData[key] ?? "",
      enabled: value["enabled"] ?? true,
      showCursor: true,
      textInputType: value["type"] != null
          ? (value["type"] == "number")
              ? TextInputType.phone
              : (value["type"] == "email")
                  ? TextInputType.emailAddress
                  : (value["type"] == "datetime")
                      ? TextInputType.datetime
                      : null
          : null,
      isEnterYourEnabled: false,
      errorText: error.containsKey(key) ? error[key] : null,
      onFileSelected: (p0) {
        if (value.containsKey("validation")) {
          bool validationResult =
              FieldData.validationLogic(value["validation"], p0);
          error[key] = validationResult ? null : value["errorText"] ?? "";
          setState(() {});
          if (!validationResult) {
            variableData[key] = null;
            return;
          }
        }
        if (value.containsKey("function") &&
            value["function"] == "updateBankInfo") {
          updateBankName(variableData[key], p0!, value["populateTo"]);
        }
        variableData[key] = p0?.isEmpty ?? true ? null : p0;
        setState(() {});
      },
    );
  }

  Widget buildLocationBox(String text) {
    return buildLocationField(text);
  }

  Widget buildState(Map value, String key) {
    return GestureDetector(
      onTap: () async {
        int? result = await Bottomsheets.showBottomListDialog(
          context: context,
          name: value["text"],
          call: () async {
            await locationData[key]["list"].initialize();
            return DataForFunction(
                index: locationData[key]["index"],
                list: locationData[key]["list"].stateNameList);
          },
        );
        if (result != null && result >= 0) {
          setState(() {
            locationData[key]["data"] = locationData[key]["list"]
                .list
                .firstWhere((element) =>
                    element.stateName ==
                    locationData[key]["list"].stateNameList[result]);
            locationData[key]["index"] = result;
            variableData[key] = locationData[key]["data"].stateName;
            final matchingEntries = locationData.entries
                .where((entry) => entry.value["id"] == "district");
            for (var element in matchingEntries) {
              if (list[element.key]["dependency"] == key) {
                locationData[element.key] = dataFunctions["district"];
              }
            }
          });
        }
      },
      child: builbottomsheedtfield(
        value["text"],
        locationData[key]["data"]?.stateName ?? "",
      ),
    );
  }

  Widget buildDistrict(Map value, String key) {
    return GestureDetector(
      onTap: () async {
        if (locationData[value["dependency"]]["index"] != -1) {
          int? result = await Bottomsheets.showBottomListDialog(
            context: context,
            name: value["text"],
            call: () async {
              await locationData[key]["list"].initialize(
                  stateCode:
                      locationData[value["dependency"]]["data"]!.stateCode);
              return DataForFunction(
                  index: locationData[key]["index"],
                  list: locationData[key]["list"].districtNameList);
            },
          );
          if (result != null && result >= 0) {
            setState(() {
              locationData[key]["data"] = locationData[key]["list"]
                  .list
                  .firstWhere((element) =>
                      element.districtName ==
                      locationData[key]["list"].districtNameList[result]);
              locationData[key]["index"] = result;
              variableData[key] = locationData[key]["data"].districtName;
            });
          }
        } else {
          UiUtils.showToast("Please Select State");
        }
      },
      child: builbottomsheedtfield(
        value["text"],
        locationData[key]["data"]?.districtName ?? "",
      ),
    );
  }

  Widget buildBlock(Map value, String key) {
    return GestureDetector(
      onTap: () async {
        if (locationData[value["stateDependency"]]["index"] != -1) {
          if (locationData[value["districtDependency"]]["index"] != -1) {
            int? result = await Bottomsheets.showBottomListDialog(
              context: context,
              name: value["text"],
              call: () async {
                await locationData[key]["list"].initialize(
                    district: locationData[value["districtDependency"]]["data"]!
                        .districtCode);
                return DataForFunction(
                    index: locationData[key]["index"],
                    list: locationData[key]["list"].blockNameList);
              },
            );
            if (result != null && result >= 0) {
              setState(() {
                locationData[key]["data"] = locationData[key]["list"]
                    .list
                    .firstWhere((element) =>
                        element.blockName ==
                        locationData[key]["list"].blockNameList[result]);
                locationData[key]["index"] = result;
              });
            }
          } else {
            UiUtils.showToast("Please Select District");
          }
        } else {
          UiUtils.showToast("Please Select State");
        }
      },
      child: builbottomsheedtfield(
        value["text"],
        locationData[key]["data"]?.blockName ?? "",
      ),
    );
  }

  Widget buildSelectionBox(Map value, String key) {
    return UikMulti<int>(
      onOptionSelected: (List<ValueItem<int>> selectedOptions) {
        setState(() {
          variableData[key] = selectedOptions;
        });
      },
      hint: value["hint"],
      options: (value["list"] as List<String>)
          .map((e) =>
              ValueItem(label: e, value: value["list"].indexOf(e) as int))
          .toList(),
      borderWidth: 1,
      selectedOptions: variableData[key] ?? [],
      selectionType: value["isSingleSelected"] != null
          ? value["isSingleSelected"]
              ? SelectionType.single
              : SelectionType.multi
          : SelectionType.single,
      chipConfig: ChipConfig(
        runSpacing: 8,
        deleteIcon: const Icon(
          Icons.close,
          size: 20,
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
        wrapType: WrapType.wrap,
        backgroundColor: ("#FEE440").toColor(),
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      singleSelectItemStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      dropdownHeight: 300,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ("#9E9E9E").toColor(),
      ),
      fieldBackgroundColor: ("#F5F5F5").toColor(),
      borderColor: UikColor.giratina_300.toColor(),
      optionTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      selectedOptionIcon: const Icon(Icons.check_circle),
      suffixIcon: SvgPicture.network(
          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708195274263-chevron-down.svg"),
      animateSuffixIcon: true,
      searchEnabled: true,
      dropdownBorderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      maxItems: value["maxItems"] ?? null,
    );
  }

  Widget buildSelectableBox(Map value, String key) {
    List<dynamic> selectableList = value["list"];
    bool isSingleSelected = value["isSingleSelected"];
    // List<String> initialSelectedList = variableData[key];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(value["text"], 16, FontWeight.w400),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: List.generate(selectableList.length, (index) {
              return SelectableTextWidget(
                text: selectableList[index],
                isSelected: isSingleSelected
                    ? variableData[key] != null
                        ? selectableMap[key] == index
                        : false
                    : selectableMap[key][index],
                onTap: isSingleSelected
                    ? () {
                        selectableMap[key] = index;
                        variableData[key] = selectableList[index];
                        setState(() {});
                      }
                    : () {
                        selectableMap[key][index] = !selectableMap[key][index];
                        final value = [];
                        for (int i = 0; i < selectableMap[key].length; i++) {
                          if (selectableMap[key][i]) {
                            value.add(selectableList[i]);
                          }
                        }
                        variableData[key] = value.isEmpty ? null : value;
                        setState(() {});
                      },
                border: 2,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildUploadBox(Map value, String key) {
    final isDigiBased = value["isDigiBased"] ?? false;
    return UploadButton(
      text: value["text"],
      imageUrl: variableData[key] ?? "",
      documentType: "misc",
      leading: SvgPicture.network(
          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1717408728433-Upload.svg"),
      uploadMethod:
          isDigiBased ? UploadMethod.CustomFunction : UploadMethod.FilePicker,
      onFileSelected: (pickedFile) async {
        setState(() {
          variableData[key] = pickedFile;
        });
      },
      customFunction: () {
        if (variableData[key] != null) {
          UiUtils.launchURL(variableData[key]!);
        } else {
          fetchDigiData();
        }
      },
    );
  }

  void updateBankName(
      String? ifscPrev, String ifsc, List<String> populateTo) async {
    if (ifscPrev != null && ifscPrev.compareTo(ifsc) == 0) {
      return;
    }
    if (ifsc.length == 11) {
      var response = await ApiRepository.getBankDetailsByIfsc(ifsc);
      if (response != null) {
        setState(() {
          for (var element in populateTo) {
            variableData[element] = response["BANK"] + ", " + response["CITY"];
            list[element]["initData"] = variableData[element];
          }
        });
      }
    }
  }

  fetchDigiData() async {
    String? xyz;
    String decentroId = "";
    try {
      final response = await ApiRepository.initiateDigiLocker({});
      if (response.isSuccess!) {
        decentroId = response.data["decentroTxnId"] ?? "";
        String decentroUrl = response.data["data"]["authorizationUrl"] ?? "";
        if (decentroUrl.isNotEmpty) {
          xyz = await NavigationUtils.openAsyncScreen(
              ScreenRoutes.webViewScreen, {
            "url": decentroUrl,
            "popLink":
                "https://in.staging.decentro.tech/kyc/digilocker/digilocker-code",
            "title": "Authenticate Yourself"
          });
        }
      }
    } catch (e) {
      UiUtils.showToast("Process Failed, Try Again");
    }
    try {
      if (xyz != null) {
        await NavigationUtils.showLoaderOnTop();
        final uri = Uri.parse(xyz);
        final queryParams = uri.queryParameters;
        final code = queryParams['code'];
        final state = queryParams['state'];
        final response2 = await ApiRepository.getAccessTokenFromDigiLocker(
            {"code": code, "state": state});
        if (response2.isSuccess!) {
          String decentroTxnId = response2.data["decentroTxnId"] ?? "";
          String message = response2.data["message"] ?? "";
          UiUtils.showToast(message);
          final response3 =
              await ApiRepository.getIssuedFilesFromFromDigiLocker({
            "initial_decentro_transaction_id": decentroId,
            "consent": true
          });
          if (response3.isSuccess!) {
            NavigationUtils.pushAndPopUntil(
                ScreenRoutes.userDocumentInfo, ScreenRoutes.userDocumentInfo);
          } else {
            UiUtils.showToast("Try Again Some error occured");
          }
          print("works");
        }
      }
    } catch (e) {
      UiUtils.showToast(e.toString());
    } finally {
      await NavigationUtils.showLoaderOnTop(false);
    }
  }

  Widget buildTitle(String text, double fontSize, FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget builbottomsheedtfield(String name, String selectedname) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding:
          const EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
      height: 64,
      decoration: BoxDecoration(
          color: ("#F5F5F5").toColor(),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: UikColor.giratina_300.toColor(),
            width: 1,
          )),
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

  Widget buildLocationField(String text) {
    // Check if latitude and longitude values exist
    bool locationAvailable = (lat != 0 && long != 0);

    return GestureDetector(
      onTap: () => getLocation(),
      child: Container(
        height: !locationAvailable ? 64 : null,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: UikColor.giratina_300.toColor())),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ("#9E9E9E").toColor(),
                  ),
                ),
                (locationLoading)
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                          strokeWidth: 2,
                        ))
                    : (place != null &&
                            place!.locality != null &&
                            place!.postalCode != null)
                        ? Text(
                            "${place!.locality!}, ${place!.postalCode!}",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        : Container()
              ],
            ),
            SvgPicture.network(
                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1715771628916-bx_current-location.svg"),
          ],
        ),
      ),
    );
  }

  Future<void> getLocation() async {
    setState(() {
      locationLoading = true;
    });
    Position? position = await LocationUtils.getCurrentPosition();
    if (position != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        locationLoading = false;
        lat = position.latitude;
        long = position.longitude;
        place = placemarks[0];
      });
      print(place!.toJson().toString());
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } else {}
  }

  void updatedata() async {
    final footer = mainMap["footer"];
    final api = footer["api"];
    final routeMethod = footer["routeMethod"];
    final elseRouteMethod = footer["elseRouteMethod"];
    final pageRoute = footer["pageRoute"];
    final elsePageRoute = footer["elsepageRoute"];
    final popName = footer["popName"];
    final successMessage = footer["successMessage"];
    final condition = (footer["condition"] ?? {}).cast<String, dynamic>();
    final additionalArgs =
        (footer["additionalArgs"] ?? {}).cast<String, dynamic>();
    final isTransferToNext = footer["isTransferToNext"] ?? false;

    bool isConditionSatisfied = _checkCondition(condition);

    final selectedPageRoute = isConditionSatisfied ? pageRoute : elsePageRoute;
    final selectedRouteMethod =
        isConditionSatisfied ? routeMethod : elseRouteMethod;

    try {
      Map<String, dynamic> args = _updateVariableData(additionalArgs);

      if (api == null || api.isEmpty) {
        NavigationUtils.openScreen(
            selectedPageRoute, isTransferToNext ? args : {});
        if (successMessage != null && successMessage.isNotEmpty) {
          UiUtils.showToast(successMessage);
        }
        return;
      }

      final ApiResponse response =
          await ApiRepository.fieldScreenApi(api, args);

      if (response.isSuccess!) {
        FieldData.handleRoute(FieldData.getRouteMethod(selectedRouteMethod),
            selectedPageRoute, popName, isTransferToNext ? args : {});
        if (successMessage != null && successMessage.isNotEmpty) {
          UiUtils.showToast(successMessage);
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error In Request");
    }
  }

  bool _checkCondition(Map condition) {
    if (condition.isEmpty) return true;

    bool isConditionSatisfied = true;
    for (var element in condition.entries) {
      isConditionSatisfied =
          (variableData[element.key] == element.value) && isConditionSatisfied;
    }
    return isConditionSatisfied;
  }

  Map<String, dynamic> _updateVariableData(Map<String, dynamic> additonalArgs) {
    final args = variableData;
    for (var element in joinTo.entries) {
      args[element.value["field"]] = FieldData.joinValues(
          args[element.value["field"]],
          args[element.key],
          element.value["type"]);
      args.remove(element.key);
    }
    final widgetargs = (widget.args ?? {}).cast<String, dynamic>();
    args.addAll(widgetargs);
    args.addAll(additonalArgs);
    return args;
  }
}
