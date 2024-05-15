import 'package:flutter/material.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

class ApplyForJobPersonalDetails extends StatefulWidget {
  const ApplyForJobPersonalDetails({Key? key, this.args}) : super(key: key);
  final dynamic args;

  @override
  State<ApplyForJobPersonalDetails> createState() =>
      _ApplyForJobPersonalDetailsState();
}

class _ApplyForJobPersonalDetailsState
    extends State<ApplyForJobPersonalDetails> {
  Future<Map<String, dynamic>?>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        return response.data;
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
        return null;
      }
    } catch (e) {
      print(e);
      UiUtils.showToast("Error fetching initial data");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the API response
            return const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            );
          } else if (snapshot.hasError) {
            // Show an error message if there's an error
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            // Show a message if no data is available
            return const Center(
              child: Text("No data available"),
            );
          } else {
            // Build the UI with the received data
            final data = snapshot.data as Map<String, dynamic>;
            return buildBody(data);
          }
        },
      ),
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
        icon: const Icon(Icons.arrow_back),
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

  Widget buildBody(Map<String, dynamic> data) {
    // Extract data from the API response
    String name = data['firstName'] ?? '';
    String email = data['email'] ?? '';
    String phoneNumber = data['phoneNumber'] ?? '';

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle("Personal Details", 30, FontWeight.w700),
            buildField("Name", Text(name)),
            buildField("Email", Text(email)),
            buildField("Phone Number", Text(phoneNumber)),
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

  Widget buildField(String label, Widget field) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          field,
        ],
      ),
    );
  }

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          NavigationUtils.pop();
          NavigationUtils.openScreen(
              ScreenRoutes.jobApplicationServiceQuestion, widget.args);
        },
        child: Container(
          width: double.infinity,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.transparent, width: 1.0),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Center(
                child: Text(
                  "Continue Application",
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
}
