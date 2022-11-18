import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/Widgets/UikTextField/UikTextField.dart';
import 'package:login/pages/UikBottomNavigationBar.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();

    emailController.text = prefs.getString("email") ?? "";
    passwordController.text = prefs.getString("password") ?? "";
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
                  if (isEmailValid(emailController.text) &&
                      passwordController.text.length >= 6) {
                    // Creating a POST request with http client
                    var client = http.Client();

                    Uri uri = Uri.parse(
                        "https://cc9c-122-161-68-10.in.ngrok.io/login");

                    var response = await http.post(
                      uri,
                      body: {
                        "email": emailController.text,
                        "password": passwordController.text,
                      },
                    );

                    final body =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    print(body);

                    // Storing the returned token, username, password in shared preferences if valid
                    final prefs = await SharedPreferences.getInstance();

                    if (body["isSuccess"]) {
                      final String userToken = body["data"]["userToken"];

                      await prefs.setString("userToken", userToken);
                      await prefs.setString("email", emailController.text);
                      await prefs.setString(
                          "password", passwordController.text);
                    } else {
                      isAuthError = true;
                      authErrorCode = body["error"]["code"];
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
