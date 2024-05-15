import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserSolarInfo2Screen extends StatefulWidget {
  final dynamic args;
  const UserSolarInfo2Screen({super.key, this.args});

  @override
  State<UserSolarInfo2Screen> createState() => _UserSolarInfo2ScreenState();
}

class _UserSolarInfo2ScreenState extends State<UserSolarInfo2Screen> {
  double lat = 0;
  double long = 0;
  Placemark? place;
  bool locationLoading = false;
  String houseDetails = "";
  String streetDetails = "";
  String district = "";
  String state = "";
  String pinCode = "";
  String geoTag = "";
  Future<Map<String, dynamic>?>? _futureData;
  bool isProgressBarAndContinueFeature = false;
  int aboveReuiredArea = 0;
  bool? areaNotAvailableCheck = false;

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});

      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['companyDetails'];
        if (userData != null) {
          final geoTag = userData["ofcGeoTagLoc"] ?? "";
          final geoTagMap = Map<String, dynamic>.from(jsonDecode(geoTag));
          place = Placemark.fromMap(geoTagMap);
          setState(() {
            aboveReuiredArea = userData["isOfcSpace"] == 0 ? 1 : 0;
            houseDetails = userData["houseNo"] ?? "";
            streetDetails = userData["street"] ?? "";
            district = userData["districtOfc"] ?? "";
            state = userData["stateOfc"] ?? "";
            pinCode = userData["pincodeOfc"] ?? "";
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
      ),
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
      persistentFooterButtons: [
        Column(
          children: [
            buildContinueButton(context),
          ],
        )
      ],
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildTitle(
                    "Enter Your Business Details", 18, FontWeight.w500),
              ),
              buildTitle("Do you have Office Space 500 square feet?", 16,
                  FontWeight.w400),
              buildSelectable(["Yes", "No"], aboveReuiredArea, (index) {
                setState(() {
                  aboveReuiredArea = index;
                });
              }),
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 12),
                child: buildTitle(
                    "Address of Your Office Details?", 16, FontWeight.w400),
              ),
              Visibility(
                visible: aboveReuiredArea == 0, // Show if aboveReuiredArea is 0
                child: areaAvailable(),
              ),
              Visibility(
                visible: aboveReuiredArea == 1, // Show if aboveReuiredArea is 1
                child: areaNotAvailable(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget areaNotAvailable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: areaNotAvailableCheck,
          activeColor: Colors.yellow,
          onChanged: (value) {
            setState(() {
              areaNotAvailableCheck = value;
            });
          },
        ),
        Expanded(
          child: buildTitle(
            "We assure Lokal, will arrange in a month, give time of 30 days",
            16,
            FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget areaAvailable() {
    return Column(
      children: [
        TextInputContainer(
          fieldName: "House/Building No.",
          initialValue: houseDetails,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              houseDetails = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "Street Address, Colony, Area",
          initialValue: streetDetails,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              streetDetails = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "District",
          initialValue: district,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              district = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "State",
          initialValue: state,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              state = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "Pin Code",
          initialValue: pinCode,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              pinCode = p0 ?? "";
            });
          },
        ),
        buildLocationField(),
      ],
    );
  }

  Widget buildSelectable(
      List<String> list, int selectedIndex, void Function(int) onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Wrap(
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
      ),
    );
  }

  Widget buildContinueButton(BuildContext context) {
    bool allFieldsFilled = (aboveReuiredArea == 0)
        ? (state.isNotEmpty &&
            pinCode.isNotEmpty &&
            district.isNotEmpty &&
            place != null &&
            streetDetails.isNotEmpty &&
            houseDetails.isNotEmpty)
        : areaNotAvailableCheck!;

    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Save Details",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFieldsFilled ? Colors.yellow : Colors.grey,
        onClick: allFieldsFilled ? updatedata : null,
      ),
    );
  }

  void updatedata() async {
    try {
      final Map<String, dynamic> map = widget.args as Map<String, dynamic>;
      if (aboveReuiredArea == 0) {
        map.addAll(
          {
            "isOfcSpace": true,
            "ofcAddressLine1": "$houseDetails,$streetDetails,$district",
            "ofcAddressLine2": "$state,$pinCode",
            "ofcGeoTagLoc": jsonEncode(place!.toJson())
          },
        );
      }

      final response = await ApiRepository.updateSolarUserFields(map);

      if (response.isSuccess!) {
        NavigationUtils.openScreen(ScreenRoutes.allAgentForService);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error In Request");
    }
  }

  Widget buildTitle(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black,
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Geo Tag location",
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
}
