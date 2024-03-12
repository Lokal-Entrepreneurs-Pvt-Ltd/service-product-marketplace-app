import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/utils/NavigationUtils.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserDocumentInfo extends StatefulWidget {
  const UserDocumentInfo({Key? key}) : super(key: key);

  @override
  State<UserDocumentInfo> createState() => _UserDocumentInfoState();
}

class _UserDocumentInfoState extends State<UserDocumentInfo> {
  // Create a new list to track upload success for each file
  Future<Map<String, dynamic>?>? _futureData;
  late List<String?> uploadSuccessList;
  List<String> list = [
    "Upload Your Aadhar Card Front Image. (Max Size 1 MB )",
    "Upload Your Aadhar Card Back Image. (Max Size 1 MB )",
    "Upload Your Pan Card Image. (Max Size 1 MB )",
  ];
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
            uploadSuccessList[0] = userData["aadharCardF"];
            uploadSuccessList[1] = userData["aadharCardB"];
            uploadSuccessList[2] = userData["pan"];
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
        buildContinueButton()
      ], // Conditionally hide the footer
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUploadDocumentsTitle(),
              buildUploadButtons(),
            ],
          ),
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
                onFileSelected: (pickedFile) async {
                  setState(() {
                    uploadSuccessList[i] = pickedFile;
                  });
                },
              ),
            ],
          ),
      ],
    );
  }

  Container buildContinueButton() {
    bool allFilesUploaded = uploadSuccessList.every((file) => file != null);
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: SAVE_DETAILS,
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        backgroundColor: allFilesUploaded ? Colors.yellow : Colors.grey,
        //    onClick: isLoadingList.contains(true) ? null : getidforfile,
        onClick: () {
          updatedata();
        },
      ),
    );
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
