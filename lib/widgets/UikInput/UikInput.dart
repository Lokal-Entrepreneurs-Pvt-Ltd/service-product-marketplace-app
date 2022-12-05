import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

class UikInput extends StatelessWidget {
  final leftElement;
  final rightElement;
  final labelText;
  final desText;
  bool error;
  final hintText;
  double widthSize;
  double heightSize;

   UikInput({
    this.leftElement,
    this.rightElement,
    this.labelText,
    this.desText,
    this.hintText,
    this.error = false,
    this.widthSize = 343,
    this.heightSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widthSize,
              height: heightSize,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                border: (error == true)
                    ? Border.all(color: Color(0xffEF5350))
                    : Border.all(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTrailingIcon(leftElement),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 9.5, 16, 0),
                          child: Text(
                            (labelText != null) ? labelText : (""),
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 9.5),
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hintText,
                              //fillColor: Colors.redAccent,
                              isDense: true,
                              contentPadding: (labelText == null)
                                  ? EdgeInsets.symmetric(vertical: 0)
                                  : EdgeInsets.symmetric(vertical: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildLeadingIcon(rightElement),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Text(
                  (desText != null) ? desText : (""),
                  style: TextStyle(
                    color: (error == true)
                        ? Color(0xffEF5350)
                        : Color(0xff9E9E9E),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget _buildTrailingIcon(final leftElement) {
  if (leftElement != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 19),
        //Spacer(),
        leftElement,
      ],
    );
  }
  return Container();
}

Widget _buildLeadingIcon(final rightElement) {
  if (rightElement != null) {
    return Row(
      children: <Widget>[
        rightElement,
        SizedBox(width: 22),
      ],
    );
  }
  return Container();
}
