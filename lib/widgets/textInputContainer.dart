import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_sdk/utils/extensions.dart';

class TextInputContainer extends StatefulWidget {
  final String fieldName;
  final String hint;
  final TextInputType? textInputType;
  final String? initialValue; // Add initialValue property
  final Function(String?) onFileSelected;
  final String? errorText;
  TextInputContainer(
      {Key? key,
      required this.fieldName,
      this.hint = "",
      this.textInputType,
      this.initialValue, // Initialize initialValue
      required this.onFileSelected,
      this.errorText = null})
      : super(key: key);

  @override
  State<TextInputContainer> createState() => _TextInputContainerState();
}

class _TextInputContainerState extends State<TextInputContainer> {
  late FocusNode focusNode;
  bool set = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNodeListner();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      set = true;
    }
    // Initialize controller with initialValue
    textEditingController = TextEditingController(text: widget.initialValue);
    textListner();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void focusNodeListner() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (textEditingController.text.isEmpty) {
          setState(() {
            set = false;
          });
        }
      }
    });
  }

  void textListner() {
    textEditingController.addListener(() {
      widget.onFileSelected(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (set)
              ? Container(
                  height: 64,
                  padding: EdgeInsets.only(top: 9.5, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: ("#F5F5F5").toColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fieldName,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ("#9E9E9E").toColor(),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TextField(
                          showCursor: false,
                          controller: textEditingController,
                          focusNode: focusNode,
                          keyboardType: widget.textInputType,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      set = true;
                      focusNode.requestFocus();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 9.5, left: 16, right: 16, bottom: 9.5),
                    height: 64,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: ("#F5F5F5").toColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter Your ${widget.fieldName}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ("#9E9E9E").toColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          widget.errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    widget.errorText!,
                    style: TextStyles.poppins.body2.light.colors("#A52A2A"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
