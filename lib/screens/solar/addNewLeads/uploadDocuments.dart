import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UploadDocumnetInfo extends StatefulWidget {
  final dynamic args;
  const UploadDocumnetInfo({Key? key, this.args}) : super(key: key);

  @override
  State<UploadDocumnetInfo> createState() => _UploadDocumnetInfoState();
}

class _UploadDocumnetInfoState extends State<UploadDocumnetInfo> {
  Map<String, String> errorList = {
    "electricityBill": "Please Attach electricity bill",
    "veraBill": "Please Attach vera bill",
    "aadharCardF": "Please Attach aadhar",
    "aadharCardB": "Please Attach aadhar",
    "pan": "Please Attach pan",
    "photo": "Please Attach Passport size photo",
    "cheque": "Please Attach Canceled Cheque",
  };
  late Map<String, String?> uploadSuccessList;
  Map<String, dynamic> list = {
    "electricityBill": {
      "hint": "Last Month Electricity Bill. (Max Size 1 MB)",
      "isDigiBased": false
    },
    "veraBill": {
      "hint": "Vera Bill/ Index Copy. (Max Size 1 MB)",
      "isDigiBased": false
    },
    "aadharCardF": {
      "hint": "Aadhar Card Front. (Max Size 1 MB)",
      "isDigiBased": true
    },
    "aadharCardB": {
      "hint": "Aadhar Card Back. (Max Size 1 MB)",
      "isDigiBased": true
    },
    "pan": {
      "hint": "Your Pan card Image. (Max Size 1 MB)",
      "isDigiBased": true
    },
    "photo": {
      "hint": "Passport size Photo. (Max Size 1 MB)",
      "isDigiBased": false
    },
    "cheque": {
      "hint": "Cancelled Cheque. (Max Size 1 MB)",
      "isDigiBased": false
    }
  };
  bool setbool = false;
  @override
  void initState() {
    super.initState();
    uploadSuccessList = {for (var key in list.keys) key: null};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Conditionally hide the app bar
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
        title: Text(
          "Upload Documents for Loan",
          style: TextStyles.poppins.body0.medium,
        ),
      ),
      body: buildBody(),
      persistentFooterButtons: [
        Column(
          children: [
            buildContinueButton(),
          ],
        )
      ], // Conditionally hide the footer
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUploadButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildUploadButtons() {
    return Column(
      children: [
        for (var entry in list.entries)
          Column(
            children: [
              entry.value['isDigiBased'] == true
                  ? UploadButton(
                      text: entry.value["hint"],
                      imageUrl: uploadSuccessList[entry.key] ?? "",
                      documentType: "misc",
                      leading: SvgPicture.network(
                          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1717408728433-Upload.svg"),
                      uploadMethod: UploadMethod.CustomFunction,
                      customFunction: () {
                        if (uploadSuccessList[entry.key] != null) {
                          UiUtils.launchURL(uploadSuccessList[entry.key]!);
                        } else {
                          fetchDigiData();
                        }
                      },
                    )
                  : UploadButton(
                      text: entry.value["hint"],
                      imageUrl: uploadSuccessList[entry.key] ?? "",
                      documentType: "misc",
                      leading: SvgPicture.network(
                          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1717408728433-Upload.svg"),
                      uploadMethod: UploadMethod.FilePicker,
                      onFileSelected: (pickedFile) async {
                        setState(() {
                          uploadSuccessList[entry.key] = pickedFile;
                        });
                      },
                    ),
            ],
          ),
      ],
    );
  }

  fetchDigiData() async {
    String? xyz;
    String decentroId = "";
    try {
      final response = await ApiRepository.initiateDigiLocker({});
      if (response.isSuccess!) {
        decentroId = response.data["decentroTxnId"] ?? "";
        String decentroUrl = response.data["data"]["authorizationUrl"] ?? "";
        if (decentroUrl.isNotEmpty) {
          xyz = await NavigationUtils.openAsyncScreen(
              ScreenRoutes.webViewScreen, {
            "url": decentroUrl,
            "popLink":
                "https://in.staging.decentro.tech/kyc/digilocker/digilocker-code",
            "title": "Authenticate Yourself"
          });
        }
      }
    } catch (e) {
      UiUtils.showToast("Process Failed, Try Again");
    }
    try {
      if (xyz != null) {
        await NavigationUtils.showLoaderOnTop();
        final uri = Uri.parse(xyz);
        final queryParams = uri.queryParameters;
        final code = queryParams['code'];
        final state = queryParams['state'];
        final response2 = await ApiRepository.getAccessTokenFromDigiLocker(
            {"code": code, "state": state});
        if (response2.isSuccess!) {
          String decentroTxnId = response2.data["decentroTxnId"] ?? "";
          String message = response2.data["message"] ?? "";
          UiUtils.showToast(message);
          final response3 =
              await ApiRepository.getIssuedFilesFromFromDigiLocker({
            "initial_decentro_transaction_id": decentroId,
            "consent": true
          });
          if (response3.isSuccess!) {
            NavigationUtils.pushAndPopUntil(
                ScreenRoutes.userDocumentInfo, ScreenRoutes.userDocumentInfo);
          } else {
            UiUtils.showToast("Try Again Some error occured");
          }
          print("works");
        }
      }
    } catch (e) {
      UiUtils.showToast(e.toString());
    } finally {
      await NavigationUtils.showLoaderOnTop(false);
    }
  }

  Container buildContinueButton() {
    bool allFilesUploaded =
        uploadSuccessList.values.every((file) => file != null);
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Continue",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFilesUploaded ? Colors.yellow : Colors.grey,
        onClick: () {
          allFilesUploaded ? updatedata() : errorMessage();
        },
      ),
    );
  }

  errorMessage() {
    List<String> missingFiles = uploadSuccessList.entries
        .where((entry) => entry.value == null)
        .map((entry) => entry.key)
        .toList();

    UiUtils.showToast(errorList[missingFiles[0]]!);
  }

  void updatedata() async {
    final aadharf = uploadSuccessList[0] ?? "";
    final aadharB = uploadSuccessList[1] ?? "";
    final pan = uploadSuccessList[2] ?? "";

    if (aadharf.isNotEmpty && aadharB.isNotEmpty && pan.isNotEmpty) {
      try {
        final response = await ApiRepository.updateCustomerInfo(
          {
            "aadharCardF": aadharf,
            "aadharCardB": aadharB,
            "pan": pan,
          },
        );

        if (response.isSuccess!) {
          NavigationUtils.pop();
          UiUtils.showToast("Documents SuccessFully Uploaded");
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }
      } catch (e) {
        UiUtils.showToast("Error In Request");
      } finally {}
    } else {
      UiUtils.showToast("Please fill in all required fields.");
    }
  }
}
