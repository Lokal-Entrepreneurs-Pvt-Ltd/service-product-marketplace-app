import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/Widgets/UikButton/UikButton.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class LoginScreen2 extends StatefulWidget {
  final String? selectedUserType;

  const LoginScreen2({Key? key, this.selectedUserType}) : super(key: key);

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool errorEmail = false;

  bool isLoading = false;
  String selectedUserType = CUSTOMER;
  final List<String> userTypes = [PARTNER, AGENT, CUSTOMER];
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
      body: Column(
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFfafafa),
      leading: _buildAppBarLeading(),
      actions: [
        _buildAppBarAction(),
      ],
    );
  }

  Widget _buildAppBarLeading() {
    return InkWell(
      onTap: () {
        NavigationUtils.pop();
      },
      child: const Icon(
        Icons.arrow_back_sharp,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAppBarAction() {
    return InkWell(
      onTap: () {
        NavigationUtils.openScreen(ScreenRoutes.signupScreen2);
      },
      child: TextButton(
        onPressed: null, // Use onPressed: null for InkWell
        child: Text(
          "Want to Register?",
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
        'assets/images/lokal_logo.png', // Replace 'your_image.png' with your image asset path
        width: 200, // Set the width of the image as needed
        height: 100, // Set the height of the image as needed
        // You can customize other properties of the image widget as required.
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
            const SizedBox(height: 23),
            _buildLoginAsText(),
            const SizedBox(height: DIMEN_20),
            _buildUserTypeSelection(),
            const SizedBox(height: 23),
            _buildEmailField(),
            const SizedBox(height: DIMEN_16),
            _buildContinueButton(),
            const SizedBox(height: DIMEN_16),
            _buildPrivacyAndTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginAsText() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_16),
      child: Text(
        "Login to Access Lokal Platform",
        style: GoogleFonts.poppins(
          fontSize: DIMEN_18,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: Row(
        children: [
          Text(
            "Login as",
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

  Widget _buildEmailField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        enableSuggestions: true,
        style: GoogleFonts.poppins(),
        controller: emailController,
        keyboardType: TextInputType.emailAddress, // Set keyboard type for email
        decoration: InputDecoration(
          hintText: "Enter Registered Email ID or Mobile No.",
          hintStyle: GoogleFonts.poppins(
            color: UikColor.giratina_400.toColor(),
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
            borderRadius: BorderRadius.circular(DIMEN_8),
            borderSide: BorderSide.none,
          ),
          errorStyle: GoogleFonts.poppins(),
          errorText:
              errorEmail ? (isPhoneInput ? VALID_PHONE_NO : VALID_EMAIL) : null,
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
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
              backgroundColor: const Color(0xffFEE440),
              onClick: () async {
                setState(() {
                  isLoading = true;
                });
                isPhoneInput = UiUtils.isPhoneNoValid(emailController.text);
                bool emailValid = UiUtils.isEmailValid(emailController.text);
                if (isPhoneInput) {
                  final response = await ApiRepository.sendOtpForLogin(
                      ApiRequestBody.getLoginAsPhoneRequest(
                          emailController.text));
                  if (response.isSuccess!) {
                    NavigationUtils.openScreen(ScreenRoutes.otpScreen2, {
                      "phoneNumber": emailController.text.toString(),
                      USERTYPE: selectedUserType
                    });
                  } else {
                    _handleLoginError(response);
                  }
                } else if (emailValid) {
                  NavigationUtils.openScreen(ScreenRoutes.passwordScreen2, {
                    "email": emailController.text,
                    USERTYPE: selectedUserType,
                  });
                } else {
                  UiUtils.showToast("Please Enter Valid Phone no./Email Id");
                }
                setState(() {
                  isLoading = false;
                });
              },
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
}
