import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import '../../constants/dimens.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/storage/preference_constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool errorEmail = false;
  String descEmail = "";

  bool errorPhone = false;
  String descPhone = "";

  bool errorPassword = false;
  String descPassword = "";

  bool errorConfirmPassword = false;
  String descConfirmPassword = "";

  bool isLoading = false;
  bool isAuthError = false;
  int authErrorCode = -1;
  String authErrorMessage = "";

  final List<String> userTypes = [PARTNER, AGENT];
  String selectedUserType = PARTNER;

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
            _buildTitle(),
            const SizedBox(height: DIMEN_35),
            Expanded(
              child: _buildSignupForm(),
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
      centerTitle: true,
      title: Text(
        REGISTER_NEW,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: DIMEN_18,
          color: Colors.black,
        ),
      ),
      actions: [
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_21),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: REGISTER_NEW,
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
      ),
    );
  }

  Widget _buildSignupForm() {
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
            _buildUserTypeSelection(),
            const SizedBox(height: DIMEN_20),
            _buildTextField(
              controller: emailController,
              hintText: EMAIL_INPUT,
              errorText: errorEmail ? descEmail : null,
              onChanged: _handleEmailValidation,
            ),
            const SizedBox(height: DIMEN_20),
            _buildTextField(
              controller: phoneNoController,
              hintText: PHONE_INPUT,
              errorText: errorPhone ? descPhone : null,
              onChanged: _handlePhoneNumberValidation,
            ),
            const SizedBox(height: DIMEN_20),
            _buildTextField(
              controller: passwordController,
              hintText: PASSWORD_INPUT,
              obscureText: true,
              errorText: errorPassword ? descPassword : null,
              onChanged: _handlePasswordValidation,
            ),
            const SizedBox(height: DIMEN_20),
            _buildTextField(
              controller: confirmPasswordController,
              hintText: CONFIRM_PASSWORD_INPUT,
              obscureText: true,
              errorText: errorConfirmPassword ? descConfirmPassword : null,
              onChanged: _handleConfirmPasswordValidation,
            ),
            const SizedBox(height: DIMEN_20),
            _buildSignupButton(),
            const SizedBox(height: DIMEN_15),
            _buildPrivacyAndTermsText(),
          ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? errorText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
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
            borderRadius: BorderRadius.circular(DIMEN_12),
            borderSide: BorderSide.none,
          ),
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSignupButton() {
    return Container(
      margin: const EdgeInsets.only(left: DIMEN_20, right: DIMEN_20),
      child: UikButton(
        text: CONTINUE,
        textWeight: FontWeight.w500,
        textSize: DIMEN_16,
        textColor: const Color(0xFF212121),
        backgroundColor: const Color(0xffFEE440),
        onClick: _handleSignup,
      ),
    );
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

  Widget _buildLoginButton() {
    return InkWell(
      onTap: () {
        NavigationUtils.openScreen(ScreenRoutes.loginScreen);
      },
      child: TextButton(
        onPressed: null,
        child: Text(
          LOGIN_NEW,
          style: GoogleFonts.poppins(
            color: const Color(0XFF3F51B5),
            fontSize: DIMEN_14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  // Custom phone number validation logic for Indian numbers
  void _handlePhoneNumberValidation(String phoneNo) {

    if (UiUtils.isPhoneNoValid(phoneNo)) {
      setState(() {
        errorPhone = false;
        descPhone = '';
      });
    } else {
      setState(() {
        errorPhone = true;
        descPhone = VALID_PHONE_NO;
      });
    }
  }

  void _handleEmailValidation(String text) {
    if (UiUtils.isEmailValid(text)) {
      setState(() {
        errorEmail = false;
        descEmail = '';
      });
    } else {
      setState(() {
        errorEmail = true;
        descEmail = VALID_EMAIL;
      });
    }
  }

  void _handlePasswordValidation(String text) {
    if (text.length >= 6) {
      setState(() {
        errorPassword = false;
        descPassword = '';
      });
    } else {
      setState(() {
        errorPassword = true;
        descPassword = PASSWORD_LENGTH;
      });
    }
  }

  void _handleConfirmPasswordValidation(String text) {
    if (text == passwordController.text) {
      setState(() {
        errorConfirmPassword = false;
        descConfirmPassword = '';
      });
    } else {
      setState(() {
        errorConfirmPassword = true;
        descConfirmPassword = PASSWORD_NOT_MATCH;
      });
    }
  }

  Future<void> _handleSignup() async {
    if (UiUtils.isEmailValid(emailController.text) &&
        passwordController.text.length >= 6 &&
        confirmPasswordController.text == passwordController.text && UiUtils.isPhoneNoValid(phoneNoController.text)) {
      NavigationUtils.showLoaderOnTop();
      final response = await ApiRepository.signupByPhoneNumberOrEmail(
        ApiRequestBody.getSignUpRequest(
          emailController.text,
          passwordController.text,
          selectedUserType,
          phoneNoController.text
        ),
      ).catchError((error) {
        NavigationUtils.pop();
      });

      NavigationUtils.pop();

      if (response.isSuccess!) {
        if(response.data[AUTH_TOKEN]!=null)
        UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
        var customerData = response.data[CUSTOMER_DATA];
        if (customerData != null) {
          UserDataHandler.saveCustomerData(customerData);
        }
        NavigationUtils.pop();
        NavigationUtils.openScreen(ScreenRoutes.otpScreen, {"phoneNumber": phoneNoController.text.toString()});
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    }

    _handleEmailValidation(emailController.text);
    _handlePasswordValidation(passwordController.text);
    _handleConfirmPasswordValidation(confirmPasswordController.text);
    _handlePhoneNumberValidation(phoneNoController.text);
  }
}
