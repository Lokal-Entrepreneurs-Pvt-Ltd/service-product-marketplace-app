import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/screens/serviceInfra/apniDetails/apnadata/apnaPeronalData.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniPersonalInfo extends StatefulWidget {
  const ApniPersonalInfo({Key? key}) : super(key: key);

  @override
  State<ApniPersonalInfo> createState() => _ApniPersonalInfoState();
}

enum IndexType {
  gender,
  education,
  workExperience,
  customIndex,
}

class _ApniPersonalInfoState extends State<ApniPersonalInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  TextEditingController nameController = TextEditingController();
  ApnaPersonalData apnaPersonalData = ApnaPersonalData();
  String selectedState = "";
  DateTime? datePicker = null;

  double lat = 0;
  double long = 0;
  int? age = null;
  bool isUpdating = false; // Added isUpdating variable
  List<String> stateList = ["Delivery", "seller", "Mumbai", "Bangalore"];

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
                Padding(
                  padding: const EdgeInsets.only(top: 21),
                  child: buildTitle(
                      "Apni Personal Details Bhare", 24, FontWeight.w600),
                ),
                buildTitle("Gender", 16, FontWeight.w500),
                buildSelectable(
                    apnaPersonalData.genderList, apnaPersonalData.genderIndex,
                    (index) {
                  updateSelectedIndex(index, IndexType.gender);
                }),
                SizedBox(height: 8),
                TextInputContainer(
                    fieldName: "Full Name (as on aadhar)",
                    textEditingController: nameController),
                //      buildTextBox("Full Name (as on aadhar)", "Type your full name"),
                Row(
                  children: [
                    Expanded(
                        flex: 3, child: buildDatePickerField("Date of Birth")),
                    Expanded(child: buildAgeBox("Age")),
                  ],
                ),
                buildTitle("Education Background", 16, FontWeight.w500),
                buildSelectable(
                    apnaPersonalData.education, apnaPersonalData.educationIndex,
                    (index) {
                  updateSelectedIndex(index, IndexType.education);
                }),
                buildTitle("Work Experience", 16, FontWeight.w500),
                buildSelectable(apnaPersonalData.workEx,
                    apnaPersonalData.workExperienceIndex, (index) {
                  updateSelectedIndex(index, IndexType.workExperience);
                }),
                SizedBox(height: 8),
                _buildPhoneField(),
                builLocationsField(
                    context, stateList, "Industry you want to work"),

                buildLocationField(),
              ],
            ),
          ),
        ),
        appBar(),
      ]),
    );
  }

  Widget buildLocationField() {
    String formattedLat =
        lat.toStringAsFixed(2); // Limit latitude to 2 decimal places
    String formattedLong =
        long.toStringAsFixed(2); // Limit longitude to 2 decimal places

    // Check if latitude and longitude values exist
    bool locationAvailable = (lat != 0 && long != 0);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 90,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => getLocation(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locationAvailable
                  ? "Current Location" // Display this text if location is available
                  : " Tap to Select Location", // Display this text if no location is available
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            if (locationAvailable) ...[
              Text(
                "Lat: $formattedLat", // Display formatted latitude
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                "Long: $formattedLong", // Display formatted longitude
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ],
        ),
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
    BuildContext context,
    List<String> list,
    String name,
  ) {
    return GestureDetector(
      onTap: () {
        _showLocationDialog(context, list);
      },
      child: Container(
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
                (selectedState.isNotEmpty)
                    ? Text(selectedState,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w400))
                    : Container(),
              ],
            ),
            SvgPicture.network(
                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708195274263-chevron-down.svg"),
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
                controller: nameController,
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

  Widget _buildPhoneField() {
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
            "Alternate Mobile Number",
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
            flex: 2,
            child: TextField(
              enableSuggestions: true,
              //  controller: phoneController,
              keyboardType: TextInputType.phone, // Change keyboardType to phone
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  hintText: MOB, // Change hint text to PHONE_INPUT
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF9E9E9E),
                  ),
                  border: InputBorder.none
                  //  errorText: errorPhone ? VALID_PHONE_NO : null, // Update error text
                  ),
              scribbleEnabled: false,
            ),
          ),
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

  Widget buildAgeBox(String fieldname) {
    return (datePicker != null)
        ? Container(
            margin: EdgeInsets.only(left: 10),
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
                  height: 5,
                ),
                Container(
                  width: double.maxFinite,
                  height: 24,
                  child: (age != null)
                      ? Text(
                          age.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          "Nan",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 10),
            padding:
                EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
            height: 64,
            decoration: BoxDecoration(
              color: ("#F5F5F5").toColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              fieldname,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ("#9E9E9E").toColor(),
              ),
            ),
          );
  }

  Widget buildTextBox(String fieldname, String hint) {
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
          Container(
            width: double.maxFinite,
            height: 24,
            child: TextFormField(
              showCursor: false,
              controller: nameController,
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

  Widget buildDatePickerField(String fieldname) {
    return (datePicker != null)
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
            height: 64,
            decoration: BoxDecoration(
              color: ("#F5F5F5").toColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () => showDatePicker(),
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
                  Text(
                    (datePicker != null)
                        ? DateFormat('dd/MM/yyyy', 'en_US').format(datePicker!)
                        : "DD/MM/YYYY",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
            height: 64,
            decoration: BoxDecoration(
              color: ("#F5F5F5").toColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => showDatePicker(),
              child: Text(
                fieldname,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ("#9E9E9E").toColor(),
                ),
              ),
            ),
          );
  }

  int? calculateAge(DateTime dob) {
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

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: CONTINUE,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        //    onClick: updatedata,
        onClick: () {
          NavigationUtils.openScreen(ScreenRoutes.apniGeneralInfo);
          //    updatedata();
        },
      ),
    );
  }

  void updatedata() async {
    final name = nameController.text;
    final dob = (datePicker != null)
        ? DateFormat('dd/MM/yyyy', 'en_US').format(datePicker!)
        : null;
    final gender = (apnaPersonalData.genderIndex != -1)
        ? apnaPersonalData.genderList[apnaPersonalData.genderIndex]
        : null;
    final workEx = (apnaPersonalData.workExperienceIndex != -1)
        ? apnaPersonalData.workEx[apnaPersonalData.workExperienceIndex]
        : null;

    if (name.isNotEmpty && dob != null && gender != null && workEx != null) {
      setState(() {
        isUpdating = true; // Set isUpdating to true while updating
      });

      try {
        final response = await ApiRepository.updateCustomerInfo(
          {"name": name, "dob": dob, "workEx": workEx, "gender": gender},
        );

        if (response.isSuccess!) {
          NavigationUtils.openScreen(ScreenRoutes.apniGeneralInfo);
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
          apnaPersonalData.genderIndex = index;
          break;
        case IndexType.education:
          apnaPersonalData.educationIndex = index;
          break;
        case IndexType.workExperience:
          apnaPersonalData.workExperienceIndex = index;
          break;
        // case IndexType.customIndex:
        //   indexs = index;
        //   break;
      }
    });
  }

  void showDatePicker() {
    DatePicker.showSimpleDatePicker(
      context,
      initialDate: datePicker,
      backgroundColor: UikColor.giratina_300.toColor(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
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
    Position? position = await LocationUtils.getCurrentPosition();
    if (position != null) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        print(GeocodingPlatform.instance.placemarkFromCoordinates(lat, long));
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
