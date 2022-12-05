import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screens/Login/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;

import '../../widgets/UikNavbar/UikNavbar.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

    initialize();
  }

  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
    passwordController.text = await UserDataHandler.getUserPassword();
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
              titleText: "welcome back!\nLogin to continue",
              leftIcon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              height: 32,
            ),
            MyTextField(
              labelText: "Email",
              width: 343,
              height: 64,
              Controller: emailController,
              error: errorEmail,
              description: descEmail,
            ),
            MyTextField(
              labelText: "Password",
              width: 343,
              height: 64,
              Controller: passwordController,
              error: errorPassword,
              isPassword: true,
              description: descPassword,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
              ),
              child: UikButton(
                text: "Continue",
                backgroundColor: const Color(0xffFEE440),
                onClick: () async {
                  // Once the user logs in with email and password,
                  // we use a POST API endpoint to send them to the backend
                  // The response will have authToken
                  // We are storing the authToken, userName and password locally using SharedPreferences
                  if (isEmailValid(emailController.text) &&
                      passwordController.text.length >= 6) {
                    // Creating a POST request with http client
                    // var client = http.Client();

                    Uri uri = Uri.parse(
                        "https://08ea-202-89-65-238.in.ngrok.io/customer/login");

                    var response = await http.post(
                      uri,
                      body: {
                        "email": emailController.text,
                        "password": passwordController.text,
                      },
                    );

                    final body =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    if (body["isSuccess"]) {
                      final String authToken =
                          body["data"]["response"]["authToken"];

                      UserDataHandler.saveUserToken(authToken);
                      UserDataHandler.saveEmailPassword(
                          emailController.text, passwordController.text);
                    } else {
                      isAuthError = true;
                      authErrorMessage = body["error"]["message"];
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UikBottomNavigationBar(),
                      ),
                    );
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
                },
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

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
