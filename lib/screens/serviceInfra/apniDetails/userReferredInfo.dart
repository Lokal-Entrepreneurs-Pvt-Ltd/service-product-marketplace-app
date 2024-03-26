import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/secondcard.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserReferredByScreen extends StatefulWidget {
  const UserReferredByScreen({super.key});

  @override
  State<UserReferredByScreen> createState() => _UserReferredByScreenState();
}

class _UserReferredByScreenState extends State<UserReferredByScreen> {
  bool referralError = false;
  String referredAgentName = "";
  String referredAgentAddress = "";
  String referralErrorText = "";
  String referredByCode = "";
  String referral = "";
  Future<Map<String, dynamic>?>? _futureData;

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});

      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          setState(() {
            referral = userData["referredBy"] ?? "";
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
  }

  @override
  void initState() {
    _futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      persistentFooterButtons: [buildContinueButton(context)],
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  Widget buildBody() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 21),
            child: buildTitle("Apna Referral Code Bhare", 18, FontWeight.w500),
          ),
          TextInputContainer(
            fieldName: "Partner Referral Code",
            hint: "Enter Referral Code",
            initialValue: referral,
            errorText: referralError ? referralErrorText : null,
            onFileSelected: (p0) {
              setState(() {
                referral = p0 ?? "";
                _referralHandler(referral);
              });
            },
          ),
          buildfield("Name", referredAgentName),
          buildfield("Address", referredAgentAddress),
        ],
      ),
    );
  }

  void referralFetch(String code) async {
    final response = await ApiRepository.getUserByLokalID({"lokalID": code});
    if (response.isSuccess!) {
      final userData = response.data;
      if (userData != null) {
        referredAgentName = userData["firstName"] ?? "";
        referredAgentAddress =
            "${userData["locality"]}${userData["locality"].isNotEmpty ? ", " : ""}"
            "${userData["administrativeArea"]}${userData["administrativeArea"].isNotEmpty ? ", " : ""}"
            "${userData["country"]}${userData["country"].isNotEmpty ? ", " : ""}"
            "${userData["postalCode"]}";
        if (referredAgentName.isNotEmpty || referredAgentAddress.isNotEmpty) {
          setState(() {
            referredByCode = code;
            referralError = false;
          });
        } else {
          setState(() {
            referralError = true;
            referralErrorText = "Please Check Referral Code";
          });
        }
      } else {
        setState(() {
          referralError = true;
          referralErrorText = "Please Check Referral Code";
        });
      }
    } else {
      setState(() {
        referralError = true;
        referralErrorText = "Please Check Referral Code";
      });
    }
  }

  void _referralHandler(String code) {
    if (code.length == 9 || code.length == 10) {
      referralFetch(code);
    } else {
      setState(() {
        referredByCode = "";
        referredAgentName = "";
        referredAgentAddress = "";
      });
      if (code.isEmpty) {
        setState(() {
          referralError = false;
          referralErrorText = "";
        });
      } else {
        setState(() {
          referralError = true;
          referralErrorText = "Enter Referral Code";
        });
      }
    }
  }

  Widget buildContinueButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Save Details",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: referredByCode.isNotEmpty
            ? Colors.yellow
            : Colors.grey, // Change button color based on field completion
        onClick: () {
          if (referredByCode.isNotEmpty) {
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
    try {
      final response = await ApiRepository.updateCustomerInfo(
        {
          "referredBy": referredByCode,
        },
      );

      if (response.isSuccess!) {
        UiUtils.showToast("General Details Updated");
        // NavigationUtils.pop();
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error In Request");
    }
  }

  Widget buildfield(String name, String selectedname) {
    return Container(
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
              (selectedname.isNotEmpty)
                  ? Text(selectedname,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400))
                  : Container()
            ],
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
}
