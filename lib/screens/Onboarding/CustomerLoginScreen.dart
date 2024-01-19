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

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({Key? key}) : super(key: key);

  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final phoneController = TextEditingController();
  bool errorPhone = false;

  bool isLoading = false;
  String selectedUserType = CUSTOMER; // Default to CUSTOMER

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
        NavigationUtils.openScreen(ScreenRoutes.customerSignUpScreen);
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
    return Center(
      child: Image.asset(
        'assets/images/lokal_logo.png',
        width: 200,
        height: 100,
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
            _buildPhoneField(),
            const SizedBox(height: DIMEN_16),
            _buildContinueButton(),
            const SizedBox(height: DIMEN_25),
            _buildPrivacyAndTermsText(),
            const SizedBox(height: DIMEN_25),
            _buildAreYouText()
          ],
        ),
      ),
    );
  }

  Widget _buildAreYouText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navigate to the new route for Partner/Agent
          NavigationUtils.openScreen(ScreenRoutes.loginScreen);
        },
        child: Text(
          'Are you Lokal Partner/Agent ?',
          style: GoogleFonts.poppins(
            color: Colors.red, // Change the color to red
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginAsText() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_20),
      child: Text(
        LOGIN,
        style: GoogleFonts.poppins(
          fontSize: DIMEN_18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        enableSuggestions: true,
        controller: phoneController,
        keyboardType: TextInputType.phone, // Change keyboardType to phone
        decoration: InputDecoration(
          hintText: PHONE_INPUT, // Change hint text to PHONE_INPUT
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
          errorText: errorPhone ? VALID_PHONE_NO : null, // Update error text
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
    final input = phoneController.text;
    final phoneValid = _isValidPhoneNumber(input);
    errorPhone = !phoneValid;
    return phoneValid;
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // You can implement your own phone number validation logic here
    // For now, it just checks if the phone number is not empty
    return phoneNumber.isNotEmpty;
  }

  Future<ApiResponse> _performLogin() async {
    final input = phoneController.text.toString();
    return ApiRepository.sendOtpForLogin(ApiRequestBody.getLoginAsPhoneRequest(
      input,
    ));
  }

  void _handleSuccessfulLogin(ApiResponse response) {
    UserDataHandler.saveIsOnboardingCoachMarkDisplayed(false);
    NavigationUtils.openScreen(
      ScreenRoutes.otpScreen,
      {"phoneNumber": phoneController.text.toString(), USERTYPE: selectedUserType},
    );
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
