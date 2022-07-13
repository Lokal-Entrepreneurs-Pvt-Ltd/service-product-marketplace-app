import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class UikButton extends StatelessWidget {
  final Color borderColor;
  final String text;
  double widthSize;
  final rightElement;
  final leftElement;
  final onClick;
  final type;
  bool? disabled;
  bool? stuck;
  final size;

  UikButton({
    this.borderColor = Colors.transparent,
    this.text = "Button",
    this.widthSize = 343,
    this.rightElement,
    this.leftElement,
    this.onClick,
    this.type = "primary",
    this.disabled = false,
    this.stuck = false,
    this.size = "large",
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          children: [
            if (type == "primary") ...[
              Container(
                width: widthSize,
                height: (size == "large") ? 64 : 36,
                decoration: BoxDecoration(
                  color: (disabled == false)
                      ? Color(0xffFEE440)
                      : Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.transparent, width: 1.0),
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
                                color: (disabled == true)
                                    ? Color(0xff9E9E9E)
                                    : Color(0xff212121),
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
                                style: GoogleFonts.poppins(
                                  color: (disabled == true)
                                      ? Color(0xff9E9E9E)
                                      : Color(0xff212121),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 0),
                              child: _buildTrailingIcon(rightElement),
                            ),
                          ),
                        ],
                      ),
              ),
            ] else if (type == "secondary") ...[
              Container(
                width: widthSize,
                height: (size == "large") ? 64 : 36,
                decoration: BoxDecoration(
                  color: (disabled == false)
                      ? Color(0xffF5F5F5)
                      : Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.transparent, width: 1.0),
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
                                color: (disabled == true)
                                    ? Color(0xff9E9E9E)
                                    : Color(0xff212121),
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
                                style: GoogleFonts.poppins(
                                  color: (disabled == true)
                                      ? Color(0xff9E9E9E)
                                      : Color(0xff212121),
                                ),
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
            ] else if (type == "outline") ...[
              Container(
                width: widthSize,
                height: (size == "large") ? 64 : 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.black, width: 1.0),
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
                                color: (disabled == true)
                                    ? Color(0xff9E9E9E)
                                    : Color(0xff212121),
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
                                style: GoogleFonts.poppins(
                                  color: (disabled == true)
                                      ? Color(0xff9E9E9E)
                                      : Color(0xff212121),
                                ),
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
            ] else ...[
              //ghost
              Container(
                width: widthSize,
                height: (size == "large") ? 64 : 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.transparent, width: 1.0),
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
                                color: (disabled == true)
                                    ? Color(0xff9E9E9E)
                                    : Color(0xff212121),
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
                                style: GoogleFonts.poppins(
                                  color: (disabled == true)
                                      ? Color(0xff9E9E9E)
                                      : Color(0xff212121),
                                ),
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
