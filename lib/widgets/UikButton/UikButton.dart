import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class AppButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  double widthSize;
  double heightSize;
  final trailingIcon;
  final leadingIcon;
  // final xstartIcon;
  // final xendIcon;
  // final nextIcon;
  // final beforeIcon;

  AppButton({
    Key? key,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.widthSize,
    required this.heightSize,
    this.trailingIcon,
    this.leadingIcon,
    // this.beforeIcon,
    // this.nextIcon,
    // this.xendIcon,
    // this.xstartIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: _buildLeadingIcon(leadingIcon),
          ),
          Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(color: textColor),
            ),
          ),
          Container(
            child: _buildTrailingIcon(trailingIcon),
          ),
        ],
      ),
    );
  }
}

Widget _buildTrailingIcon(final trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 5),
        //Spacer(),
        trailingIcon,
      ],
    );
  }
  return Container();
}

Widget _buildLeadingIcon(final leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[
        leadingIcon,
        SizedBox(width: 5),
      ],
    );
  }
  return Container();
}