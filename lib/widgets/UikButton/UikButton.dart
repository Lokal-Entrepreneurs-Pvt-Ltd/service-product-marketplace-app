import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class UikButton extends StatelessWidget {
  final Color borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final String text;
  double widthSize;
  double heightSize;
  final textWeight;
  final textSize;
  final rightElement;
  final leftElement;
  final onClick;
  final type;
  bool? disabled;
  bool? stuck;

  UikButton({super.key, 
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.yellow,
    this.textWeight,
    this.textSize,
    this.textColor,
    this.text = "Button",
    this.widthSize = 343,
    this.heightSize = 64,
    this.rightElement,
    this.leftElement,
    this.onClick,
    this.type = "primary",
    this.disabled = false,
    this.stuck = true,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (type == "primary") ...[
              Container(
                width: widthSize,
                height: heightSize,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: borderColor, width: 1.0),
                ),
                child: (stuck == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: _buildLeadingIcon(leftElement),
                          ),
                          Center(
                            child: Text(
                              text,
                              style: GoogleFonts.poppins(
                                fontWeight: textWeight,
                                color: textColor,
                                fontSize: textSize,
                              ),
                            ),
                          ),
                          Container(
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: _buildLeadingIcon(leftElement),
                          ),
                          const Spacer(),
                          Expanded(
                            child: Center(
                              child: Text(
                                text,
                                style: GoogleFonts.poppins(
                                  fontWeight: textWeight,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      ),
              ),
            ] else if (type == "secondary") ...[
              Container(
                width: widthSize,
                height: heightSize,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: borderColor, width: 1.0),
                ),
                child: (stuck == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: _buildLeadingIcon(leftElement),
                          ),
                          Center(
                            child: Text(
                              text,
                              style: GoogleFonts.poppins(
                                fontWeight: textWeight,
                                color: textColor,
                              ),
                            ),
                          ),
                          Container(
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: _buildLeadingIcon(leftElement),
                          ),
                          const Spacer(),
                          Expanded(
                            child: Center(
                              child: Text(
                                text,
                                style: GoogleFonts.poppins(
                                  fontWeight: textWeight,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 2),
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      ),
              ),
            ] else if (type == "outline") ...[
              Container(
                width: widthSize,
                height: heightSize,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: borderColor, width: 1.0),
                ),
                child: (stuck == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: _buildLeadingIcon(leftElement),
                          ),
                          Center(
                            child: Text(
                              text,
                              style: GoogleFonts.poppins(
                                fontWeight: textWeight,
                                color: textColor,
                              ),
                            ),
                          ),
                          Container(
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: _buildLeadingIcon(leftElement),
                          ),
                          const Spacer(),
                          Expanded(
                            child: Center(
                              child: Text(
                                text,
                                style: GoogleFonts.poppins(
                                  fontWeight: textWeight,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      ),
              ),
            ] else ...[
              //ghost
              Container(
                width: widthSize,
                height: heightSize,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: borderColor, width: 1.0),
                ),
                child: (stuck == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: _buildLeadingIcon(leftElement),
                          ),
                          Center(
                            child: Text(
                              text,
                              style: GoogleFonts.poppins(
                                fontWeight: textWeight,
                                color: textColor,
                              ),
                            ),
                          ),
                          Container(
                            child: _buildTrailingIcon(rightElement),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: _buildLeadingIcon(leftElement),
                          ),
                          const Spacer(),
                          Expanded(
                            child: Center(
                              child: Text(
                                text,
                                style: GoogleFonts.poppins(
                                  fontWeight: textWeight,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 22),
                            child: _buildTrailingIcon(rightElement),
                          ),
                        ],
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _buildTrailingIcon(final rightElement) {
  if (rightElement != null) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 5),
        rightElement,
      ],
    );
  }
  return Container();
}

Widget _buildLeadingIcon(final leftElement) {
  if (leftElement != null) {
    return Row(
      children: <Widget>[
        leftElement,
        const SizedBox(width: 5),
      ],
    );
  }
  return Container();
}
