import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;

import '../../../utils/storage/user_data_handler.dart';
import '../../../widgets/UikNavbar/UikNavbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
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
              titleText: "Forget Password?",
              subtitleText: "enter your registered email address\nbelow",
              leftIcon: const Icon(Icons.arrow_back),
            ),
            MyTextField(
              labelText: "Email",
              width: 323,
              height: 64,
              Controller: emailController,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: UikButton(
                text: "Continue",
                widthSize: 343,
                backgroundColor: const Color(0xffFEE440),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
