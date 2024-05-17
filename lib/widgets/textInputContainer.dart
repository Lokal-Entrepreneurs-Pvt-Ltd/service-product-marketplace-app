import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';

class TextInputContainer extends StatefulWidget {
  final String fieldName;
  final String hint;
  final TextInputType? textInputType;
  final String? initialValue; // Add initialValue property
  final Function(String?) onFileSelected;
  final String? errorText;
  final String? successText;
  final bool enabled;
  final bool isEnterYourEnabled;
  final bool showCursor;
  final double borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final Function()? onError;
  final Function()? onSuccess;
  const TextInputContainer({
    Key? key,
    required this.fieldName,
    this.hint = "",
    this.textInputType,
    this.initialValue, // Initialize initialValue
    required this.onFileSelected,
    this.errorText,
    this.successText,
    this.enabled = true,
    this.isEnterYourEnabled = true,
    this.showCursor = false,
    this.borderWidth = 1,
    this.borderColor,
    this.backgroundColor,
    this.onError,
    this.onSuccess,
  }) : super(key: key);

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.errorText != null) {
        widget.onError?.call();
      } else if (widget.successText != null) {
        widget.onSuccess?.call();
      }
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (set)
              ? Container(
                  height: 64,
                  padding: const EdgeInsets.only(top: 9.5, left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: (widget.backgroundColor != null)
                          ? widget.backgroundColor
                          : ("#F5F5F5").toColor(),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: widget.errorText != null
                            ? Colors.red
                            : widget.successText != null
                                ? Colors.green
                                : widget.borderColor ??
                                    UikColor.giratina_300.toColor(),
                        width: widget.borderWidth,
                      )),
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
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TextField(
                          showCursor: widget.showCursor,
                          // cursorHeight: 8,
                          controller: textEditingController,
                          focusNode: focusNode,
                          keyboardType: widget.textInputType,
                          selectionControls: widget.enabled
                              ? CustomTextSelectionControls()
                              : EmptySelection(),
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
                    padding: const EdgeInsets.only(
                        top: 9.5, left: 16, right: 16, bottom: 9.5),
                    height: 64,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: (widget.backgroundColor != null)
                          ? widget.backgroundColor
                          : ("#F5F5F5").toColor(),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: widget.errorText != null
                            ? Colors.red
                            : widget.successText != null
                                ? Colors.green
                                : widget.borderColor ??
                                    UikColor.giratina_300.toColor(),
                        width: widget.borderWidth,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (widget.isEnterYourEnabled)
                              ? "Enter Your ${widget.fieldName}"
                              : widget.fieldName,
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
              ? Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 15,
                      color: ("#A52A2A").toColor(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.errorText!,
                      style: TextStyles.poppins.body2.light.colors("#A52A2A"),
                    ),
                  ],
                )
              : Container(),
          widget.successText != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    widget.successText!,
                    style: TextStyles.poppins.body2.light.colors("#32cd32"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    const handleColor = Colors.blue; // Change the color as needed
    const handleSize = 18.0; // Adjust the size of the handles
    final double topOffset = (textLineHeight - handleSize) / 2;
    // Custom handle widget
    Widget handle = SizedBox(
      width: handleSize,
      height: handleSize,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: CustomPaint(
          painter: _TextSelectionHandlePainter(color: handleColor),
        ),
      ),
    );
    const double pi = 3.1415926535897932;
    switch (type) {
      case TextSelectionHandleType.left: // points up-right
        return Transform.rotate(
          angle: pi / 2.0,
          child: Transform.translate(
            offset: Offset(textLineHeight / 1, -7 * topOffset),
            child: handle,
          ),
        );
      case TextSelectionHandleType.right: // points up-left
        return Transform.translate(
          offset: Offset(0, 5 * topOffset),
          child: handle,
        );
      // return handle;
      case TextSelectionHandleType.collapsed: // points up
        return Transform.rotate(
          angle: pi / 4.0,
          child: Transform.translate(
              offset: Offset(textLineHeight / 1.8, handleSize / 100),
              child: handle),
        );
    }
  }
}

class _TextSelectionHandlePainter extends CustomPainter {
  _TextSelectionHandlePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.width / 2.0;
    final Rect circle =
        Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final Rect point = Rect.fromLTWH(0.0, 0.0, radius, radius);
    final Path path = Path()
      ..addOval(circle)
      ..addRect(point);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TextSelectionHandlePainter oldPainter) {
    return color != oldPainter.color;
  }
}

class EmptySelection extends EmptyTextSelectionControls {}
