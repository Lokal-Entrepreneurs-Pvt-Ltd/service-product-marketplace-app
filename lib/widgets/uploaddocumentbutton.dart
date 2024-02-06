import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:http/http.dart' as http;
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/network/http/http_screen_client.dart';
import 'package:lokal/utils/network/network_utils.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

class UploadButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(File?) onFileSelected;
  // bool _uploading = false;
  // bool _uploadSuccess = false;

  UploadButton({
    required this.text,
    required this.isSelected,
    required this.onFileSelected,
  });

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
        // await getIdDocument(pickedFile);
        // UiUtils.showToast("Successfully");
        onFileSelected(pickedFile);
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
                        text,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
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
    if (isSelected) {
      return Icon(
        Icons.check,
        color: Colors.green,
        size: 30,
      );
    } else {
      return Icon(
        Icons.file_upload_outlined,
        color: Colors.black,
        size: 30,
      );
    }
  }
}
