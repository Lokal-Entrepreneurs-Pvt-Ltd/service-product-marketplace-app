import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  Future<Map<String, dynamic>?>? _futureData;
  TextEditingController controller = TextEditingController();
  int genderIndex = -1;
  DateTime datePicker = DateTime.now();

  double lat = 0;
  double long = 0;

  bool isUpdating = false; // Added variable for update loading state

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          setState(() {
            controller.text = userDataMagento['firstName'] ?? '';
            datePicker = userDataMagento['dob'] != null
                ? DateTime.parse(userDataMagento['dob'])
                : DateTime.now();
            lat = userData['latitude'] ?? 0;
            long = userData['longitude'] ?? 0;
            genderIndex = userData['gender'] == "Male" ? 0 : 1;
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error fetching initial data");
    }
  }

  @override
  void initState() {
    super.initState();
    _futureData = fetchData(); // Call fetchData when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isUpdating ? null : buildAppBar(), // Conditionally hide the app bar
      body: FutureBuilder<Map<String, dynamic>?>(
        // Use FutureBuilder to wait for the fetchData to complete
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.yellow),
                ],
              ),
            );
          }
        },
      ),
      persistentFooterButtons: isUpdating ? null : [buildContinueButton()], // Conditionally hide the footer
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle("Personal Details", 30, FontWeight.w700),
          buildTitle("Gender", 20, FontWeight.w600),
          SizedBox(height: 8),
          buildGenderSelection(),
          SizedBox(height: 32),
          buildTextBox("Full Name", "Type your full name"),
          buildDatePickerField("Date of Birth"),
          buildLocationField(),
        ],
      ),
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
      title: Column(
        children: [
          Text(
            "Update Profile",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            "1 of 3",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
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

  Widget buildGenderSelection() {
    return Row(
      children: [
        SelectableTextWidget(
          text: "Male",
          isSelected: genderIndex == 0,
          onTap: () => updateSelectedIndex(0),
          border: 2,
        ),
        SizedBox(width: 15),
        SelectableTextWidget(
          text: "Female",
          isSelected: genderIndex == 1,
          onTap: () => updateSelectedIndex(1),
          border: 2,
        ),
      ],
    );
  }

  Widget buildTextBox(String fieldname, String hint) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldname,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black26,
            ),
          ),
          SizedBox(
            height: 8,
          ),
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

  Widget buildDatePickerField(String fieldname) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy', 'en_US').format(datePicker),
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLocationField() {
    String formattedLat = lat.toStringAsFixed(2); // Limit latitude to 2 decimal places
    String formattedLong = long.toStringAsFixed(2); // Limit longitude to 2 decimal places

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
                  ? "Current Location"
                  : " Tap to Select Location",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            if (locationAvailable) ...[
              Text(
                "Lat: $formattedLat",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                "Long: $formattedLong",
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

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: CONTINUE,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        onClick: updatedata,
      ),
    );
  }

  void updatedata() async {
    setState(() {
      isUpdating = true;
    });

    final name = controller.text;
    final dob = DateFormat('dd/MM/yyyy', 'en_US').format(datePicker);

    String gender;
    if (genderIndex == 0) {
      gender = "Male";
    } else if (genderIndex == 1) {
      gender = "Female";
    } else {
      gender = "";
    }

    if (name.isNotEmpty && dob.isNotEmpty && lat != 0 && long != 0) {
      try {
        final response = await ApiRepository.updateCustomerInfo(
          ApiRequestBody.getPersonalDetail(
            name,
            dob,
            lat,
            long,
            gender,
          ),
        );

        if (response.isSuccess!) {
          UiUtils.showToast("Basic Details Updated");
          NavigationUtils.openScreen(ScreenRoutes.otherdetails);
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }
      } catch (e) {
        UiUtils.showToast("Error In Request");
      } finally {
        setState(() {
          isUpdating = false;
        });
      }
    } else {
      UiUtils.showToast("Please fill in all required fields.");
      setState(() {
        isUpdating = false;
      });
    }
  }

  void updateSelectedIndex(int index) {
    setState(() {
      genderIndex = index;
    });
  }

  void showDatePicker() {
    DatePicker.showSimpleDatePicker(
      context,
      initialDate: datePicker,
      backgroundColor: Colors.yellow[100],
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != datePicker) {
        setState(() {
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
