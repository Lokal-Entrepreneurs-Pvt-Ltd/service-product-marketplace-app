import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserDocumentInfo extends StatefulWidget {
  final dynamic args;
  const UserDocumentInfo({Key? key, this.args}) : super(key: key);

  @override
  State<UserDocumentInfo> createState() => _UserDocumentInfoState();
}

class _UserDocumentInfoState extends State<UserDocumentInfo> {
  // Create a new list to track upload success for each file
  Future<Map<String, dynamic>?>? _futureData;
  late List<String?> uploadSuccessList;
  List<String> list = [
    "Upload Your Aadhar Card Front Image. (Max Size 1 MB )",
    "Upload Your Pan Card Image. (Max Size 1 MB )",
  ];
  bool setbool = false;
  bool isProgressBarAndContinueFeature = false;
  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
    uploadSuccessList = List.filled(list.length, null);
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userData = response.data?['userModelData'];
        if (userData != null) {
          setState(() {
            String? first = userData["aadharCardF"];
            uploadSuccessList[0] = first;
            String? second = userData["pan"];
            uploadSuccessList[1] = second;
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      print("-----------------");
      print(e);
      UiUtils.showToast("Error fetching initial data");
    }
    setState(() {
      isProgressBarAndContinueFeature = widget.args["isProgress"] ?? false;
    });
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
            buildTextupload(),
            buildContinueButton(),
            buildSkipButton()
          ],
        )
      ], // Conditionally hide the footer
    );
  }

  Widget buildTextupload() {
    return (setbool)
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: DottedBorder(
                dashPattern: [4, 1],
                strokeWidth: 1,
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                color: UikColor.magikarp_500.toColor(),
                child: Container(
                  // height: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Please Connect your DigiLocker account to Upload Documents.",
                    style: TextStyles.poppins.body1.medium
                        .colors(UikColor.magikarp_500),
                  ),
                )),
          )
        : Container();
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  double calculateCompletionPercentage() {
    int totalFields =
        uploadSuccessList.length; // Update this with the total number of fields
    int completedFields = 0;

    // Check each field's completion status
    for (var x in uploadSuccessList) {
      if (x != null) {
        completedFields++;
      }
    }
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
              value: completionPercentage,
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
              value: 0,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUploadDocumentsTitle(),
                  buildUploadButtons(),
                  // buildGovernmentUploadButton()
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

  Widget buildGovernmentUploadButton() {
    return GestureDetector(
      onTap: () async {
        try {
          final response = await ApiRepository.initiateDigiLocker({});
          if (response.isSuccess!) {
            String decentroId = response.data["decentroTxnId"] ?? "";
            String decentroUrl =
                response.data["data"]["authorizationUrl"] ?? "";
            if (decentroUrl.isNotEmpty) {
              String? xyz = await NavigationUtils.openAsyncScreen(
                  ScreenRoutes.webViewScreen, {
                "url": decentroUrl,
                "popLink":
                    "https://in.staging.decentro.tech/kyc/digilocker/digilocker-code",
                "title": "Authenticate Yourself"
              });
              if (xyz != null) {
                final uri = Uri.parse(xyz);
                final queryParams = uri.queryParameters;
                final code = queryParams['code'];
                final state = queryParams['state'];
                final response2 =
                    await ApiRepository.getAccessTokenFromDigiLocker(
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
                        ScreenRoutes.userDocumentInfo,
                        ScreenRoutes.userDocumentInfo);
                  } else {
                    UiUtils.showToast("Try Again Some error occured");
                  }
                  print("works");
                }
              }
            }
          }
        } catch (e) {
          UiUtils.showToast("Process Failed, Try Again");
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 12),
        width: double.maxFinite,
        // height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: UikColor.giratina_100.toColor(),
          border: Border.all(),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Upload Document",
              style: TextStyle(
                color: UikColor.venusaur_500.toColor(),
              ),
            ),
            Text(
              "(Digi Locker)",
              style: TextStyle(
                color: UikColor.venusaur_500.toColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadDocumentsTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 34, bottom: 16),
      child: Text(
        "Documents Upload kare",
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Column buildUploadButtons() {
    return Column(
      children: [
        for (int i = 0; i < list.length; i++)
          Column(
            children: [
              UploadButton(
                text: list[i],
                imageUrl: uploadSuccessList[i] ?? "",
                documentType: "misc",
                uploadMethod: UploadMethod.CustomFunction,
                // onFileSelected: (pickedFile) async {
                //   setState(() {
                //     uploadSuccessList[i] = pickedFile;
                //   });
                // },
                customFunction: () {
                  if (uploadSuccessList[i] != null) {
                    UiUtils.launchURL(uploadSuccessList[i]!);
                  } else {
                    setState(() {
                      setbool = true;
                    });
                  }
                },
              ),
            ],
          ),
      ],
    );
  }

  Container buildContinueButton() {
    bool allFilesUploaded = true;
    // uploadSuccessList.every((file) => file != null);
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Connect Digi Locker to upload Docs",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFilesUploaded ? Colors.yellow : Colors.grey,
        //    onClick: isLoadingList.contains(true) ? null : getidforfile,
        onClick: () async {
          // updatedata();
          String? xyz = null;
          String decentroId = "";
          try {
            final response = await ApiRepository.initiateDigiLocker({});
            if (response.isSuccess!) {
              decentroId = response.data["decentroTxnId"] ?? "";
              String decentroUrl =
                  response.data["data"]["authorizationUrl"] ?? "";
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
              final response2 =
                  await ApiRepository.getAccessTokenFromDigiLocker(
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
                  NavigationUtils.pushAndPopUntil(ScreenRoutes.userDocumentInfo,
                      ScreenRoutes.userDocumentInfo);
                  if (isProgressBarAndContinueFeature) {
                    NavigationUtils.openScreen(
                        ScreenRoutes.userBankDetailsScreen,
                        {"isProgress": true});
                  }
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
        },
      ),
    );
  }

  Container buildSkipButton() {
    return (isProgressBarAndContinueFeature)
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 8),
            child: UikButton(
              text: "Skip",
              textColor: Colors.black,
              textSize: 16.0,
              textWeight: FontWeight.w500,
              backgroundColor: Colors.white,
              borderColor: UikColor.giratina_400.toColor(),
              onClick: () {
                NavigationUtils.openScreen(
                    ScreenRoutes.userBankDetailsScreen, {"isProgress": true});
              },
            ),
          )
        : Container();
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
