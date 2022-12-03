import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/Widgets/UikTextField/UikTextField.dart';
import 'package:login/pages/UikBottomNavigationBar.dart';
import 'package:login/screens/Login/user_data_handler.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
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
    // final prefs = await SharedPreferences.getInstance();

    // emailController.text = prefs.getString("email") ?? "";
    emailController.text = await UserDataHandler.getUserEmail();
    // passwordController.text = prefs.getString("password") ?? "";
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
              // subtitleText: "Shubham jacob",
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
            // SizedBox(
            //   height: 16,
            // ),
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
                      final String authToken = body["data"]["response"]["authToken"];

                      UserDataHandler.saveUserToken(authToken);
                      UserDataHandler.saveEmailPassword(
                          emailController.text, passwordController.text);
                    } else {
                      isAuthError = true;
                      // authErrorCode = body["error"]["code"];
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

                  // setState(() {})
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LoginPage()),
                  // ),
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

// Login Response - Success - POST
/* 

{
    "isSuccess": true,
    "data": {
        "response": {
            "authToken": "eyJraWQiOiIxIiwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjMzLCJ1dHlwaWQiOjMsImlhdCI6MTY2OTE5NzcxOSwiZXhwIjoxNjY5MjAxMzE5fQ.sIX4XV_FbKjhd0SGiLfwc-RuafEjbqVqKtcckZ7euNM"
        }
    }
}

 */


// Sign Up Response - Success - POST
/* 

{
    "isSuccess": true,
    "data": {
        "response": {
            "authToken": "eyJraWQiOiIxIiwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjMzLCJ1dHlwaWQiOjMsImlhdCI6MTY2OTE5NzYyNiwiZXhwIjoxNjY5MjAxMjI2fQ.iaVf9Iy0QwOP8sp8NGWQPRkDr-ZSPRbSDl1clDyIfWg"
        }
    }
}

 */

// Login/Signup Response - Failure - POST
/* 

{
    "isSuccess": false,
    "error": {
        "message": "The account sign-in was incorrect or your account is disabled temporarily. Please wait and try again later.: {\"response\":{\"errors\":[{\"message\":\"The account sign-in was incorrect or your account is disabled temporarily. Please wait and try again later.\",\"extensions\":{\"category\":\"graphql-authentication\"},\"locations\":[{\"line\":3,\"column\":9}],\"path\":[\"generateCustomerToken\"]}],\"data\":{\"generateCustomerToken\":null},\"status\":200,\"headers\":{}},\"request\":{\"query\":\"\\n      mutation GenerateCustomerToken($email: String!, $password: String!) {\\n        generateCustomerToken(email: $email, password: $password) {\\n          token\\n        }\\n      }\\n    \",\"variables\":{\"email\":\"test@test.co\",\"password\":\"test@1234\"}}}"
    }
}

 */

// DoesAccountExist Response - POST
/* 

{
    "isSuccess": true,
    "data": {
        "response": {
            "accountFound": true
        }
    }
}

 */