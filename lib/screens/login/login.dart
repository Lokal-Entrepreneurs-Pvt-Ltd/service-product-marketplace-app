import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/preference_constants.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../constants/strings.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/storage/user_data_handler.dart';
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

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
    //passwordController.text = await UserDataHandler.getUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              )
            : ListView(
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
                  //...............................................Foret Password...............................
                  TextButton(
                    onPressed: () => UiUtils.launchURL(FORGET_PASSWORD_URL),
                    child: Text('Forgot Password'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: UikButton(
                      text: "Continue",
                      backgroundColor: const Color(0xffFEE440),
                      onClick: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // Once the user logs in with email and password,
                        // we use a POST API endpoint to send them to the backend
                        // The response will have authToken
                        // We are storing the authToken, userName and password locally using SharedPreferences
                        if (isEmailValid(emailController.text) &&
                            passwordController.text.length >= 6) {
                          // Creating a POST request with http client
                          // var client = http.Client();
                          print("Inside Email Validation!");

                          final response = await ApiRepository.getLoginScreen(
                              ApiRequestBody.getLoginRequest(
                                  emailController.text,
                                  passwordController.text));
                          // print(response);
                          if (response.isSuccess!) {
                            print("LOGINSCREEN----------------");
                            UserDataHandler.saveUserToken(
                                response.data[AUTH_TOKEN]);

                            var customerData = response.data[CUSTOMER_DATA];
                            if (customerData != null) {
                              UserDataHandler.saveCustomerData(customerData);
                            }

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UikBottomNavigationBar(),
                                ),
                                ModalRoute.withName(ScreenRoutes.loginScreen));
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

                        setState(() {
                          isLoading = false;
                        });
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
