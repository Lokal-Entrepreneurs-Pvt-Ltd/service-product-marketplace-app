import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screens/Onboarding/NewOnboardingScreen.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/components/UikText.dart';
import 'package:ui_sdk/components/WidgetType.dart';

import '../../constants/dimens.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../screen_routes.dart';
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
  List<String> userTypes = [CUSTOMER, PARTNER, AGENT];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var errorEmail = false;
  var descEmail = "";

  var errorPassword = false;
  var descPassword = "";

  var errorConfirmPassword = false;
  var descConfirmPassword = "";
  bool isLoading = false;
  var isAuthError = false;
  var authErrorCode = -1;
  var authErrorMessage = "";
  String selectedUserType = CUSTOMER;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 62.0,
                  ),
                  child: Image.asset(
                    "assets/images/Signin1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 292),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewOnboardingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      LOGIN,
                      style: TextStyle(
                          color: Color(0XFF3F51B5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: DIMEN_35,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DIMEN_20),
                        topRight: Radius.circular(DIMEN_20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: DIMEN_20,
                        ),
                        Container(
                          height: DIMEN_52,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(DIMEN_24),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround, // Equal spacing
                            children: userTypes.map((type) {
                              bool isSelected = type == selectedUserType;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedUserType = type;
                                  });
                                },
                                child: Container(
                                  height: DIMEN_43,
                                  width: DIMEN_108,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : null, // No background for unselected items
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Color(0xFF212121)
                                          : Color(
                                              0xFF9E9E9E), // Green text for unselected items
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: DIMEN_25,
                        ),
                        MyTextField(
                          labelText: BTS_EMAIL,
                          width: DIMEN_343,
                          height: DIMEN_64,
                          Controller: emailController,
                          error: errorEmail,
                          description: descEmail,
                        ),
                        MyTextField(
                          labelText: BTS_PASSWORD,
                          width: DIMEN_343,
                          height: DIMEN_64,
                          Controller: passwordController,
                          error: errorPassword,
                          isPassword: true,
                          description: descPassword,
                        ),
                        MyTextField(
                          labelText: CONFIRM_PASSWORD,
                          width: DIMEN_343,
                          height: DIMEN_64,
                          Controller: confirmPasswordController,
                          error: errorConfirmPassword,
                          isPassword: true,
                          description: descConfirmPassword,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: DIMEN_16,
                          ),
                          child: UikButton(
                            text: SIGN_UP,
                            backgroundColor: const Color(0xffFEE440),
                            onClick: () async {
                              if (UiUtils.isEmailValid(emailController.text) &&
                                  passwordController.text.length >= 6 &&
                                  confirmPasswordController.text ==
                                      passwordController.text) {
                                NavigationUtils.showLoaderOnTop();
                                final response =
                                    await ApiRepository.getSignUpScreen(
                                  ApiRequestBody.getSignUpRequest(
                                      emailController.text,
                                      passwordController.text,
                                      selectedUserType),
                                ).catchError((error) {
                                  NavigationUtils.pop();
                                });

                                NavigationUtils.pop();

                                if (response.isSuccess!) {
                                  UserDataHandler.saveUserToken(
                                      response.data[AUTH_TOKEN]);

                                  var customerData =
                                      response.data[CUSTOMER_DATA];
                                  if (customerData != null) {
                                    UserDataHandler.saveCustomerData(
                                        customerData);
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UikBottomNavigationBar(),
                                    ),
                                  );
                                } else {
                                  UiUtils.showToast(response.error![MESSAGE]);
                                }
                              }

                              if (UiUtils.isEmailValid(emailController.text)) {
                                errorEmail = false;
                                descEmail = '';
                              } else {
                                errorEmail = true;
                                descEmail = VALID_EMAIL;
                              }

                              if (passwordController.text.length >= 6) {
                                errorPassword = false;
                                descPassword = '';
                              } else {
                                errorPassword = true;
                                descPassword = PASSWORD_LENGTH;
                              }

                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                errorConfirmPassword = true;
                                descConfirmPassword = PASSWORD_NOT_MATCH;
                              } else {
                                errorConfirmPassword = false;
                                descConfirmPassword = '';
                              }

                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: DIMEN_15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "By continuing I agree with ",
                                  style: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                                TextSpan(
                                  text: "Lokal’s Privacy Policy",
                                  style: TextStyle(
                                    color:
                                        Colors.black, // Make the link text blue
                                    decoration: TextDecoration
                                        .underline, // Add underline to the link text
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      UiUtils.launchURL(PRIVACY_POLICY_URL);
                                    },
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                                TextSpan(
                                  text: "Terms of Use",
                                  style: TextStyle(
                                    color:
                                        Colors.black, // Make the link text blue
                                    decoration: TextDecoration
                                        .underline, // Add underline to the link text
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      UiUtils.launchURL(
                                          TERMS_AND_CONDITIONS_URL);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
