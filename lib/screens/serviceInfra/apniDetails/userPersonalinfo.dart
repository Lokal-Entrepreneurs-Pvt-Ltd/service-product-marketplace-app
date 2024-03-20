import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/location/location_utils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/modalBottomSheet.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserPersonalInfo extends StatefulWidget {
  const UserPersonalInfo({Key? key}) : super(key: key);

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

  DateTime? datePicker = null;
  String name = "";
  TextEditingController nameTextEditingController = TextEditingController();
  double lat = 0;
  double long = 0;
  Placemark? place = null;
  bool locationLoading = false;
  int? age = null;
  bool isUpdating = false; // Added isUpdating variable
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
  int industryIndex = -1;
  int genderIndex = -1;
  int educationIndex = -1;
  int workExperienceIndex = -1;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
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
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          lat = (userData['latitude'] as num?)?.toDouble() ?? 0;
          long = (userData['longitude'] as num?)?.toDouble() ?? 0;
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
            datePicker = userDataMagento['dob'] != null
                ? DateTime.parse(userDataMagento['dob'])
                : null;
            // calculateAge(datePicker);
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
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
  }

  Widget buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
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
                      flex: 3, child: buildDatePickerField("Date of Birth")),
                  Expanded(child: buildAgeBox("Age")),
                ],
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
                      await Future.delayed(const Duration(milliseconds: 100));
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
                child: builbottomsheedtfield("Industry you want to work",
                    (industryIndex != -1) ? industryList[industryIndex] : ""),
              ),
              buildLocationField(),
            ],
          ),
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

  Widget buildLocationField() {
    // Check if latitude and longitude values exist
    bool locationAvailable = (lat != 0 && long != 0);

    return GestureDetector(
      onTap: () => getLocation(),
      child: Container(
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
                ? Container(
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
        height: 64,
        decoration: BoxDecoration(
          color: ("#F5F5F5").toColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
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
          NavigationUtils.pop();
          // NavigationUtils.openScreen(ScreenRoutes.userGeneralInfo);
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
    DatePicker.showSimpleDatePicker(
      context,
      initialDate: datePicker,
      backgroundColor: UikColor.giratina_300.toColor(),
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
