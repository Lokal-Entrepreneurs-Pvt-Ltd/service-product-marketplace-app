import 'package:flutter/material.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextInputContainer extends StatefulWidget {
  String fieldName;
  String hint;
  bool set;
  TextEditingController textEditingController;
  TextInputType? textInputType;
  TextInputContainer({
    super.key,
    required this.fieldName,
    this.set = false,
    this.hint = "",
    required this.textEditingController,
    this.textInputType = null,
  });

  @override
  State<TextInputContainer> createState() => _TextInputContainerState();
}

class _TextInputContainerState extends State<TextInputContainer> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    fdd();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void fdd() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (widget.textEditingController.text.isEmpty) {
          setState(() {
            widget.set = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.set)
        ? Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.only(top: 9.5, left: 16, right: 16),
            height: 64,
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
                    controller: widget.textEditingController,
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
                widget.set = true;

                focusNode.requestFocus();
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding:
                  EdgeInsets.only(top: 9.5, left: 16, right: 16, bottom: 9.5),
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
          );
  }
}
