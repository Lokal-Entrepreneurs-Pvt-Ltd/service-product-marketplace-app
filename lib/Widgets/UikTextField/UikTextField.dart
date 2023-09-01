
import 'package:flutter/material.dart';

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

  MyTextField({super.key, 
    this.description = "",
    this.labelText,
    this.hintText = "",
    this.rightElement,
    this.width = 0.0,
    this.height = 0.0,
    this.leftElement,
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
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              border: (widget.error == true)
                  ? Border.all(color: const Color(0xffEF5350))
                  : Border.all(color: const Color(0xffF5F5F5)),
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
                        margin: const EdgeInsets.fromLTRB(16, 9.5, 16, 0),
                        child: (widget.labelText != null)
                            ? Text(
                                widget.labelText!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(color: Color(0xff9E9E9E)),
                              )
                            : null,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 9.5),
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
                              if (isPasswordCompliant(text)) {
                                widget.error = false;
                                widget.description = "";
                              } else {
                                widget.error = true;
                                widget.description =
                                    "Password Must contains A special character uppercase and lowercase letters and numbers";
                              }
                            }

                            if (widget.labelText == "Confirm Password" &&
                                text.length < 6) {
                              widget.error = true;
                              widget.description =
                                  "Confirm Password must contain 6 characters";
                            }
                            if (widget.labelText == "Confirm Password" &&
                                text.length >= 6) {
                              if (isPasswordCompliant(text)) {
                                widget.error = false;
                                widget.description = "";
                              } else {
                                widget.error = true;
                                widget.description =
                                    "Confirm Password Must contains a special character uppercase and lowercase letters and numbers";
                              }
                            }
                            setState(() {});
                          },
                          onEditingComplete: () async {},
                          obscureText: widget.isPassword,
                          cursorColor: Colors.black,
                          controller: widget.Controller,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            //fillColor: Colors.redAccent,
                            isDense: true,
                            contentPadding: (widget.labelText == null)
                                ? const EdgeInsets.symmetric(vertical: 10)
                                : const EdgeInsets.symmetric(vertical: 5),
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
              margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                (widget.description != null) ? widget.description : (""),
                style: TextStyle(
                  color: (widget.error == true)
                      ? const Color(0xffEF5350)
                      : const Color(0xff9E9E9E),
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

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

Widget _buildTrailingIcon(Widget? leftElement) {
  if (leftElement != null) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 19),
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
