import 'dart:async';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_sdk/utils/extensions.dart';

class NewOTPScreen extends StatefulWidget {
  final dynamic args;

  const NewOTPScreen({Key? key, this.args}) : super(key: key);

  @override
  _NewOTPScreenState createState() => _NewOTPScreenState();
}

class _NewOTPScreenState extends State<NewOTPScreen> {
  int seconds = 30; // Change the timer duration to 30 seconds
  // String digitSeconds = "30"; // Update the initial digit display
  Timer? timer;
  bool started = true;
  String otpPinEntered = "";
  bool canResendOtp = false; // New variable to track if OTP can be resent
  bool isLoading =
      false; // New variable to track if "Continue" button is loading
  bool isLoadingResendOtp =
      false; // New variable to track if "Resend OTP" button is loading
  String selectedUserType = CANDIDATE;
  final List<String> userTypes = [PARTNER, AGENT, CANDIDATE];
  String phoneNumber = "";
  @override
  void initState() {
    super.initState();
    startSmsListener();
    if (widget.args != null) {
      selectedUserType = widget.args[USERTYPE] ?? CANDIDATE;
      phoneNumber = widget.args[PHONE_NUMBER] ?? "";
    }
    startTimer();
  }

  void startSmsListener() async {
    try {
      AndroidSmsRetriever.getAppSignature().then((value) {
        setState(() {
          String _applicationSignature = value ?? 'Signature Not Found';
          print("App Signature : $_applicationSignature");
        });
      });
      String? value = await AndroidSmsRetriever.listenForOneTimeConsent()
          .timeout(Duration(seconds: 30));
      if (value != null) {
        setState(() {
          final intRegex = RegExp(r'\d+', multiLine: true);
          final code = intRegex.allMatches(value).first.group(0);
          print(code);
          String _smsCode = code ?? '12345';
          otpPinEntered = "";
          otpPinEntered = _smsCode;
        });
        await handleContinueButton();
      }
      AndroidSmsRetriever.stopSmsListener();
    } catch (e) {
      print('Error listening for SMS: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          canResendOtp = true; // Allow OTP to be resent after the timer ends
        });
        timer.cancel();
      }
    });
  }

  void handleOtpCompleted(String pin) async {
    if (pin.length == 6) {
      setState(() {
        otpPinEntered = pin;
      });
      await handleContinueButton();
    }
  }

  Future<void> handleContinueButton() async {
    if (otpPinEntered.length == 6) {
      setState(() {
        isLoading = true; // Start loading the "Continue" button
      });
      try {
        final response = await ApiRepository.verifyOtpAndLogin(
          ApiRequestBody.getVerifyOtpRequest(
            phoneNumber,
            otpPinEntered,
            CodeUtils.getUserTypeFromDisplay(selectedUserType),
          ),
        );

        if (response.isSuccess!) {
          UserDataHandler.saveIsOnboardingCoachMarkDisplayed(false);
          UiUtils.showToast(OTP_VERIFIED);
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
          UserDataHandler.saveIsUserVerified(true);
          NavigationUtils.pop();
          if (response.data[NEXT_PAGE] != null) {
            final String nextPage = response.data[NEXT_PAGE];
            if (nextPage.isNotEmpty) {
              NavigationUtils.popAllAndPush(nextPage, {});
            } else {
              NavigationUtils.popAllAndPush(
                  ScreenRoutes.uikBottomNavigationBar, {});
            }
          } else {
            NavigationUtils.popAllAndPush(
                ScreenRoutes.uikBottomNavigationBar, {});
          }
        } else {
          UiUtils.showToast(response.error![MESSAGE]);
        }
      } catch (e) {
        // Handle error
      } finally {
        setState(() {
          isLoading = false; // Stop loading the "Continue" button
        });
      }
    } else {
      // Handle invalid OTP here
      setState(() {
        isLoading = false; // Stop loading the "Continue" button
      });
      UiUtils.showToast(
          "Invalid OTP. Please enter a valid OTP."); // Display an error message for invalid OTP
    }
  }

  Future<void> handleResendOtp() async {
    if (canResendOtp) {
      setState(() {
        isLoadingResendOtp = true; // Start loading the "Resend OTP" button
      });
      try {
        // Implement the logic to resend OTP here
        await ApiRepository.sendOtpForLogin(
            ApiRequestBody.getLoginAsPhoneRequest(phoneNumber));
        UiUtils.showToast("OTP Resent to :$phoneNumber");
        setState(() {
          canResendOtp = false;
          seconds = 30; // Reset the timer to 30 seconds when OTP is resent
          // digitSeconds = "30";
          startSmsListener();
        });
        // Start the timer again
        startTimer();
      } catch (e) {
        // Handle error
      } finally {
        setState(() {
          isLoadingResendOtp = false; // Stop loading the "Resend OTP" button
        });
      }
    }
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
            _buildOtpText(),
            const SizedBox(
              height: 10,
            ),
            _buildPinAndResend(),
            const SizedBox(
              height: 16,
            ),
            _buildContinueButton(),
            const SizedBox(
              height: 16,
            ),
            _buildPrivacyAndTermsText(),
            const SizedBox(height: DIMEN_15),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpText() {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ENTER_OTP,
            style: GoogleFonts.poppins(
              fontSize: DIMEN_32,
              fontWeight: FontWeight.w600,
              color: HexColor("#212121"),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "OTP sent $phoneNumber",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: HexColor("#212121"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinAndResend() {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PinCodeTextField(
            appContext: context,
            length: 6, // Set the length of the OTP
            onChanged: (value) {
              // Handle OTP changes
            },
            cursorColor: Colors.black,
            errorTextSpace: 0,
            onCompleted: handleOtpCompleted,
            textStyle: TextStyles.poppins.heading2.regular,
            keyboardType: TextInputType.number,
            animationType: AnimationType.slide,
            animationDuration: const Duration(milliseconds: 300),
            useExternalAutoFillGroup: true,
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _buildResendButton(),
          ),
        ],
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
              onClick: handleContinueButton,
            ),
    );
  }

  Widget _buildResendButton() {
    return canResendOtp
        ? InkWell(
            onTap: handleResendOtp,
            child: isLoadingResendOtp
                ? const CircularProgressIndicator(
                    color: Colors.yellow,
                  )
                : Text(
                    "Resend OTP",
                    style: TextStyles.poppins.body1.medium
                        .colors(UikColor.gengar_500),
                  ),
          )
        : Text(
            "Resend OTP in 00:$seconds",
            style: TextStyles.poppins.body1.medium.colors(UikColor.gengar_500),
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
