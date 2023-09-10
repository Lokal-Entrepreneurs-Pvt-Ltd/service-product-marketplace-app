import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../Widgets/UikTextField/UikTextField.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../pages/UikBottomNavigationBar.dart';
import '../../screen_routes.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/storage/preference_constants.dart';
import '../../utils/storage/user_data_handler.dart';
import '../signUp/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOnboardingScreen extends StatefulWidget {
  final String? selectedUserType;

  const NewOnboardingScreen({super.key, this.selectedUserType});

  @override
  _NewOnboardingScreenState createState() => _NewOnboardingScreenState();
}

class _NewOnboardingScreenState extends State<NewOnboardingScreen>
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFfafafa),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            LOGIN,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: DIMEN_18,
              color: Colors.black,
            ),
          ),
          actions: [
            InkWell(
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
            ),
          ],
        ),
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
                child: RichText(
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
                ),
              ),
              const SizedBox(
                height: DIMEN_35,
              ),
              Expanded(
                child: Container(
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
                          Padding(
                            padding: const EdgeInsets.only(left: DIMEN_20),
                            child: Text(
                              LOGIN_AS,
                              style: GoogleFonts.poppins(
                                fontSize: DIMEN_18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF212121),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: DIMEN_20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: DIMEN_15, right: DIMEN_15),
                            child: Container(
                              height: DIMEN_52,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(DIMEN_24),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround, // Equal spacing
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
                                        color: isSelected
                                            ? Colors.white
                                            : null, // No background for unselected items
                                        borderRadius:
                                            BorderRadius.circular(DIMEN_24),
                                      ),
                                      child: Text(
                                        type,
                                        style: GoogleFonts.poppins(
                                          color: isSelected
                                              ? Color(0xFF212121)
                                              : Color(
                                                  0xFF9E9E9E), // Green text for unselected items
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: DIMEN_25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: DIMEN_16),
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
                          ),
                          const SizedBox(
                            height: DIMEN_16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: DIMEN_16),
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
                                  horizontal:
                                      DIMEN_16, // Add horizontal padding here
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(DIMEN_8),
                                  borderSide: BorderSide.none,
                                ),
                                errorText: errorPassword ? descPassword : null,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: DIMEN_16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: DIMEN_20,
                            ),
                            child: InkWell(
                              onTap: () {
                                UiUtils.launchURL(FORGET_PASSWORD_URL);
                              },
                              child: TextButton(
                                onPressed:
                                    null, // Use onPressed: null for InkWell
                                child: Text(
                                  ISSUE_WITH_PASS,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFF44336),
                                    fontSize: DIMEN_14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: DIMEN_20, right: DIMEN_20),
                            child: UikButton(
                              text: CONTINUE,
                              textWeight: FontWeight.w500,
                              textSize: DIMEN_16,
                              textColor: const Color(0xFF212121),
                              backgroundColor: const Color(0xffFEE440),
                              onClick: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (UiUtils.isEmailValid(
                                        emailController.text) &&
                                    passwordController.text.length >= 6) {
                                  final response =
                                      await ApiRepository.getLoginScreen(
                                          ApiRequestBody.getLoginRequest(
                                              emailController.text,
                                              passwordController.text,
                                              selectedUserType));
                                  if (response.isSuccess!) {
                                    UserDataHandler.saveUserToken(
                                        response.data[AUTH_TOKEN]);

                                    var customerData =
                                        response.data[CUSTOMER_DATA];
                                    if (customerData != null) {
                                      UserDataHandler.saveCustomerData(
                                          customerData);
                                    }

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UikBottomNavigationBar(),
                                      ),
                                      ModalRoute.withName(
                                          ScreenRoutes.loginScreen),
                                    );
                                  } else {
                                    UiUtils.showToast(response.error![MESSAGE]);
                                  }
                                }

                                if (UiUtils.isEmailValid(
                                    emailController.text)) {
                                  errorEmail = false;
                                  descEmail = '';
                                } else {
                                  errorEmail = true;
                                  descEmail = VALID_EMAIL;
                                }

                                if (passwordController.text.length >= 6) {
                                  errorPassword = false;
                                  descPassword = '';
                                } else {
                                  errorPassword = true;
                                  descPassword = PASSWORD_LENGTH;
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: DIMEN_25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: DIMEN_16, right: DIMEN_16),
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
                                      color: Color(
                                          0xFFBDBDBD), // Make the link text blue
                                      decoration: TextDecoration
                                          .underline, // Add underline to the link text
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
                                      color: Color(
                                          0xFFBDBDBD), // Make the link text blue
                                      decoration: TextDecoration
                                          .underline, // Add underline to the link text
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        UiUtils.launchURL(
                                            TERMS_AND_CONDITIONS_URL);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
