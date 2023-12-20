import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/preference_constants.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import '../../Widgets/UikButton/UikButton.dart';

class LoginScreen extends StatefulWidget {
  final String? selectedUserType;

  const LoginScreen({Key? key, this.selectedUserType}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final List<String> userTypes = [PARTNER, AGENT];
  bool errorEmail = false;
  bool errorPassword = false;

  bool isLoading = false;
  String selectedUserType = PARTNER;
  bool isPhoneInput = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    emailController.text = UserDataHandler.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: DIMEN_24),
            Padding(
              padding: const EdgeInsets.only(left: DIMEN_21),
              child: _buildTitle(),
            ),
            const SizedBox(height: DIMEN_35),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFfafafa),
      leading: _buildAppBarLeading(),
      centerTitle: true,
      title: _buildAppBarTitle(),
      actions: [
        _buildAppBarAction(),
      ],
    );
  }

  Widget _buildAppBarLeading() {
    return InkWell(
      onTap: () {
        NavigationUtils.openScreen(ScreenRoutes.onboardingScreen);
      },
      child: const Icon(
        Icons.arrow_back_sharp,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      LOGIN,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: DIMEN_18,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAppBarAction() {
    return InkWell(
      onTap: () {
        NavigationUtils.openScreen(ScreenRoutes.signUpScreen);
      },
      child: TextButton(
        onPressed: null, // Use onPressed: null for InkWell
        child: Text(
          REGISTER,
          style: GoogleFonts.poppins(
            color: const Color(0XFF3F51B5),
            fontSize: DIMEN_14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: LOGIN,
            style: GoogleFonts.poppins(
              fontSize: DIMEN_24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF212121),
            ),
          ),
          const TextSpan(text: '\n'),
          TextSpan(
            text: PROVIDE_SERVICES,
            style: GoogleFonts.poppins(
              fontSize: DIMEN_24,
              color: const Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DIMEN_20),
          topRight: Radius.circular(DIMEN_20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: DIMEN_20),
            _buildLoginAsText(),
            const SizedBox(height: DIMEN_20),
            _buildUserTypeSelection(),
            const SizedBox(height: DIMEN_25),
            _buildEmailField(),
            const SizedBox(height: DIMEN_16),
            _buildPasswordField(),
            const SizedBox(height: DIMEN_16),
            _buildForgotPasswordButton(),
            _buildContinueButton(),
            const SizedBox(height: DIMEN_25),
            _buildPrivacyAndTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginAsText() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_20),
      child: Text(
        LOGIN_AS,
        style: GoogleFonts.poppins(
          fontSize: DIMEN_18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_15, right: DIMEN_15),
      child: Container(
        height: DIMEN_52,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(DIMEN_24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  color: isSelected ? Colors.white : null,
                  borderRadius: BorderRadius.circular(DIMEN_24),
                ),
                child: Text(
                  type,
                  style: GoogleFonts.poppins(
                    color: isSelected ? const Color(0xFF212121) : const Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        enableSuggestions: true,
        controller: emailController,
        keyboardType: TextInputType.emailAddress, // Set keyboard type for email
        decoration: InputDecoration(
          hintText: isPhoneInput ? PHONE_OR_EMAIL_INPUT : EMAIL_INPUT,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9E9E9E),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: DIMEN_16,
            horizontal: DIMEN_16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DIMEN_8),
            borderSide: BorderSide.none,
          ),
          errorText: errorEmail ? (isPhoneInput ? VALID_PHONE_NO : VALID_EMAIL) : null,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    final input = emailController.text;
    // Check if the input is a 10-digit phone number
    final isPhoneNumber = input.length == 10 && int.tryParse(input) != null;

    return isPhoneNumber
        ? SizedBox.shrink() // Hide the password field
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        enableSuggestions: true,
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: PASSWORD_INPUT,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9E9E9E),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: DIMEN_16,
            horizontal: DIMEN_16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DIMEN_8),
            borderSide: BorderSide.none,
          ),
          errorText: errorPassword ? PASSWORD_LENGTH : null,
        ),
      ),
    );
  }


  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_20),
      child: InkWell(
        onTap: () {
          UiUtils.launchURL(FORGET_PASSWORD_URL);
        },
        child: TextButton(
          onPressed: null,
          child: Text(
            FORGET_PASSWORD,
            style: GoogleFonts.poppins(
              color: const Color(0xFFF44336),
              fontSize: DIMEN_14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      margin: const EdgeInsets.only(left: DIMEN_20, right: DIMEN_20),
      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.yellow,
      )
          : UikButton(
        text: CONTINUE,
        textWeight: FontWeight.w500,
        textSize: DIMEN_16,
        textColor: const Color(0xFF212121),
        backgroundColor: const Color(0xffFEE440),
        onClick: () async {
          if (_isInputValid()) {
            setState(() {
              isLoading = true;
            });
            try {
              final response = await _performLogin();
              if (response.isSuccess!) {
                _handleSuccessfulLogin(response);
              } else {
                _handleLoginError(response);
              }
            } catch (e) {
              // Handle error
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
      ),
    );
  }

  bool _isInputValid() {
    final input = emailController.text;

    if (input.length == 10 && int.tryParse(input) != null) {
      // Input is a phone number.
      isPhoneInput = true;
      return true;
    } else {
      // Input is an email address.
      isPhoneInput = false;
      final emailValid = UiUtils.isEmailValid(input);
      final passwordValid = passwordController.text.length >= 6;
      errorEmail = !emailValid;
      errorPassword = !passwordValid;
      return emailValid && passwordValid;
    }
  }

  Future<ApiResponse> _performLogin() async {
    final input = emailController.text.toString();
    if (isPhoneInput) {
      return ApiRepository.sendOtpForLogin(ApiRequestBody.getLoginAsPhoneRequest(
          input));
    } else {
      // Call the email login API.
      return ApiRepository.getLoginScreen(ApiRequestBody.getLoginRequest(
          input, passwordController.text, selectedUserType));
    }
  }

  void _handleSuccessfulLogin(ApiResponse response) {
    if(response.data[AUTH_TOKEN]!=null){
      UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
    }
    final customerData = response.data[CUSTOMER_DATA];
    if (customerData != null) {
      UserDataHandler.saveCustomerData(customerData);
    }
    if(isPhoneInput)
    NavigationUtils.openScreen(ScreenRoutes.otpScreen, {"phoneNumber": emailController.text.toString()});
    else
      NavigationUtils.openScreen(ScreenRoutes.uikBottomNavigationBar);
  }

  void _handleLoginError(ApiResponse response) {
    UiUtils.showToast(response.error![MESSAGE]);
  }

  Widget _buildPrivacyAndTermsText() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_16, right: DIMEN_16),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: BY_CONTINUING,
              style: GoogleFonts.poppins(
                color: const Color(0xFF9E9E9E),
              ),
            ),
            TextSpan(
              text: LOKAL_PRIVACY,
              style: GoogleFonts.poppins(
                color: const Color(0xFFBDBDBD),
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UiUtils.launchURL(PRIVACY_POLICY_URL);
                },
            ),
            TextSpan(
              text: AND,
              style: GoogleFonts.poppins(
                color: const Color(0xFF9E9E9E),
              ),
            ),
            TextSpan(
              text: TERMS_OF_USE,
              style: GoogleFonts.poppins(
                color: const Color(0xFFBDBDBD),
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UiUtils.launchURL(TERMS_AND_CONDITIONS_URL);
                },
            ),
          ],
        ),
      ),
    );
  }
}
