import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // const MyTextField({super.key});

  // late String id;
  final String description;
  final String? labelText;
  final String hintText;
  final Widget? rightElement;
  final double width;
  final double height;
  final Widget? leftElement;
  final bool error;
  final TextEditingController Controller;

  MyTextField(
      {this.description = "",
      this.labelText = null,
      this.hintText = "",
      this.rightElement = null,
      this.width = 0.0,
      this.height = 0.0,
      this.leftElement = null,
      this.error = false,
      required this.Controller});
  // late UikAction action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              border: (error == true)
                  ? Border.all(color: Color(0xffEF5350))
                  : Border.all(color: Color(0xffF5F5F5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leftElement != null) ...[_buildTrailingIcon(leftElement)],
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 9.5, 16, 0),
                        child: (labelText != null)
                            ? Text(
                                labelText!,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Color(0xff9E9E9E)),
                              )
                            : null,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 9.5),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: Controller,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText,
                            //fillColor: Colors.redAccent,
                            isDense: true,
                            contentPadding: (labelText == null)
                                ? EdgeInsets.symmetric(vertical: 10)
                                : EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (rightElement != null) ...[
                  _buildLeadingIcon(rightElement!),
                ],
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                (description != null) ? description : (""),
                style: TextStyle(
                  color:
                      (error == true) ? Color(0xffEF5350) : Color(0xff9E9E9E),
                ),
              )),
        ],
      ),
    );
  }
}

Widget _buildTrailingIcon(Widget? leftElement) {
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

Widget _buildLeadingIcon(Widget? rightElement) {
  if (rightElement != null) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        rightElement,
        // SizedBox(width: 22),
      ],
    );
  }
  return Container();
}