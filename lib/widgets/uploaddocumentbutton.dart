import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/network/http/http_screen_client.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

enum UploadMethod { FilePicker, CustomFunction }

enum SupportType { All, pdf, image }

class UploadButton extends StatefulWidget {
  final String text;
  String imageUrl;
  final double? height;
  final Widget? leading;
  final bool isgetFileDirectly;
  final Function(dynamic)? onFileSelected;
  final String documentType;
  final UploadMethod uploadMethod;
  final SupportType supportType;
  final Function()? customFunction;
  // New property to track upload success

  UploadButton({
    super.key,
    required this.text,
    required this.documentType,
    this.leading,
    this.onFileSelected,
    this.imageUrl = "",
    this.height = null,
    this.isgetFileDirectly = false,
    this.uploadMethod = UploadMethod.FilePicker,
    this.supportType = SupportType.All,
    this.customFunction,
    // Pass uploadSuccess status from parent
  });

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool _uploading = false;
  bool _uploadSuccess = false;
  dynamic _imageUrl;
  String? _contentType = null;
  bool _isLoading = false;

  Future<void> uploadFile(File file) async {
    setState(() {
      _uploading = true;
    });
    if (widget.isgetFileDirectly) {
      setState(() {
        _uploading = false;
        _uploadSuccess = true;
        _imageUrl = file;
      });
      widget.onFileSelected!(_imageUrl);
      return;
    }
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
      widget.onFileSelected!(_imageUrl);
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
      String? name = result.names[0];
      bool extensioncheck = false;
      for (var extension in allowedExtensions) {
        extensioncheck = extensioncheck || name!.endsWith(extension);
      }
      if (!extensioncheck) {
        UiUtils.showToast("Please Select correct extension");
        return;
      }
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

  getContentName() async {
    setState(() {
      _isLoading = true;
    });
    _contentType = await HttpScreenClient.fetchContentType(_imageUrl!);
    setState(() {
      _isLoading = false;
    });
  }

  Widget getContent() {
    if (_isLoading) {
      return const Center(
        child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.yellow,
            )),
      );
    } else {
      if (_contentType != null) {
        if (_contentType!.contains('application/pdf')) {
          return SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg");
        } else {
          return Image.network(
            widget.imageUrl,
            width: 30,
            height: 30,
          );
        }
      } else {
        return SvgPicture.network(
            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg");
      }
    }
  }

  @override
  void initState() {
    if (widget.imageUrl.isNotEmpty) {
      _imageUrl = widget.imageUrl;
      _uploadSuccess = true;
      if (_imageUrl != null) {
        getContentName();
      }
    }

    super.initState();
  }

  List<String> getSupportType(SupportType supportType) {
    switch (supportType) {
      case SupportType.All:
        return ['pdf', 'jpg', 'jpeg', 'png'];
      case SupportType.pdf:
        return ['pdf'];
      case SupportType.image:
        return ['jpg', 'jpeg', 'png'];
      default:
        return ['pdf', 'jpg', 'jpeg', 'png'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          if (widget.uploadMethod == UploadMethod.FilePicker) {
            if (_imageUrl == null) {
              List<String> allowedextension =
                  getSupportType(widget.supportType);
              _pickFile(context, allowedextension);
            } else {
              setState(() {
                _uploading = false;
                _uploadSuccess = false;
                _imageUrl = null;
                widget.onFileSelected!(_imageUrl);
              });
            }
          } else {
            widget.customFunction!();
          }
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [4, 1],
          strokeWidth: 1,
          radius: const Radius.circular(12),
          color: UikColor.giratina_400.toColor(),
          child: Container(
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: UikColor.giratina_100.toColor(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (widget.uploadMethod == UploadMethod.FilePicker)
                    ? ((_imageUrl == null)
                        ? SvgPicture.network(
                            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg")
                        : (widget.isgetFileDirectly)
                            ? SvgPicture.network(
                                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg")
                            : (_contentType!.contains('application/pdf'))
                                ? SvgPicture.network(
                                    "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg")
                                : Image.network(
                                    _imageUrl!,
                                    width: 30,
                                    height: 30,
                                  ))
                    // : SvgPicture.network(
                    // "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708168622918-image-file.svg"),
                    : getContent(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
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
      return const CircularProgressIndicator(
        color: Colors.yellow,
      );
    } else if (_uploadSuccess) {
      if (widget.uploadMethod == UploadMethod.FilePicker) {
        return SvgPicture.network(
            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/service%2F1708169085547-clear.svg");
      } else {
        return const Icon(
          Icons.done,
          color: Colors.green,
        );
      }
    } else {
      if (widget.leading != null) {
        return widget.leading!;
      }
      return const Icon(
        Icons.file_upload,
        color: Colors.black,
        size: 24,
      );
    }
  }
}
