import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Widgets/UikTextField/UikTextField.dart';
import 'package:login/pages/UikBottomNavigationBar.dart';
import 'package:login/widgets/UikButton/UikButton.dart';

import '../../widgets/UikNavbar/UikNavbar.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final emailController = TextEditingController();
  var errorEmail = false;
  var descEmail = "";
  var errorPassword = false;
  var descPassword = "";

  final passwordController = TextEditingController();

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
              leftIcon: Icon(Icons.arrow_back),
            ),
            SizedBox(
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
                backgroundColor: Color(0xffFEE440),
                onClick: () => {
                  if (isEmailValid(emailController.text) &&
                      passwordController.text.length >= 6)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UikBottomNavigationBar()),
                      ),
                    },
                  if (isEmailValid(emailController.text))
                    {
                      errorEmail = false,
                      descEmail = '',
                    }
                  else
                    {
                      errorEmail = true,
                      descEmail = "Please Enter the valid email",
                    },
                  if (passwordController.text.length >= 6)
                    {
                      errorPassword = false,
                      descPassword = '',
                    }
                  else
                    {
                      errorPassword = true,
                      descPassword = "Password must contain 6 characters",
                    },

                  setState(() {})
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LoginPage()),
                  // ),
                },
              ),
            ),

            SizedBox(
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
