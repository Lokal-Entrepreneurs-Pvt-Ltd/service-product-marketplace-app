import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/components/UikText.dart';
import 'package:ui_sdk/components/WidgetType.dart';

import '../../constants/json_constants.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/storage/preference_constants.dart';
import '../../utils/storage/user_data_handler.dart';
import '../../widgets/UikNavbar/UikNavbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var errorEmail = false;
  var descEmail = "";

  var errorPassword = false;
  var descPassword = "";

  var errorConfirmPassword = false;
  var descConfirmPassword = "";

  var isAuthError = false;
  var authErrorCode = -1;
  var authErrorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            UikNavbar(
              size: "",
              titleText: "enter your email\naddress to signup",
              leftIcon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              height: 32,
            ),
            MyTextField(
              labelText: "Email",
              width: 327,
              height: 64,
              Controller: emailController,
              error: errorEmail,
              description: descEmail,
              isSignUpField: true,
            ),
            MyTextField(
              labelText: "Password",
              width: 327,
              height: 64,
              Controller: passwordController,
              error: errorPassword,
              isPassword: true,
              description: descPassword,
              isSignUpField: true,
            ),
            MyTextField(
              labelText: "Confirm Password",
              width: 327,
              height: 64,
              Controller: confirmPasswordController,
              error: errorConfirmPassword,
              isPassword: true,
              description: descConfirmPassword,
              isSignUpField: true,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
              ),
              child: UikButton(
                text: "Continue",
                widthSize: 327,
                backgroundColor: const Color(0xffFEE440),
                onClick: () async {
                  // Once the user logs in with email and password,
                  // we use a POST API endpoint to send them to the backend
                  // The response will have authToken
                  // We are storing the authToken, userName and password locally using SharedPreferences
                  if (isEmailValid(emailController.text) &&
                      passwordController.text.length >= 6 &&
                      confirmPasswordController.text ==
                          passwordController.text) {
                    // Creating a POST request with http client
                    // var client = http.Client();
                    NavigationUtils.showLoaderOnTop();
                    final response = await ApiRepository.getSignUpScreen(
                            ApiRequestBody.getSignUpRequest(
                                emailController.text, passwordController.text))
                        .catchError((error) {
                      NavigationUtils.pop();
                    });

                    NavigationUtils.pop();

                    if (response.isSuccess!) {
                      UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);

                      var customerData = response.data[CUSTOMER_DATA];
                      if (customerData != null) {
                        UserDataHandler.saveCustomerData(customerData);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UikBottomNavigationBar(),
                        ),
                      );
                    } else {
                      //todo show login error
                      UiUtils.showToast(response.error![MESSAGE]);
                    }
                  }

                  if (isEmailValid(emailController.text)) {
                    errorEmail = false;
                    descEmail = '';
                  } else {
                    errorEmail = true;
                    descEmail = "Please Enter the valid email";
                  }

                  if (passwordController.text.length >= 6) {
                    errorPassword = false;
                    descPassword = '';
                  } else {
                    errorPassword = true;
                    descPassword = "Password must contain 6 characters";
                  }

                  if (confirmPasswordController.text.length >= 6) {
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      errorConfirmPassword = true;
                      descConfirmPassword =
                          "ConfirmPassword must be equal to Password";
                    } else {
                      errorConfirmPassword = false;
                      descConfirmPassword = '';
                    }
                  } else {
                    errorConfirmPassword = true;
                    descConfirmPassword =
                        "Confirm Password must contain 6 characters";
                  }

                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // Center(
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       "Forgot Password?",
            //       style: TextStyle(
            //         fontSize: 14.0,
            //         fontFamily: GoogleFonts.poppins().fontFamily,
            //         fontWeight: FontWeight.w500,
            //         color: const Color(0xFF9E9E9E),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
