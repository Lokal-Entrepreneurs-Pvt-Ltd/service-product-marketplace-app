import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class extremeIconButton extends StatelessWidget {
  final textColor;
  final backgroundColor;
  final borderColor;
  final text;
  final widthSize;
  final heightSize;
  final trailingIcon;
  final leadingIcon;
  final onClick;

  extremeIconButton({
    this.onClick,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.yellow,
    this.borderColor = Colors.transparent,
    this.text = "Button",
    this.widthSize = 100,
    this.heightSize = 50,
    this.trailingIcon,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick(),
        child: Container(
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: _buildLeadingIcon(leadingIcon),
                ),
              ),
              Spacer(),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(color: textColor),
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: _buildTrailingIcon(trailingIcon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// after text icon
Widget _buildTrailingIcon(final trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 5),
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
