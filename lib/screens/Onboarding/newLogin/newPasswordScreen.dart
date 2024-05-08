import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/CodeUtils.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/preference_constants.dart';
import 'package:lokal/utils/storage/session_utils.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class PasswordScreen2 extends StatefulWidget {
  final dynamic args;

  const PasswordScreen2({Key? key, this.args}) : super(key: key);

  @override
  _PasswordScreen2State createState() => _PasswordScreen2State();
}

class _PasswordScreen2State extends State<PasswordScreen2> {
  final passwordController = TextEditingController();
  bool errorPassword = false;
  bool isLoading = false;
  bool isPhoneInput = true;
  bool obscureText = false;
  String email = "";
  String selectedUserType = CANDIDATE;
  final List<String> userTypes = [PARTNER, AGENT, CANDIDATE];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    email = widget.args["email"];
    selectedUserType = widget.args[USERTYPE];
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
        NavigationUtils.pop();
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
            _buildPasswordField(),
            const SizedBox(height: DIMEN_16),
            _buildContinueButton(),
            const SizedBox(height: DIMEN_24),
            _buildForgotPasswordButton(),
            const SizedBox(height: DIMEN_20),
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

  Widget _buildPasswordField() {
    // final input = emailController.text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        enableSuggestions: true,
        style: GoogleFonts.poppins(),
        controller: passwordController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: "Enter Your Password",
          hintStyle: GoogleFonts.poppins(
            color: UikColor.giratina_400.toColor(),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
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
          errorText: errorPassword ? PASSWORD_LENGTH : null,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(left: DIMEN_16),
      child: InkWell(
        onTap: () {
          UiUtils.launchURL(FORGET_PASSWORD_URL);
        },
        child: Text(
          FORGET_PASSWORD,
          style: GoogleFonts.poppins(
            color: UikColor.magikarp_400.toColor(),
            fontSize: DIMEN_16,
            fontWeight: FontWeight.w500,
          ),
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
    final passwordValid = passwordController.text.length >= 6;
    errorPassword = !passwordValid;
    setState(() {});
    return passwordValid;
  }

  Future<ApiResponse> _performLogin() async {
    return ApiRepository.getLoginScreen(ApiRequestBody.getLoginRequest(
        email,
        passwordController.text,
        CodeUtils.getUserTypeFromDisplay(selectedUserType)));
  }

  void _handleSuccessfulLogin(ApiResponse response) async {
    if (response.data[AUTH_TOKEN] != null) {
      UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
    }
    final customerData = response.data[CUSTOMER_DATA];
    if (customerData != null) {
      UserDataHandler.saveCustomerData(customerData);
    }
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
    UserDataHandler.saveIsOnboardingCoachMarkDisplayed(false);
    // NavigationUtils.openScreen(ScreenRoutes.mobileNumberScreen);
    if (response.data[NEXT_PAGE] != null) {
      final String nextPage = response.data[NEXT_PAGE];
      if (nextPage.isNotEmpty) {
        if (nextPage.compareTo(ScreenRoutes.mobileNumberScreen) == 0) {
          NavigationUtils.openScreen(nextPage, {
            "userId": customerData["id"].toString(),
            "email": customerData["email"],
            "password": passwordController.text,
            "name": customerData["firstName"],
          });
        } else {
          NavigationUtils.popAllAndPush(nextPage, {"isProgress": true});
        }
      } else {
        NavigationUtils.popAllAndPush(ScreenRoutes.uikBottomNavigationBar);
      }
    } else {
      NavigationUtils.popAllAndPush(ScreenRoutes.uikBottomNavigationBar);
    }
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
