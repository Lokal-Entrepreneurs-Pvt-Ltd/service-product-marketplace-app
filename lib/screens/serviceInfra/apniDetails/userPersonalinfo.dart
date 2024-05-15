import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_ext.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/Uikmulti.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserPersonalInfo extends StatefulWidget {
  final dynamic args;
  const UserPersonalInfo({Key? key, this.args}) : super(key: key);

  @override
  State<UserPersonalInfo> createState() => _UserPersonalInfoState();
}

enum IndexType {
  gender,
  education,
  workExperience,
  customIndex,
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  Future<Map<String, dynamic>?>? _futureData;

  DateTime? datePicker;
  String name = "";
  TextEditingController nameTextEditingController = TextEditingController();
  double lat = 0;
  double long = 0;
  Placemark? place;
  bool locationLoading = false;
  int? age;
  bool isUpdating = false; // Added isUpdating variable
  bool isProgressBarAndContinueFeature = false;
  List<String> workEx = [
    "Fresher",
    "Below 1yr",
    "3yr - 5yr",
    "5yr - 10yrs",
    "More than 10yrs",
  ];
  List<String> education = [
    "Below 10th",
    "10th",
    "12th",
    "Graduation",
    "Post Graduation",
    "Diploma/Certification",
  ];
  List<String> genderList = ["Male", "Female"];
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

  List<String> jobs = [
    "Dyeing",
    "BPO/Customer",
    "Tailor",
    "Spinning",
    "Weaving",
    "Pattern Maker",
    "Supervisor",
    "Garment-CMT",
    "Knitting",
    "Embroidery",
    "Warehousing and Logistics",
    "Assembly Line Operator",
    "Machine Operator",
    "CNC Operator",
    "Mechanic",
    "Hospitality",
    "Electrician",
    "Painter",
    "Welder",
    "Fitter",
    "Carpenter",
  ];
  int industryIndex = -1;
  int genderIndex = -1;
  int educationIndex = -1;
  int workExperienceIndex = -1;
  String phoneNumber = "";
  int? userId;
  List<ValueItem<int>> selectedJobsOptions = [];
  List<ValueItem<int>> allGovernmentSkills = [];

  @override
  void initState() {
    super.initState();

    _futureData = fetchData();
  }

