import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UploadButton extends StatefulWidget {
  final String text;
  final Function(String?) onFileSelected;
  final String documentType;
  // New property to track upload success

  UploadButton({
    required this.text,
    required this.documentType,
    required this.onFileSelected,
    // Pass uploadSuccess status from parent
  });

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool _uploading = false;
  bool _uploadSuccess = false;

  Future<void> uploadFile(File file) async {
    setState(() {
      _uploading = true;
    });
    final response = await ApiRepository.uploadDocuments(
      ApiRequestBody.getuploaddocumentsid(
        widget.documentType,
        file,
      ),
    );
    if (response.isSuccess!) {
      setState(() {
        _uploading = false;
        _uploadSuccess = true;
      });
      widget.onFileSelected(response.data["url"]);
    } else {
      setState(() {
        _uploading = false;
      });
    }
  }

  Future<void> _pickFile(
      BuildContext context, List<String> allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      int fileSizeInBytes = await pickedFile.length();

      if (fileSizeInBytes > 1024 * 1024) {
        UiUtils.showToast("Not valid size");
        print('Selected file size exceeds 2MB. Please choose a smaller file.');
      } else {
        uploadFile(pickedFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => _pickFile(context, ['pdf', 'jpg', 'jpeg', 'png']),
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [4, 1],
          strokeWidth: 1,
          radius: Radius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: UikColor.giratina_100.toColor(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image, color: Colors.black, size: 24),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: _uploadSuccess
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                _buildUploadIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadIcon() {
    if (_uploading) {
      return CircularProgressIndicator(
        color: Colors.yellow,
      );
    } else if (_uploadSuccess) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 30,
      );
    } else {
      return Icon(
        Icons.file_upload_outlined,
        color: Colors.black,
        size: 24,
      );
    }
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUploadDocumentsTitle(),
          SizedBox(height: 15),
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

  Text buildUploadDocumentsTitle() {
    return Text(
      "Documents Upload kare",
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
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
          // bool flag = false;
          // for (int i = 0; i < list.length; i++) {
          //   if (uploadSuccessList[i] != null) {
          //     flag = true;
          //     UiUtils.showToast("${list[i]} not selected");
          //   }
          // }
          // if (!flag) {
          //   UiUtils.showToast("Successfully sent");
          // } else {
          //   UiUtils.showToast("Try again, some error occurred");
          // }
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
