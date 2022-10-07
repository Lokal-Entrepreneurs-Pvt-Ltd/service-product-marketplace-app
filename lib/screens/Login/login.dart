import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Widgets/UikButton/UikButton.dart';
import 'package:login/Widgets/UikNavbar/UikNavbar.dart';
import 'package:login/Widgets/UikTextField/UikTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            labelText: "Mobile",
            width: 343,
            height: 64, Controller: emailController,
            // error: true,
            // description: "Lavesh",
          ),
          MyTextField(
            labelText: "Password",
            width: 343,
            height: 64, Controller: passwordController,
            // error: true,
            // description: "Lavesh",
          ),
          // SizedBox(
          //   height: 16,
          // ),
          UikButton(
            text: "Continue",
            backgroundColor: Color(0xffFEE440),
            onClick: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LoginPage()),
              // ),
            },
          ),

          SizedBox(
            height: 16,
          ),

          Center(
            child: Text(
              "Forgot Pawword?",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff9e9e9e)),
            ),
          ),
        ],
      ),
    );
  }
}
