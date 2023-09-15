import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikTextField/UikTextField.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import '../../utils/storage/preference_constants.dart';
import '../signUp/signup_screen.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../pages/UikBottomNavigationBar.dart';
import '../../screen_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  final String? selectedUserType;

  const LoginScreen({Key? key, this.selectedUserType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  List<String> userTypes = [PARTNER, AGENT];
  late TabController _tabController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var errorEmail = false;
  var descEmail = "";

  var errorPassword = false;
  var descPassword = "";

  var errorConfirmPassword = false;
  var descConfirmPassword = "";

  var isAuthError = false;
  var authErrorCode = -1;
  var authErrorMessage = "";
  bool isLoading = false;

  String selectedUserType = PARTNER;

  void initialize() async {
    emailController.text = UserDataHandler.getUserEmail();
    //passwordController.text = await UserDataHandler.getUserPassword();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: DIMEN_24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: DIMEN_21),
                child: _buildTitle(),
              ),
              const SizedBox(
                height: DIMEN_35,
              ),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFFfafafa),
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
        Navigator.pop(context);
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen(),
          ),
        );
      },
      child: TextButton(
        onPressed: null, // Use onPressed: null for InkWell
        child: Text(
          REGISTER,
          style: GoogleFonts.poppins(
              color: Color(0XFF3F51B5),
              fontSize: DIMEN_14,
              fontWeight: FontWeight.w500),
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
          const TextSpan(text: '\n'), // Add a newline here
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
            const SizedBox(
              height: DIMEN_20,
            ),
            _buildLoginAsText(),
            const SizedBox(
              height: DIMEN_20,
            ),
            _buildUserTypeSelection(),
            const SizedBox(
              height: DIMEN_25,
            ),
            _buildEmailField(),
            const SizedBox(
              height: DIMEN_16,
            ),
            _buildPasswordField(),
            const SizedBox(
              height: DIMEN_16,
            ),
            _buildForgotPasswordButton(),
            _buildContinueButton(),
            const SizedBox(
              height: DIMEN_25,
            ),
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
          color: Color(0xFFEEEEEE),
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
                    color: isSelected ? Color(0xFF212121) : Color(0xFF9E9E9E),
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
        controller: emailController,
        decoration: InputDecoration(
          hintText: EMAIL_INPUT,
          hintStyle: GoogleFonts.poppins(
            color: Color(0xFF9E9E9E),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: DIMEN_16,
            horizontal: DIMEN_16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DIMEN_8),
            borderSide: BorderSide.none,
          ),
          errorText: errorEmail ? descEmail : null,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: PASSWORD_INPUT,
          hintStyle: GoogleFonts.poppins(
            color: Color(0xFF9E9E9E),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: DIMEN_16,
            horizontal: DIMEN_16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DIMEN_8),
            borderSide: BorderSide.none,
          ),
          errorText: errorPassword ? descPassword : null,
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
          ? CircularProgressIndicator(
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
      descEmail = VALID_EMAIL;
    } else {
      errorEmail = false;
      descEmail = "";
    }
    if (!passwordValid) {
      errorPassword = true;
      descPassword = PASSWORD_LENGTH;
    } else {
      errorPassword = false;
      descPassword = "";
    }
    return emailValid && passwordValid;
  }

  Future<ApiResponse> _performLogin() async {
    return ApiRepository.getLoginScreen(ApiRequestBody.getLoginRequest(
        emailController.text, passwordController.text, selectedUserType));
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
        builder: (context) => UikBottomNavigationBar(),
      ),
      ModalRoute.withName(ScreenRoutes.loginScreen),
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
                color: Color(0xFF9E9E9E),
              ),
            ),
            TextSpan(
              text: LOKAL_PRIVACY,
              style: GoogleFonts.poppins(
                color: Color(0xFFBDBDBD),
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
                color: Color(0xFF9E9E9E),
              ),
            ),
            TextSpan(
              text: TERMS_OF_USE,
              style: GoogleFonts.poppins(
                color: Color(0xFFBDBDBD),
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
