import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;

import '../../widgets/UikNavbar/UikNavbar.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var errorEmail = false;
  var descEmail = "";

  var errorPassword = false;
  var descPassword = "";

  var isAuthError = false;
  var authErrorCode = -1;
  var authErrorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            UikNavbar(
              size: "",
              titleText: "Set new password",
              leftIcon: const Icon(Icons.arrow_back),
            ),
            MyTextField(
              labelText: "Password",
              width: 327,
              height: 64,
              Controller: passwordController,
              isPassword: true,
              error: errorEmail,
              description: descEmail,
              isSignUpField: true,
            ),
            MyTextField(
              labelText: "Confirm Password",
              width: 327,
              height: 64,
              Controller: confirmPasswordController,
              error: errorPassword,
              isPassword: true,
              description: descPassword,
              isSignUpField: true,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: UikButton(
                text: "Continue",
                widthSize: 327,
                backgroundColor: const Color(0xFFFEE440),
                onClick: () {},
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
