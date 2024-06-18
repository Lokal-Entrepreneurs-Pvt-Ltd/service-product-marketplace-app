import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/uploaddocumentbutton.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:ui_sdk/utils/extensions.dart';

class MyPartnerScreenWrapper extends StatefulWidget {
  final StatefulWidget page;
  MyPartnerScreenWrapper({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  State<MyPartnerScreenWrapper> createState() => _MyPartnerScreenWrapperState();
}

class _MyPartnerScreenWrapperState extends State<MyPartnerScreenWrapper> {
  File? uploadReceipt = null;
  final int buttonCount = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: widget.page,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fetch Customer Details",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildUploadButton(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        if (uploadReceipt != null) {
                          try {
                            final response = await ApiRepository.fetchPDF(
                                {"pdf": uploadReceipt});
                            if (response.isSuccess!) {
                              NavigationUtils.openScreen(
                                  ScreenRoutes.customerBankDetailsFromPDF,
                                  response.data);
                              UiUtils.showToast("PDF fetched successfully");
                            } else {
                              UiUtils.showToast(response.error![MESSAGE]);
                            }
                          } catch (e) {
                            UiUtils.showToast("Error extracting PDF data");
                          }
                        } else {
                          UiUtils.showToast(
                              "please Upload Receipt to fetch data");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
                        decoration: BoxDecoration(
                            color: uploadReceipt != null
                                ? UikColor.charizard_400.toColor()
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Fetch Details",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return UploadButton(
      text: "Upload Receipt",
      imageUrl: "",
      height: 64,
      documentType: "misc",
      supportType: SupportType.pdf,
      leading: SvgPicture.network(
        "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1717408728433-Upload.svg",
      ),
      isgetFileDirectly: true,
      uploadMethod: UploadMethod.FilePicker,
      onFileSelected: (pickedFile) async {
        setState(() {
          uploadReceipt = pickedFile;
        });
      },
    );
  }
}
