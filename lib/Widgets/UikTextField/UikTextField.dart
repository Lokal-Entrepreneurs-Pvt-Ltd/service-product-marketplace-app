import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTextField extends StatefulWidget {
  // const MyTextField({super.key});

  // late String id;
  var description;
  final String? labelText;
  final String hintText;
  final Widget? rightElement;
  final double width;
  final double height;
  final Widget? leftElement;
  final bool isPassword;
  final bool isSignUpField;
  var error;
  final TextEditingController Controller;

  MyTextField({
    this.description = "",
    this.labelText = null,
    this.hintText = "",
    this.rightElement = null,
    this.width = 0.0,
    this.height = 0.0,
    this.leftElement = null,
    this.isPassword = false,
    this.error = false,
    this.isSignUpField = false,
    required this.Controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // late UikAction action;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              border: (widget.error == true)
                  ? Border.all(color: Color(0xffEF5350))
                  : Border.all(color: Color(0xffF5F5F5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leftElement != null) ...[
                  _buildTrailingIcon(widget.leftElement)
                ],
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 9.5, 16, 0),
                        child: (widget.labelText != null)
                            ? Text(
                                widget.labelText!,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Color(0xff9E9E9E)),
                              )
                            : null,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 9.5),
                        child: TextField(
                          onChanged: (text) {
                            if (!isEmailValid(text) &&
                                widget.labelText == "Email") {
                              widget.error = true;
                              widget.description =
                                  "Please Enter the valid email";
                            }
                            if (isEmailValid(text) &&
                                widget.labelText == "Email") {
                              widget.error = false;
                              widget.description = "";
                            }
                            if (widget.labelText == "Password" &&
                                text.length < 6) {
                              widget.error = true;
                              widget.description =
                                  "Password must contain 6 characters";
                            }
                            if (widget.labelText == "Password" &&
                                text.length >= 6) {
                              widget.error = false;
                              widget.description = "";
                            }
                            setState(() {});
                          },
                          onEditingComplete: () async {
                            // https://08ea-202-89-65-238.in.ngrok.io/customer/doesAccountExist

                            if (!widget.isSignUpField) {
                              if (!widget.isPassword) {
                                Uri uri = Uri.parse(
                                    "http://localhost:3000/customer/doesAccountExist");

                                var response = await http.post(
                                  uri,
                                  body: {
                                    "email": widget.Controller.text,
                                  },
                                );

                                final body = jsonDecode(response.body)
                                    as Map<String, dynamic>;

                                if (body["isSuccess"]) {
                                  bool isAccountFound =
                                      body["data"]["response"]["accountFound"];

                                  if (!isAccountFound) {
                                    setState(() {
                                      widget.error = true;
                                      widget.description =
                                          "Account doesn't exist";
                                    });
                                  }
                                }
                              }
                            }
                          },
                          obscureText: widget.isPassword,
                          cursorColor: Colors.black,
                          controller: widget.Controller,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            //fillColor: Colors.redAccent,
                            isDense: true,
                            contentPadding: (widget.labelText == null)
                                ? EdgeInsets.symmetric(vertical: 10)
                                : EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.rightElement != null) ...[
                  _buildLeadingIcon(widget.rightElement!),
                ],
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                (widget.description != null) ? widget.description : (""),
                style: TextStyle(
                  color: (widget.error == true)
                      ? Color(0xffEF5350)
                      : Color(0xff9E9E9E),
                ),
              )),
        ],
      ),
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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
