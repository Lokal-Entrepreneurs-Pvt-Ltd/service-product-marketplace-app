import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserBankInfoScreen extends StatefulWidget {
  final dynamic args;
  const UserBankInfoScreen({super.key, this.args});

  @override
  State<UserBankInfoScreen> createState() => _UserBankInfoScreenState();
}

class _UserBankInfoScreenState extends State<UserBankInfoScreen> {
  bool bankAccError = false;
  bool bankAccSuccess = false;
  String bankAccDetails = "";
  String bankName = "";
  String bankUserName = "";
  String bankAccNo1 = "";
  String bankAccNo2 = "";
  String bankIfsc = "";
  String bankIfscPrev = "";
  Future<Map<String, dynamic>?>? _futureData;
  bool isProgressBarAndContinueFeature = false;

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});

      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          setState(() {
            bankAccNo1 = userData["bankAccNo"] ?? "";
            bankAccNo2 = bankAccNo1;
            bankIfsc = userData["bankIfsc"] ?? "";
            bankIfscPrev = bankIfsc;
            bankUserName = userData["bankUserName"] ?? "";
            bankAccDetails = userData["bankAccDetails"] ?? "";
            bankName = userData["bankName"] ?? "";
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
      persistentFooterButtons: [
        Column(
          children: [
            buildContinueButton(context),
            buildSkipButton(),
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

  void updateBankName(String ifsc) async {
    if (bankIfscPrev.compareTo(bankIfsc) == 0) {
      return;
    }
    if (ifsc.length == 11) {
      var response = await ApiRepository.getBankDetailsByIfsc(ifsc);
      bankIfscPrev = bankIfsc;
      if (response != null) {
        setState(() {
          bankName = response["BANK"] + ", " + response["CITY"];
        });
      }
    }
  }

  double calculateCompletionPercentage() {
    int totalFields = 5; // Update this with the total number of fields
    int completedFields = 0;

    // Check each field's completion status
    if (bankName.isNotEmpty) completedFields++;
    if (bankUserName.isNotEmpty) completedFields++;
    if (bankAccNo2.isNotEmpty) completedFields++;
    if (bankAccNo1.isNotEmpty) completedFields++;
    if (bankIfsc.isNotEmpty) completedFields++;

    // Add conditions for other fields...

    return completedFields / totalFields;
  }

  Widget progressBar() {
    double completionPercentage = calculateCompletionPercentage();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 1,
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
              value: 1,
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
              value: 1,
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
              value: 1,
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
              value: completionPercentage,
              color: UikColor.gengar_400.toColor(),
              backgroundColor: UikColor.gengar_100.toColor(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: buildTitle(
                        "Apna Bank Information Bhare", 18, FontWeight.w500),
                  ),
                  TextInputContainer(
                    fieldName: "Bank User Name",
                    hint: "Enter Bank User Name",
                    initialValue: bankUserName,
                    onFileSelected: (p0) {
                      setState(() {
                        bankUserName = p0 ?? "";
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Bank Account No.",
                    hint: "Enter Bank Account No.",
                    initialValue: bankAccNo1,
                    enabled: false,
                    textInputType: TextInputType.number,
                    onFileSelected: (p0) {
                      setState(() {
                        bankAccNo1 = p0 ?? "";
                        _bankAccMatch();
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Bank Account No.",
                    hint: "Confirm Bank Account No.",
                    initialValue: bankAccNo2,
                    textInputType: TextInputType.number,
                    errorText:
                        bankAccError ? "Please Check Account Number" : null,
                    successText:
                        bankAccSuccess ? "Correct Account Number" : null,
                    enabled: false,
                    onFileSelected: (p0) {
                      setState(() {
                        bankAccNo2 = p0 ?? "";
                        _bankAccMatch();
                      });
                    },
                  ),
                  TextInputContainer(
                    fieldName: "Bank IFSC",
                    hint: "Enter Bank IFSC",
                    initialValue: bankIfsc,
                    onFileSelected: (p0) {
                      setState(() {
                        bankIfsc = p0 ?? "";
                        updateBankName(bankIfsc);
                      });
                    },
                  ),
                  Container(
                    key: ValueKey(bankName),
                    child: TextInputContainer(
                      fieldName: "Bank Name",
                      hint: "Enter Bank Name",
                      initialValue: bankName,
                      onFileSelected: (p0) {
                        setState(() {
                          bankName = p0 ?? "";
                        });
                      },
                    ),
                  ),
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

  Container buildSkipButton() {
    return (isProgressBarAndContinueFeature)
        ? Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 8),
            child: UikButton(
              text: "Skip",
              textColor: Colors.black,
              textSize: 16.0,
              textWeight: FontWeight.w500,
              backgroundColor: Colors.white,
              borderColor: UikColor.giratina_400.toColor(),
              onClick: () {
                NavigationUtils.popAllAndPush(
                    ScreenRoutes.uikBottomNavigationBar);
              },
            ),
          )
        : Container();
  }

  void _bankAccMatch() {
    if (bankAccNo1.isNotEmpty) {
      if (bankAccNo1.compareTo(bankAccNo2) == 0) {
        setState(() {
          bankAccSuccess = true;
          bankAccError = false;
        });
      } else {
        setState(() {
          bankAccSuccess = false;
          bankAccError = true;
        });
      }
    } else {
      bankAccSuccess = false;
      bankAccError = false;
    }
  }

  Widget buildContinueButton(BuildContext context) {
    bool allFieldsFilled = bankAccNo1.isNotEmpty &&
        bankAccNo2.isNotEmpty &&
        bankUserName.isNotEmpty &&
        bankIfsc.isNotEmpty &&
        bankName.isNotEmpty &&
        bankAccNo1.compareTo(bankAccNo2) == 0;

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
      final response = await ApiRepository.updateCustomerInfo(
        {
          "bankName": bankName,
          "bankIfsc": bankIfsc,
          "bankUserName": bankUserName,
          "bankAccNo": bankAccNo2,
        },
      );

      if (response.isSuccess!) {
        UiUtils.showToast("Bank Details Updated Successfully");
        if (isProgressBarAndContinueFeature) {
          NavigationUtils.popAllAndPush(ScreenRoutes.uikBottomNavigationBar);
        } else {
          NavigationUtils.pushAndPopUntil(
              ScreenRoutes.accountSettings, ScreenRoutes.accountSettings);
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error In Request");
    }
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
