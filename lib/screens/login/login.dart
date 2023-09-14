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
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../constants/strings.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../widgets/UikNavbar/UikNavbar.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedUserType;
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
    emailController.text = UserDataHandler.getUserEmail();
    //passwordController.text = await UserDataHandler.getUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: isLoading
            ? _buildLoadingIndicator()
            : _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    );
  }

  Widget _buildLoginForm() {
    return ListView(
      children: [
        UikNavbar(
          size: "",
          titleText: "welcome back!\nLogin to continue",
          leftIcon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(height: 32),
        _buildEmailField(),
        _buildPasswordField(),
        _buildForgotPasswordButton(),
        _buildContinueButton(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmailField() {
    return MyTextField(
      labelText: "Email",
      width: 343,
      height: 64,
      Controller: emailController,
      error: errorEmail,
      description: descEmail,
    );
  }

  Widget _buildPasswordField() {
    return MyTextField(
      labelText: "Password",
      width: 343,
      height: 64,
      Controller: passwordController,
      error: errorPassword,
      isPassword: true,
      description: descPassword,
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () => UiUtils.launchURL(FORGET_PASSWORD_URL),
      child: const Text('Forgot Password'),
    );
  }

  Widget _buildContinueButton() {
    return Container(
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
          if (_isInputValid()) {
            final response = await _performLogin();
            if (response.isSuccess!) {
              _handleSuccessfulLogin(response);
            } else {
              _handleLoginError(response);
            }
          }
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  bool _isInputValid() {
    final emailValid = UiUtils.isEmailValid(emailController.text);
    final passwordValid = passwordController.text.length >= 6;
    if (!emailValid) {
      errorEmail = true;
      descEmail = "Please Enter a valid email";
    } else {
      errorEmail = false;
      descEmail = "";
    }
    if (!passwordValid) {
      errorPassword = true;
      descPassword = "Password must contain at least 6 characters";
    } else {
      errorPassword = false;
      descPassword = "";
    }
    return emailValid && passwordValid;
  }

  Future<ApiResponse> _performLogin() async {
    return ApiRepository.getLoginScreen(
        ApiRequestBody.getLoginRequest(emailController.text, passwordController.text, selectedUserType));
  }

  void _handleSuccessfulLogin(ApiResponse response) {
    UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
    final customerData = response.data[CUSTOMER_DATA];
    if (customerData != null) {
      UserDataHandler.saveCustomerData(customerData);
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const UikBottomNavigationBar(),
      ),
      ModalRoute.withName(ScreenRoutes.loginScreen),
    );
  }

  void _handleLoginError(ApiResponse response) {
    UiUtils.showToast(response.error![MESSAGE]);
  }
}
