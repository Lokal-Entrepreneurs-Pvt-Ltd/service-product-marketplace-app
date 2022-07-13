import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class extremeIconButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  double widthSize;
  double heightSize;
  final rightElement;
  final leftElement;
  final onClick;

  extremeIconButton({
    this.onClick,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.yellow,
    this.borderColor = Colors.transparent,
    this.text = "Button",
    this.widthSize = 343,
    this.heightSize = 60,
    this.rightElement,
    this.leftElement,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: onClick,
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
                  child: _buildLeadingIcon(leftElement),
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
                  child: _buildTrailingIcon(rightElement),
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
Widget _buildTrailingIcon(final rightElement) {
  if (rightElement != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 5),
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
        SizedBox(width: 5),
      ],
    );
  }
  return Container();
}
