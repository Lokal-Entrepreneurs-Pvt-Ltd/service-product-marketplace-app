import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/preference_constants.dart';
import 'package:lokal/utils/storage/session_utils.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:ui_sdk/utils/extensions.dart';

class SignupScreen2 extends StatefulWidget {
  const SignupScreen2({Key? key}) : super(key: key);

  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController referralIdController = TextEditingController();
  String selectedUserType = PARTNER;
  final List<String> userTypes = [PARTNER, AGENT, CANDIDATE];

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
  bool obscure = true;
  bool referralError = false;
  String referredAgentName = "";
  String referredAgentAddress = "";
  String referralErrorText = "";
  String referredByCode = "";

  void referralFetch(String code) async {
    final response = await ApiRepository.getUserByLokalIDorPhoneNumber(
        {"lokalIdOrPhone": code});
    if (response.isSuccess!) {
      final userData = response.data;
      if (userData != null) {
        referredAgentName = userData["firstName"] ?? "";
        if (referredAgentName.isEmpty) {
          referredAgentName = userData["phoneNumber"] ?? "";
        }
        if (referredAgentName.isEmpty) {
          referredAgentName = userData["email"] ?? "";
        }
        referredAgentAddress =
            "${userData["locality"]}${userData["locality"].isNotEmpty ? ", " : ""}"
            "${userData["administrativeArea"]}${userData["administrativeArea"].isNotEmpty ? ", " : ""}"
            "${userData["country"]}${userData["country"].isNotEmpty ? ", " : ""}"
            "${userData["postalCode"]}";
        if (referredAgentName.isNotEmpty || referredAgentAddress.isNotEmpty) {
          setState(() {
            referredByCode = code;
            referralError = false;
          });
        } else {
          setState(() {
            referralError = true;
            referralErrorText = "Please Check Referral Code";
          });
        }
      } else {
        setState(() {
          referralError = true;
          referralErrorText = "Please Check Referral Code";
        });
      }
    } else {
      setState(() {
        referralError = true;
        referralErrorText = "Please Check Referral Code";
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: DIMEN_24),
          _buildTitle(),
          const SizedBox(height: DIMEN_12),
          Expanded(
            child: _buildSignupForm(),
          ),
        ],
      ),
    );
  }

  Widget referralText() {
    return (referredAgentName.isNotEmpty || referredAgentAddress.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Referred By  $referredAgentName",
                    style: TextStyles.poppins.body1.medium
                        .colors(UikColor.venusaur_500),
                  ),
                  Text(
                    referredAgentAddress,
                    style: TextStyles.poppins.body1.medium
                        .colors(UikColor.venusaur_500),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildSingupAsText() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_16),
      child: Text(
        "Welcome to Lokal",
        style: GoogleFonts.poppins(
          fontSize: DIMEN_18,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFfafafa),
      actions: [
        _buildLoginButton(),
      ],
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

  Widget _buildUserTypeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: Row(
        children: [
          Text(
            "Register as",
            style: GoogleFonts.poppins(
              fontSize: DIMEN_20,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ),
          ),
          const SizedBox(width: 41), // Add spacing between text and dropdown
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: UikColor.gengar_500.toColor()),
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: DropdownButton<String>(
              value: selectedUserType,
              icon: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.network(
                    "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1710760508910-chevron-down.svg"),
              ), // Custom dropdown icon
              iconSize: 24,
              iconEnabledColor: UikColor.gengar_500.toColor(),
              elevation: 16,
              borderRadius: BorderRadius.circular(12),
              alignment: Alignment.center,
              underline: Container(),
              padding: const EdgeInsets.all(0),
              onChanged: (String? value) {
                setState(() {
                  selectedUserType = value!;
                });
              },
              items: userTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: UikColor.gengar_500.toColor(),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
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
            const SizedBox(height: 23),
            _buildSingupAsText(),
            const SizedBox(height: DIMEN_20),
            _buildUserTypeSelection(),
            const SizedBox(height: 23),
            _buildTextField(
              controller: emailController,
              hintText: EMAIL_INPUT,
              errorText: errorEmail ? descEmail : null,
              onChanged: _handleEmailValidation,
            ),
            const SizedBox(height: DIMEN_16),
            _buildTextField(
              controller: phoneNoController,
              hintText: MOB,
              errorText: errorPhone ? descPhone : null,
              onChanged: _handlePhoneNumberValidation,
            ),
            const SizedBox(height: DIMEN_16),
            _buildTextField(
              controller: passwordController,
              hintText: PASSWORD_INPUT,
              obscureText: obscure,
              isobscurefield: true,
              errorText: errorPassword ? descPassword : null,
              onChanged: _handlePasswordValidation,
            ),
            const SizedBox(height: DIMEN_16),
            _buildTextField(
              controller: confirmPasswordController,
              hintText: CONFIRM_PASSWORD_INPUT,
              isobscurefield: true,
              obscureText: obscure,
              errorText: errorConfirmPassword ? descConfirmPassword : null,
              onChanged: _handleConfirmPasswordValidation,
            ),
            const SizedBox(height: DIMEN_16),
            _buildTextField(
              controller: referralIdController,
              hintText: ENTER_REFERRAL,
              errorText: referralError ? referralErrorText : null,
              onChanged: _referralHandler,
            ),
            referralText(),
            const SizedBox(height: DIMEN_16),
            _buildSignupButton(),
            const SizedBox(height: DIMEN_16),
            _buildPrivacyAndTermsText(),
            const SizedBox(height: DIMEN_16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    bool isobscurefield = false,
    String? errorText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9E9E9E),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: (isobscurefield)
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: DIMEN_20,
            horizontal: DIMEN_16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DIMEN_12),
            borderSide: BorderSide.none,
          ),
          errorStyle: GoogleFonts.poppins(),
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSignupButton() {
    return Container(
      margin: const EdgeInsets.only(left: DIMEN_16, right: DIMEN_16),
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
                color: UikColor.giratina_500.toColor(),
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: LOKAL_PRIVACY,
              style: GoogleFonts.poppins(
                color: UikColor.giratina_500.toColor(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UiUtils.launchURL(PRIVACY_POLICY_URL);
                },
            ),
            TextSpan(
              text: AND,
              style: GoogleFonts.poppins(
                color: UikColor.giratina_500.toColor(),
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: "Terms and Conditons",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UikColor.giratina_500.toColor(),
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
        NavigationUtils.openScreenUntil(ScreenRoutes.loginScreen2);
      },
      child: TextButton(
        onPressed: null,
        child: Text(
          "Already Registered? Login",
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

  void _referralHandler(String code) {
    if (code.length == 9 || code.length == 10) {
      referralFetch(code);
    } else {
      setState(() {
        referredByCode = "";
        referredAgentName = "";
        referredAgentAddress = "";
      });
      if (code.isEmpty) {
        setState(() {
          referralError = false;
          referralErrorText = "";
        });
      } else {
        setState(() {
          referralError = true;
          referralErrorText = "Enter Referral Code";
        });
      }
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
        confirmPasswordController.text == passwordController.text &&
        UiUtils.isPhoneNoValid(phoneNoController.text)) {
      try {
        await NavigationUtils.showLoaderOnTop();
        final response = await ApiRepository.signupByPhoneNumberOrEmail(
          ApiRequestBody.getSignUpRequest(
            emailController.text,
            passwordController.text,
            CUSTOMER,
            phoneNoController.text,
            referredByCode,
          ),
        );

        if (response.isSuccess!) {
          if (response.data[AUTH_TOKEN] != null)
            UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
          await SessionManager.saveSession(Session(lastLogin: DateTime.now()));
          final Session? session = await SessionManager.getSession();
          if (session != null) {
            print(session.userId);
            print("dsfsvfv___________________---------------------0");
            print(session.lastLogin);
            print(session.openedTime);
            print(session.deviceId);
            print(session.sessionId);
          }
          var customerData = response.data[CUSTOMER_DATA];
          if (customerData != null) {
            UserDataHandler.saveCustomerData(customerData);
          }
          NavigationUtils.pop();
          NavigationUtils.openScreen(ScreenRoutes.otpScreen, {
            "phoneNumber": phoneNoController.text.toString(),
            USERTYPE: CUSTOMER
          });
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }
      } catch (e) {
        UiUtils.showToast(e.toString());
      } finally {
        NavigationUtils.showLoaderOnTop(false);
      }
    }

    _handleEmailValidation(emailController.text);
    _handlePasswordValidation(passwordController.text);
    _handleConfirmPasswordValidation(confirmPasswordController.text);
    _handlePhoneNumberValidation(phoneNoController.text);
  }
}
