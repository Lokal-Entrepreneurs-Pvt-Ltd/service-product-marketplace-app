import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({Key? key}) : super(key: key);

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  late List<bool> pickfilebool;
  late List<File?> files;
  late List<int> filesint;

  @override
  void initState() {
    super.initState();
    getWidgetByUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [
            Text(
              "Create Profile",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              "3 of 3",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload Documents",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 25),
              for (int i = 0; i < pickfilebool.length; i++)
                UploadButton(
                  text: getUploadButtonText(i),
                  isSelected: pickfilebool[i],
                  onFileSelected: (p0) {
                    setState(() {
                      pickfilebool[i] = true;
                      files[i] = p0;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: Alignment.center,
          child: UikButton(
            text: "Continue",
            textColor: Colors.black,
            textSize: 16.0,
            textWeight: FontWeight.w500,
            onClick: getidforfile,
          ),
        ),
      ],
    );
  }

  void getWidgetByUserType() {
    var user = UserDataHandler.getUserType();
    switch (user) {
      case "PARTNER":
        pickfilebool = List.filled(4, false);
        files = List.filled(4, null);
        filesint = List.filled(4, -1);

        break;
      case "AGENT":
        pickfilebool = List.filled(3, false);
        files = List.filled(3, null);
        filesint = List.filled(3, -1);
        break;
      default:
        pickfilebool = List.filled(3, false);
        files = List.filled(3, null);
        filesint = List.filled(3, -1);
    }
  }

  String getUploadButtonText(int index) {
    if (pickfilebool.length == 3) {
      switch (index) {
        case 0:
          return "Upload Your Aadhar Card Front Image. (Max Size 1 MB )";
        case 1:
          return "Upload Your Aadhar Card Back Image. (Max Size 1 MB )";
        case 2:
          return "Upload Your Pan Card Image. (Max Size 1 MB )";
        default:
          return "";
      }
    }
    switch (index) {
      case 0:
        return "Upload Your Business GST No. in PDF. (Max Size 1 MB )";
      case 1:
        return "Upload Your Aadhar Card Front Image. (Max Size 1 MB )";
      case 2:
        return "Upload Your Aadhar Card Back Image. (Max Size 1 MB )";
      case 3:
        return "Upload Your Pan Card Image. (Max Size 1 MB )";
      default:
        return "";
    }
  }

  void getidforfile() async {
    bool flag = false;
    for (int i = 0; i < pickfilebool.length; i++) {
      if (!pickfilebool[i]) {
        flag = true;
        UiUtils.showToast("${getUploadButtonText(i)} not selected");
      }
    }

    if (flag) {
      return;
    }

    // flag = false;
    for (int i = 0; i < pickfilebool.length; i++) {
      final response = await ApiRepository.uploadDocuments(
        ApiRequestBody.getuploaddocumentsid(
          "misc",
          files[i]!,
        ),
      );
      print("dgtghhgh");
      if (response.isSuccess!) {
        var customerData = response.data["response"]["id"];
        if (customerData != null) {
          setState(() {
            filesint[i] = customerData;
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
        flag = true;
      }
    }

    if (flag) {
      UiUtils.showToast("Try again some error occurred");
      setState(() {
        if (pickfilebool.length == 3) {
          pickfilebool = List.filled(3, false);
        } else {
          pickfilebool = List.filled(4, false);
        }
      });
    } else {
      UiUtils.showToast("Successfully sent");
      print(filesint[0]);
    }
  }
}
