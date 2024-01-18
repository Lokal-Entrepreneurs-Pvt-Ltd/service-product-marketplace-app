import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

import '../../Widgets/UikButton/UikButton.dart';
import '../../constants/json_constants.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/storage/user_data_handler.dart';

class UploadButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function(File?) onFileSelected;
  final void Function(bool uploading, bool isSelected, bool uploadSuccess) updateStatus;
  final bool uploadSuccess; // New property to track upload success

  UploadButton({
    required this.text,
    required this.isSelected,
    required this.onFileSelected,
    required this.updateStatus,
    required this.uploadSuccess, // Pass uploadSuccess status from parent
  });

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool _uploading = false;

  Future<void> _pickFile(BuildContext context, List<String> allowedExtensions) async {
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
        setState(() {
          _uploading = true;
        });
        final success = await widget.onFileSelected(pickedFile);
        print("");
        setState(() {
          _uploading = false;
        });
        widget.updateStatus(false, success, widget.uploadSuccess); // Pass uploadSuccess status
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
          dashPattern: [8, 4],
          strokeWidth: 2,
          radius: Radius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image, color: Colors.black, size: 30),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
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
    }
    else if (widget.uploadSuccess) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 30,
      );
    }
    else if (widget.isSelected) {
      return Icon(
        Icons.file_upload_outlined,
        color: Colors.black,
        size: 30,
      );
    } else {
      return Icon(
        Icons.image,
        color: Colors.black,
        size: 30,
      );
    }
  }
}

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({Key? key}) : super(key: key);

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  late List<bool> pickfilebool;
  late List<File?> files;
  late List<int> filesint;
  List<bool> isLoadingList = [];

  // Create a new list to track upload success for each file
  List<bool> uploadSuccessList = [];

  @override
  void initState() {
    super.initState();
    getWidgetByUserType();
    // Initialize uploadSuccessList with the same length as pickfilebool
    uploadSuccessList = List.filled(pickfilebool.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: buildBody(),
      ),
      persistentFooterButtons: [
        buildContinueButton(),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
      title: buildAppBarTitle(),
    );
  }

  Column buildAppBarTitle() {
    return Column(
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
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUploadDocumentsTitle(),
          SizedBox(height: 25),
          buildUploadButtons(),
        ],
      ),
    );
  }

  Text buildUploadDocumentsTitle() {
    return Text(
      "Upload Documents",
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Column buildUploadButtons() {
    return Column(
      children: [
        for (int i = 0; i < pickfilebool.length; i++)
          Column(
            children: [
              UploadButton(
                text: getUploadButtonText(i),
                isSelected: pickfilebool[i],
                onFileSelected: (pickedFile) async {
                  setState(() {
                    pickfilebool[i] = true;
                    files[i] = pickedFile;
                    isLoadingList.add(true);
                  });
                  await uploadFile(i);
                },
                updateStatus: (uploading, isSelected, uploadSuccess) {
                  updateUploadStatus(i, uploading, isSelected, uploadSuccess);
                },
                uploadSuccess: uploadSuccessList[i], // Set uploadSuccess based on the list
              ),
            ],
          ),
      ],
    );
  }

  void updateUploadStatus(int index, bool uploading, bool isSelected, bool uploadSuccess) {
    setState(() {
      isLoadingList[index] = uploading;
      if (isSelected) {
        UiUtils.showToast("File uploaded successfully.");
        uploadSuccessList[index] = uploadSuccess; // Update uploadSuccess for this file
      }
    });
  }

  Container buildContinueButton() {
    return Container(
      alignment: Alignment.center,
      child: UikButton(
        text: "Continue",
        textColor: Colors.black,
        textSize: 16.0,
        textWeight: FontWeight.w500,
        onClick: isLoadingList.contains(true) ? null : getidforfile,
      ),
    );
  }

  Future<void> uploadFile(int i) async {
    final response = await ApiRepository.uploadDocuments(
      ApiRequestBody.getuploaddocumentsid(
        "misc",
        files[i]!,
      ),
    );
    setState(() {
      isLoadingList[i] = false;
    });
    updateUploadStatus(i, false, true, response.isSuccess!);
    if (response.isSuccess!) {
      var customerData = response.data["id"];
      if (customerData != null) {
        setState(() {
          filesint[i] = customerData;
        });
      }
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
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

    // if (flag) {
    //   return;
    // }

    if (flag) {
      UiUtils.showToast("Try again, some error occurred");
      setState(() {
        if (pickfilebool.length == 3) {
          pickfilebool = List.filled(3, false);
        } else {
          pickfilebool = List.filled(4, false);
        }
      });
    } else {
      UiUtils.showToast("Successfully sent");
      updatedata();
    }
  }

  void updatedata() async {
    try {
      final response = await ApiRepository.updateCustomerInfo(
        ApiRequestBody.getUploadDocument(
          filesint[0],
          filesint[1],
          filesint[2],
          filesint[3],
        ),
      );

      if (response.isSuccess!) {
        NavigationUtils.openScreen(ScreenRoutes.otherdetails);
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      // Handle error
    }
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
}
