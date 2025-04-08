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

import '../../../utils/CodeUtils.dart';

class LoginScreen2 extends StatefulWidget {
  final String? selectedUserType;

  const LoginScreen2({Key? key, this.selectedUserType}) : super(key: key);

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final phoneController = TextEditingController();
  bool errorPhone = false;

  bool isLoading = false;
  String selectedUserType = CANDIDATE;
  final List<String> userTypes = [PARTNER, AGENT, CANDIDATE];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    phoneController.text = UserDataHandler.getUserEmail(); // Optional: clear or keep
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
            const SizedBox(height: 23),
            _buildLoginAsText(),
            const SizedBox(height: DIMEN_20),
            _buildUserTypeSelection(),
            const SizedBox(height: 23),
            _buildPhoneField(),
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
          const SizedBox(width: 41),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: UikColor.gengar_500.toColor()),
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
              ),
              iconSize: 24,
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

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintText: "Enter Valid Mobile No",
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
          errorText: errorPhone ? VALID_PHONE_NO : null,
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.yellow)
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
          try {
            bool isValid = UiUtils.isPhoneNoValid(phoneController.text);
            if (isValid) {
              final response = await ApiRepository.phoneNumberAuth(
                {
                  "phoneNumber": phoneController.text,
                  USERTYPE: CodeUtils.getUserTypeFromDisplay(selectedUserType),
                },
              );
              if (response.isSuccess!) {
                NavigationUtils.openScreen(ScreenRoutes.otpScreen2, {
                  "phoneNumber": phoneController.text,
                  USERTYPE: selectedUserType,
                });
              } else {
                _handleLoginError(response);
              }
            } else {
              setState(() {
                errorPhone = true;
              });
            }
          } catch (e) {
            UiUtils.showToast(e.toString());
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
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UikColor.giratina_500.toColor(),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UiUtils.launchURL(PRIVACY_POLICY_URL);
                },
            ),
            TextSpan(
              text: AND,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: UikColor.giratina_500.toColor(),
              ),
            ),
            TextSpan(
              text: "Terms and Conditions",
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

