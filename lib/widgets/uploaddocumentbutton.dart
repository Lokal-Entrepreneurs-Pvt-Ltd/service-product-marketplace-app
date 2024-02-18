import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String? _imageUrl;

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
        _imageUrl = response.data["url"];
      });
      widget.onFileSelected(_imageUrl);
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
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          if (_imageUrl == null) {
            _pickFile(context, ['pdf', 'jpg', 'jpeg', 'png']);
          } else {
            setState(() {
              _uploading = false;
              _uploadSuccess = false;
              _imageUrl = null;
              widget.onFileSelected(_imageUrl);
            });
          }
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [4, 1],
          strokeWidth: 1,
          radius: Radius.circular(12),
          color: UikColor.giratina_400.toColor(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: UikColor.giratina_100.toColor(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (_imageUrl == null)
                    ? SvgPicture.network(
                        "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg")
                    : Image.network(
                        _imageUrl!,
                        width: 30,
                        height: 30,
                      ),
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
                          // fontWeight: _uploadSuccess
                          //     ? FontWeight.bold
                          //     : FontWeight.normal,
                          fontWeight: FontWeight.w400,
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
      return SvgPicture.network(
          "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708169085547-clear.svg");
    } else {
      return Icon(
        Icons.file_upload,
        color: Colors.black,
        size: 24,
      );
    }
  }
}
