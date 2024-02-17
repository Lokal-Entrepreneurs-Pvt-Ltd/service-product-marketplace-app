import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ApniDocumentInfo extends StatefulWidget {
  const ApniDocumentInfo({Key? key}) : super(key: key);

  @override
  State<ApniDocumentInfo> createState() => _ApniDocumentInfoState();
}

class _ApniDocumentInfoState extends State<ApniDocumentInfo> {
  // Create a new list to track upload success for each file
  late List<String?> uploadSuccessList;
  List<String> list = [
    "Upload Your Aadhar Card Front Image. (Max Size 1 MB )",
    "Upload Your Aadhar Card Back Image. (Max Size 1 MB )",
    "Upload Your Pan Card Image. (Max Size 1 MB )",
  ];

  @override
  void initState() {
    super.initState();
    uploadSuccessList = List.filled(list.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: buildBody(),
          ),
          appBar(),
        ]),
      ),
      persistentFooterButtons: [
        buildContinueButton(),
      ],
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUploadDocumentsTitle(),
          buildUploadButtons(),
        ],
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
                color: UikColor.gengar_200.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: UikColor.gengar_300.toColor(),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
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
                documentType: "misc",
                onFileSelected: (pickedFile) async {
                  setState(() {
                    uploadSuccessList[i] = pickedFile;
                    print(pickedFile);
                  });
                }, // Set uploadSuccess based on the list
              ),
            ],
          ),
      ],
    );
  }

  Container buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Continue",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
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
          UiUtils.showToast("SuccessFully Uploaded");
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