  void getAllGovernmentServices() async {
    try {
      final response = await ApiRepository.getAllGovernmentServices({});
      if (response.isSuccess!) {
        var list = List.from(response.data);

        for (var element in list) {
          String? name = element["name"];
          int? id = element["id"];
          if (name != null && id != null) {
            allGovernmentSkills.add(ValueItem(label: name, value: id));
          } else {
            print("Skipping entry: $element");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
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

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      getAllGovernmentServices();
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          lat = (userData['latitude'] as num?)?.toDouble() ?? 0;
          long = (userData['longitude'] as num?)?.toDouble() ?? 0;
          userId = userData["id"];
          if (lat != 0 && long != 0) {
            place = Placemark(
              name: userData["placeName"],
              street: userData["street"],
              isoCountryCode: userData["isoCountryCode"],
              country: userData["country"],
              postalCode: userData["postalCode"],
              administrativeArea: userData["administrativeArea"],
              subAdministrativeArea: userData["subAdministrativeArea"],
              locality: userData["locality"],
              subLocality: userData["subLocality"],
            );
          }

          setState(() {
            name = userDataMagento['firstName'] ?? '';
            phoneNumber = userData["phoneNumber"].toString();
            datePicker = userDataMagento['dob'] != null
                ? DateTime.parse(userDataMagento['dob'])
                : null;
            calculateAge(datePicker);

            genderIndex = userData['gender'] == "Male" ? 0 : 1;
            String workExperience = userData["workEx"] ?? "";
            String preferrencedIndustry = userData["industryPreference"] ?? "";
            if (preferrencedIndustry.isNotEmpty) {
              industryIndex = industryList.indexOf(preferrencedIndustry);
            }
            if (workExperience.isNotEmpty) {
              workExperienceIndex = workEx.indexOf(workExperience);
            }
            String educationText = userData["education"] ?? "";
            if (educationText.isNotEmpty) {
              educationIndex = education.indexOf(educationText);
            }
            var list = List.from(userDataMagento["governmentSkills"]);
            for (var element in list) {
              String? name = element["name"];
              int? id = element["id"];
              if (name != null && id != null) {
                selectedJobsOptions.add(ValueItem(label: name, value: id));
              } else {
                print("Skipping entry: $element");
              }
            }
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
                        "Apni Personal Details Bhare", 24, FontWeight.w600),
                  ),
                  buildTitle("Gender", 16, FontWeight.w500),
                  buildSelectable(genderList, genderIndex, (index) {
                    updateSelectedIndex(index, IndexType.gender);
                  }),
                  const SizedBox(height: 8),
                  TextInputContainer(
                    fieldName: "Full Name (as on aadhar)",
                    initialValue: name,
                    onFileSelected: (text) {
                      setState(() {
                        name = text ?? "";
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: buildDatePickerField("Date of Birth")),
                      Expanded(child: buildAgeBox("Age")),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextInputContainer(
                    fieldName: "Mobile Number",
                    initialValue: phoneNumber,
                    onFileSelected: (text) {
                      setState(() {
                        phoneNumber = text ?? "";
                      });
                    },
                  ),
                  buildTitle("Education Background", 16, FontWeight.w500),
                  buildSelectable(education, educationIndex, (index) {
                    updateSelectedIndex(index, IndexType.education);
                  }),
                  buildTitle("Work Experience", 16, FontWeight.w500),
                  buildSelectable(workEx, workExperienceIndex, (index) {
                    updateSelectedIndex(index, IndexType.workExperience);
                  }),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      int? result = await Bottomsheets.showBottomListDialog(
                        context: context,
                        name: "Industry you want to work",
                        call: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          return DataForFunction(
                              index: industryIndex, list: industryList);
                        },
                      );
                      if (result != null && result >= 0) {
                        setState(() {
                          industryIndex = result;
                        });
                      }
                    },
                    child: builbottomsheedtfield(
                        "Industry you want to work",
                        (industryIndex != -1)
                            ? industryList[industryIndex]
                            : ""),
                  ),
                  UikMulti<int>(
                    onOptionSelected: (List<ValueItem<int>> selectedOptions) {
                      setState(() {
                        selectedJobsOptions = selectedOptions;
                      });
                    },
                    hint: "Have You Done Any Government Certification",
                    options: allGovernmentSkills,
                    borderWidth: 1,
                    selectedOptions: selectedJobsOptions,
                    selectionType: SelectionType.multi,
                    chipConfig: ChipConfig(
                      runSpacing: 8,
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 20),
                      wrapType: WrapType.wrap,
                      backgroundColor: ("#FEE440").toColor(),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    maxItems: 4,
                  ),
                  const SizedBox(height: 12),
                  buildLocationField(),
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
    int totalFields = 9; // Update this with the total number of fields
    int completedFields = 0;

    // Check each field's completion status
    if (genderIndex != -1) completedFields++;
    if (name.isNotEmpty) completedFields++;
    if (datePicker != null) completedFields++;
    if (phoneNumber.isNotEmpty) completedFields++;
    if (educationIndex != -1) completedFields++;
    if (workExperienceIndex != -1) completedFields++;
    if (industryIndex != -1) completedFields++;
    if (selectedJobsOptions.isNotEmpty) completedFields++;
    if (lat != 0 && long != 0) completedFields++;
    // Add conditions for other fields...

    return completedFields / totalFields;
  }

  Widget progressBar() {
    double completionPercentage = calculateCompletionPercentage();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
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

  Widget builbottomsheedtfield(String name, String selectedname) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding:
          const EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
      height: 64,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ("#F5F5F5").toColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UikColor.giratina_300.toColor()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ("#9E9E9E").toColor(),
                  ),
                ),
                (selectedname.isNotEmpty)
                    ? Text(selectedname,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w400))
                    : Container()
              ],
            ),
          ),
          SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708195274263-chevron-down.svg"),
        ],
      ),
    );
  }

  Widget buildLocationField() {
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
          border: Border.all(color: UikColor.giratina_300.toColor()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locationAvailable
                  ? "Current Location" // Display this text if location is available
                  : " Tap to Select Location", // Display this text if no location is available
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

  Widget buildAgeBox(String fieldname) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding:
          const EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
      height: 64,
      decoration: BoxDecoration(
        color: ("#F5F5F5").toColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UikColor.giratina_300.toColor()),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
          (datePicker != null && age != null)
              ? Text(
                  age.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildDatePickerField(String fieldname) {
    return GestureDetector(
      onTap: () => showDatePicker(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
        height: 64,
        decoration: BoxDecoration(
          color: ("#F5F5F5").toColor(),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: UikColor.giratina_300.toColor()),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
            (datePicker != null)
                ? Text(
                    DateFormat('dd/MM/yyyy', 'en_US').format(datePicker!),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  int? calculateAge(DateTime? dob) {
    if (dob == null) {
      return null;
    }
    final now = DateTime.now();
    age = now.year - dob.year;
    if (age != null) {
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        return age! - 1;
      } else {
        return age;
      }
    }
    return null;
  }

  bool areAllFieldsSelected() {
    return genderIndex != -1 &&
        name.isNotEmpty &&
        age != null &&
        educationIndex != -1 &&
        workExperienceIndex != -1 &&
        industryIndex != -1 &&
        (lat != 0 && long != 0) &&
        place != null;
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
    final nameAsAadhar = name;
    final dob = (datePicker != null)
        ? DateFormat('dd/MM/yyyy', 'en_US').format(datePicker!)
        : null;
    final gender = (genderIndex != -1) ? genderList[genderIndex] : null;
    final workE =
        (workExperienceIndex != -1) ? workEx[workExperienceIndex] : null;

    if (nameAsAadhar.isNotEmpty &&
        dob != null &&
        gender != null &&
        workE != null) {
      setState(() {
        isUpdating = true; // Set isUpdating to true while updating
      });

      try {
        List<Map<String, dynamic>> lists = [];
        for (var item in selectedJobsOptions) {
          lists.add({
            "userId": userId,
            "skillId": item.value,
          });
        }
        final response2 = await ApiRepository.createUserGovSkill(lists);
        if (!response2.isSuccess!) {
          UiUtils.showToast("Goveernment Skills are not added. Try Again");
        }
        final response = await ApiRepository.updateCustomerInfo(
          {
            "name": nameAsAadhar,
            "dob": dob,
            "workEx": workEx[workExperienceIndex],
            "gender": gender,
            "age": age,
            "education": education[educationIndex],
            "industryPreference": industryList[industryIndex],
            "latitude": lat,
            "longitude": long,
            "street": place!.street,
            "isoCountryCode": place!.isoCountryCode,
            "country": place!.country,
            "postalCode": place!.postalCode,
            "placeName": place!.name,
            "administrativeArea": place!.administrativeArea,
            "subAdministrativeArea": place!.subAdministrativeArea,
            "locality": place!.locality,
            "subLocality": place!.subLocality,
          },
        );

        if (response.isSuccess!) {
          UiUtils.showToast("Personal Details Updated");
          if (isProgressBarAndContinueFeature) {
            NavigationUtils.openScreen(
                ScreenRoutes.userGeneralInfo, {"isProgress": true});
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
        case IndexType.gender:
          genderIndex = index;
          break;
        case IndexType.education:
          educationIndex = index;
          break;
        case IndexType.workExperience:
          workExperienceIndex = index;
          break;
        // case IndexType.customIndex:
        //   indexs = index;
        //   break;
      }
    });
  }

  void showDatePicker() {
    print('Tapped on date picker field'); // Check if the method is triggered
    showSimpleDatePicker(
      context,
      initialDate: datePicker,
      backgroundColor: Colors.white,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != datePicker) {
        setState(() {
          calculateAge(pickedDate);
          datePicker = pickedDate;
        });
      }
    });
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
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } else {
      lat = -1;
      long = -1;
    }
  }

  void updateState() {
    setState(() {});
  }
}

Future<DateTime?> showSimpleDatePicker(
  BuildContext context, {
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? initialDate,
  String? dateFormat,
  DateTimePickerLocale locale = DATETIME_PICKER_LOCALE_DEFAULT,
  DateTimePickerMode pickerMode = DateTimePickerMode.date,
  Color? backgroundColor,
  Color? textColor,
  TextStyle? itemTextStyle,
  String? titleText,
  String? confirmText,
  String? cancelText,
  bool looping = false,
  bool reverse = false,
}) {
  DateTime? selectedDate = initialDate ?? DateTime.now().startOfDay();
  final List<Widget> listButtonActions = [
    TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
      ),
      child: Text(
        confirmText ?? "OK",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        Navigator.pop(context, selectedDate);
      },
    ),
    TextButton(
      style: TextButton.styleFrom(foregroundColor: textColor),
      child: Text(
        cancelText ?? "Cancel",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
  ];

  // handle the range of datetime
  firstDate ??= DateTime.now();
  lastDate ??= DateTime.now();

  // handle initial DateTime
  initialDate ??= DateTime.now();

  backgroundColor ??= DateTimePickerTheme.Default.backgroundColor;
//    if (itemTextStyle == null)
//      itemTextStyle = DateTimePickerTheme.Default.itemTextStyle;

  textColor ??= DateTimePickerTheme.Default.itemTextStyle.color;

  var datePickerDialog = Container(
    width: 300,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DatePickerWidget(
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: initialDate,
          dateFormat: dateFormat,
          locale: locale,
          pickerTheme: DateTimePickerTheme(
            backgroundColor: backgroundColor,
            itemTextStyle: itemTextStyle ?? TextStyle(color: textColor),
          ),
          onChange: ((DateTime date, list) {
            print(date);
            selectedDate = date;
          }),
          looping: looping,
        ),
        Container(
          color: Colors.white,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: listButtonActions.reversed.toList(),
          ),
        ),
      ],
    ),
  );

  return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => datePickerDialog);
}
