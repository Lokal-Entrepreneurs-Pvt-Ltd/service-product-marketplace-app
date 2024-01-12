import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

class PersonalJobDetails extends StatefulWidget {
  const PersonalJobDetails({Key? key}) : super(key: key);

  @override
  State<PersonalJobDetails> createState() => _PersonalJobDetailsState();
}

class _PersonalJobDetailsState extends State<PersonalJobDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool isDataModified = false;
  Map<String, dynamic> initialData = {};
  int selectedIndex = -1;
  DateTime datePicker = DateTime.now();
  double lat = 0;
  double long = 0;
  bool isUpdatingProfile = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final response = ApiResponse.fromJson({
        "isSuccess": true,
        "data": {
          "response": {
            "fullName": "Jay Ho",
            "dob": "30/50/1000",
            "mobile": "8415265581",
            "address": "ddc,ddc,dcd",
            "gender": "Male",
          }
        }
      });

      if (response.isSuccess!) {
        updateStateWithInitialData(response.data);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error fetching initial data");
    }
  }

  void updateStateWithInitialData(Map<String, dynamic>? data) {
    setState(() {
      nameController.text = initialData["fullName"] = data?['fullName'] ?? '';
      dateController.text = initialData["dob"] = data?['dob'] ?? '';
      mobileController.text = initialData["mobile"] = data?['mobile'] ?? '';
      locationController.text = initialData["address"] = data?['address'] ?? '';
      String gender = initialData["gender"] = data?['gender'] ?? '';
      selectedIndex = (gender == "Male") ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      persistentFooterButtons: [
        buildContinueButton(),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
      title: Text(
        "Apply for Job",
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle("Personal Details", 30, FontWeight.w700),
            buildGenderSelection(),
            SizedBox(height: 32),
            buildTextBox("Type your full name", nameController),
            buildTextBox("DD/MM/YYYY", dateController),
            buildTextBox("Mob.No.", mobileController),
            buildTextBox("Location", locationController),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(
      String title, double fontSize, FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle("Gender", 20, FontWeight.w600),
        SizedBox(height: 8),
        Row(
          children: [
            buildSelectableTextWidget("Male", 0),
            SizedBox(width: 15),
            buildSelectableTextWidget("Female", 1),
          ],
        ),
      ],
    );
  }

  Widget buildSelectableTextWidget(String text, int index) {
    return SelectableTextWidget(
      text: text,
      border: 0,
      isSelected: selectedIndex == index,
      onTap: () => updateSelectedIndex(index),
    );
  }

  Widget buildTextBox(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
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
      child: GestureDetector(
        onTap: isUpdatingProfile ? null : updatedata,
        child: Container(
          width: double.infinity,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.transparent, width: 1.0),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            isUpdatingProfile
                ? CircularProgressIndicator()
                : Expanded(
                    child: Center(
                      child: Text(
                        isDataModified ? "Update Profile" : "Continue",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }

  void updatedata() async {
    try {
      if (isDataModified) {
        setState(() {
          isUpdatingProfile = true;
        });

        await Future.delayed(Duration(seconds: 2));

        final response = await ApiRepository.updateCustomerInfo(
          ApiRequestBody.getPersonalJobDetail(
            nameController.text,
            dateController.text,
            mobileController.text,
            locationController.text,
          ),
        );

        if (response.isSuccess!) {
          NavigationUtils.openScreen(ScreenRoutes.otherJobDetails);
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }

        setState(() {
          isUpdatingProfile = false;
        });
      } else {
        NavigationUtils.openScreen(ScreenRoutes.otherJobDetails);
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error updating data");
    }
  }

  void updateState() {
    isDataModified = !isDataSame();
    setState(() {});
  }

  bool isDataSame() {
    return (nameController.text == initialData['fullName']) &&
        (dateController == initialData["dob"]) &&
        (mobileController == initialData["mobile"]) &&
        (locationController == initialData["address"]);
  }

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
