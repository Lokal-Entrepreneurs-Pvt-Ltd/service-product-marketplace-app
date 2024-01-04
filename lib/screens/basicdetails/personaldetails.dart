import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  int selectedIndex = -1;
  DateTime datePicker = DateTime.now();
  double lat = 0;
  double long = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              "Agent Details",
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
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Personal Details",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "Gender",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SelectableTextWidget(
                    text: "Male",
                    isSelected: selectedIndex == 0,
                    onTap: () => updateSelectedIndex(0),
                  ),
                  SizedBox(width: 15),
                  SelectableTextWidget(
                    text: "Female",
                    isSelected: selectedIndex == 1,
                    onTap: () => updateSelectedIndex(1),
                  ),
                ],
              ),
              SizedBox(height: 32),
              textBox(fieldname: "Full Name", hint: "Type your full name"),
              textBox2(fieldname: "Date of Birth"),
              textBox3(),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: Alignment.center,
          child: UikButton(
            // backgroundColor: Colors.yellow[300],
            text: "Continue",
            textColor: Colors.black,
            textSize: 16.0,
            textWeight: FontWeight.w500,
            onClick: () {
              NavigationUtils.openScreen(ScreenRoutes.otherdetails);
            },
          ),
        ),
      ],
    );
  }

  Widget textBox2({required String fieldname}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black12,
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
              datePicker.toString(),
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textBox3() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 90,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => getLocation(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            Text(
              "Lat: $lat",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            Text(
              "Long: $long",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textBox({required String hint, required String fieldname}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black12,
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

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void showDatePicker() {
    DatePicker.showSimpleDatePicker(
      context,
      initialDate: datePicker,
      backgroundColor: Colors.yellow[100],
      firstDate: DateTime(2020),
      lastDate: DateTime(2090),
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
