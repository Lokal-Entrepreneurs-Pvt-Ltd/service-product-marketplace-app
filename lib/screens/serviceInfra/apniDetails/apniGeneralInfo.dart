import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/selectabletext.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/getWidgets/colors/UikColors.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniGeneralInfo extends StatefulWidget {
  const ApniGeneralInfo({Key? key}) : super(key: key);

  @override
  State<ApniGeneralInfo> createState() => _ApniGeneralInfoState();
}

enum IndexType { bike, bank }

enum LocationType { state, district, city }

class _ApniGeneralInfoState extends State<ApniGeneralInfo> {
  Future<Map<String, dynamic>?>? _futureData;
  TextEditingController homecontroller = TextEditingController();
  TextEditingController colonycontroller = TextEditingController();
  int bikeIndex = -1;
  int bankIndex = -1;
  String selectedState = "";
  String selectedDistrict = "";
  String selectedCity = "";

  List<String> bike = ["Yes", "No"];
  List<String> stateList = ["Rajasthan", "Pakistan", "Mumbai", "Bangalore"];
  List<String> districtList = [
    "Yamla",
    "Pagla",
    "Deewana",
  ];
  List<String> villageList = ["Rajasthan", "Pakistan", "Mumbai", "Bangalore"];

  bool isUpdating = false; // Added isUpdating variable

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
                  child:
                      buildTitle("General Details Bhare", 18, FontWeight.w500),
                ),
                buildTitle("Do you have a Bike?", 16, FontWeight.w500),
                buildSelectable(bike, bikeIndex, (index) {
                  updateSelectedIndex(index, IndexType.bike);
                }),
                buildTitle("Do you have Bank Accont?", 16, FontWeight.w500),
                buildSelectable(bike, bankIndex, (index) {
                  updateSelectedIndex(index, IndexType.bank);
                }),
                buildTitle("Permanent Addresses", 16, FontWeight.w500),
                builLocationsField(
                    context, stateList, "State", LocationType.state),
                builLocationsField(
                    context, districtList, "District", LocationType.district),
                builLocationsField(
                    context, villageList, "Village", LocationType.city),
                TextInputContainer(
                  fieldName: "Home No, Building Name",
                  textEditingController: homecontroller,
                  hint: "Type your address",
                ),
                TextInputContainer(
                  fieldName: "Road name, Area, Colony",
                  textEditingController: colonycontroller,
                  hint: "Type your address",
                ),
              ],
            ),
          ),
        ),
        appBar()
      ]),
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
      BuildContext context, List<String> list, String name, LocationType type) {
    return GestureDetector(
      onTap: () {
        _showLocationDialog(context, list, type);
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
                (getlocationtype(type, null).isNotEmpty)
                    ? Text(getlocationtype(type, null),
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

  String getlocationtype(LocationType type, String? string) {
    switch (type) {
      case LocationType.state:
        if (string != null) {
          selectedState = string;
        }
        return selectedState;
      case LocationType.district:
        if (string != null) {
          selectedDistrict = string;
        }
        return selectedDistrict;
      case LocationType.city:
        if (string != null) {
          selectedCity = string;
        }
        return selectedCity;
    }
  }

  Future<void> _showLocationDialog(
      BuildContext context, List<String> list, LocationType type) async {
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
                      context, list[index], index % 2 == 0, type);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationItem(
      BuildContext context, String state, bool isLightGrey, LocationType type) {
    return Container(
      color: isLightGrey ? Colors.grey[200] : Colors.white,
      child: ListTile(
        title: Text(state),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            getlocationtype(type, state);
          });
        },
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
                color: UikColor.gengar_400.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
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
          ],
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

  Widget buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: CONTINUE,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        //     onClick: updatedata,
        onClick: () {
          NavigationUtils.openScreen(ScreenRoutes.apniOtherInfo);
        },
      ),
    );
  }

  // void updatedata() async {
  //   final name = controller.text;

  //   String gender;
  //   if (bikeIndex == 0) {
  //     gender = "Male";
  //   } else if (bikeIndex == 1) {
  //     gender = "Female";
  //   } else {
  //     // Handle the case where no gender is selected or other possible values
  //     gender = ""; // You can change this default value as needed
  //   }
  //   if (name.isNotEmpty && dob.isNotEmpty ) {
  //     setState(() {
  //       isUpdating = true; // Set isUpdating to true while updating
  //     });

  //     try {
  //       final response = await ApiRepository.updateCustomerInfo(
  //         ApiRequestBody.getPersonalDetail(name, dob),
  //       );

  //       if (response.isSuccess!) {
  //         NavigationUtils.openScreen(ScreenRoutes.otherdetails);
  //       } else {
  //         UiUtils.showToast(response.error![MESSAGE]);
  //       }
  //     } catch (e) {
  //       UiUtils.showToast("Error In Request");
  //     } finally {
  //       setState(() {
  //         isUpdating = false; // Set isUpdating to false after updating
  //       });
  //     }
  //   } else {
  //     UiUtils.showToast("Please fill in all required fields.");
  //   }
  // }

  void updateSelectedIndex(int index, IndexType indexType) {
    setState(() {
      switch (indexType) {
        case IndexType.bike:
          bikeIndex = index;
          break;
        case IndexType.bank:
          bankIndex = index;
          break;
      }
    });
  }

  void updateState() {
    setState(() {});
  }
}
