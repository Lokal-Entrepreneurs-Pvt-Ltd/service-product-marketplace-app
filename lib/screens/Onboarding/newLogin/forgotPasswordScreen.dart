import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class ForgetPasswordScreen2 extends StatefulWidget {
  final dynamic args;

  const ForgetPasswordScreen2({Key? key, this.args}) : super(key: key);

  @override
  _ForgetPasswordScreen2State createState() => _ForgetPasswordScreen2State();
}

class _ForgetPasswordScreen2State extends State<ForgetPasswordScreen2> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String otp = "";
  bool errorEmail = false;
  String descEmail = "";

  bool errorPhone = false;
  String descPhone = "";

  bool errorPassword = false;
  String descPassword = "";

  bool errorConfirmPassword = false;
  String descConfirmPassword = "";
  String? email = "";
  String? successText = null;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void initialize() async {
    email = widget.args["email"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(right: 50, top: 15),
                  child: Image.asset(
                    'assets/images/lokal_logo.png',
                    width: 200,
                    height: 100,
                  ),
                ),
                background: Container(color: Colors.white),
              ),
              leading: InkWell(
                onTap: () {
                  NavigationUtils.pop();
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildBody(),
            ),
          ],
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 23),
          _buildLoginAsText("Reset Your Password"),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              children: [
                Text(
                  "OTP sent to : ",
                  style: GoogleFonts.poppins(
                    fontSize: DIMEN_16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF212121),
                  ),
                ),
                Text(
                  email ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: DIMEN_16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildPin(),
          const SizedBox(height: DIMEN_16),
          _buildTextField(
            controller: passwordController,
            hintText: PASSWORD_INPUT,
            // obscureText: obscure,
            // isobscurefield: true,
            errorText: errorPassword ? descPassword : null,
            onChanged: _handlePasswordValidation,
          ),
          const SizedBox(height: DIMEN_16),
          _buildTextField(
            controller: confirmPasswordController,
            hintText: CONFIRM_PASSWORD_INPUT,
            // isobscurefield: true,
            // obscureText: obscure,
            errorText: errorConfirmPassword ? descConfirmPassword : null,
            onChanged: _handleConfirmPasswordValidation,
          ),
          if (successText != null && successText!.isNotEmpty)
            buildText(text: successText!),
          const SizedBox(height: DIMEN_16),
          _buildContinueButton(),
          const SizedBox(height: DIMEN_16),
          _buildPrivacyAndTermsText(),
        ],
      ),
    );
  }

  Widget buildText(
      {required String text,
      double? fontSize,
      FontWeight? fontWeight,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? Colors.green,
        ),
      ),
    );
  }

  Widget _buildLoginAsText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_16),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: DIMEN_18,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }

  void _handlePasswordValidation(String text) {
    if (text.length >= 8) {
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
    if (passwordController.text.length < 8) {
      setState(() {
        errorConfirmPassword = true;
        descConfirmPassword = PASSWORD_LENGTH;
        successText = "";
      });
      return;
    }
    if (text == passwordController.text) {
      setState(() {
        errorConfirmPassword = false;
        descConfirmPassword = '';
        successText = "Password Match";
      });
    } else {
      setState(() {
        errorConfirmPassword = true;
        descConfirmPassword = PASSWORD_NOT_MATCH;
        successText = "";
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9E9E9E),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
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

  Widget _buildContinueButton() {
    bool allFieldsFilled =
        otp.length == 6 && successText != null && successText!.isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(left: DIMEN_16, right: DIMEN_16),
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.yellow,
            )
          : UikButton(
              text: CONTINUE,
              textWeight: FontWeight.w500,
              textSize: DIMEN_16,
              textColor: const Color(0xFF212121),
              backgroundColor: allFieldsFilled ? Colors.yellow : Colors.grey,
              onClick: allFieldsFilled
                  ? () async {
                      try {
                        NavigationUtils.showLoaderOnTop();
                        final response = await ApiRepository.resetPassword({
                          "email": email,
                          "newPassword": passwordController.text,
                          "resetPasswordToken": otp,
                        });
                        if (response.isSuccess!) {
                          NavigationUtils.pushAndPopUntil(
                              ScreenRoutes.loginScreen2,
                              ScreenRoutes.loginScreen2);
                          UiUtils.showToast("Password Reset Successfully!");
                        } else {
                          _handleLoginError(response);
                        }
                      } catch (e) {
                        UiUtils.showToast(e.toString());
                      } finally {
                        NavigationUtils.showLoaderOnTop(false);
                      }
                    }
                  : null,
            ),
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

  Widget _buildPin() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please Enter OTP",
            style: GoogleFonts.poppins(
                color: ("#212121").toColor(),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 8,
          ),
          PinCodeTextField(
            appContext: context,

            length: 6,
            onChanged: (value) {
              // Handle OTP changes
              setState(() {
                otp = value;
              });
            },
            // controller: codeController,
            cursorColor: Colors.black,
            errorTextSpace: 0,
            textStyle: TextStyles.poppins.heading2.regular,
            keyboardType: TextInputType.number,
            animationType: AnimationType.none,
            enableActiveFill: true,
            blinkDuration: Duration.zero,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 64,
              fieldWidth: 48,
              inactiveFillColor: UikColor.giratina_100.toColor(),
              activeFillColor: UikColor.giratina_100.toColor(),
              activeColor: UikColor.giratina_100.toColor(),
              inactiveColor: UikColor.giratina_100.toColor(),
              selectedColor: UikColor.giratina_100.toColor(),
              selectedFillColor: UikColor.giratina_100.toColor(),
            ),
          ),
        ],
      ),
    );
  }
}
