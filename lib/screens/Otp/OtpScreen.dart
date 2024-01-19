import 'dart:async';
import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:lokal/constants/colors.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../constants/json_constants.dart';
import '../../utils/storage/preference_constants.dart';
import '../../utils/storage/user_data_handler.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final dynamic args;

  const OtpScreen({
    super.key,
    this.mobileNumber = "",
    this.args,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int seconds = 30; // Change the timer duration to 30 seconds
  String digitSeconds = "30"; // Update the initial digit display
  Timer? timer;
  bool started = true;
  String otpPinEntered = "";
  bool canResendOtp = false; // New variable to track if OTP can be resent
  bool isLoading =
      false; // New variable to track if "Continue" button is loading
  bool isLoadingResendOtp =
      false; // New variable to track if "Resend OTP" button is loading

  @override
  void initState() {
    super.initState();
    _startSmsListener();
    startTimer();
  }

  void _startSmsListener() async {
    try {
      AndroidSmsRetriever.getAppSignature().then((value) {
        setState(() {
          String _applicationSignature = value ?? 'Signature Not Found';
          print("App Signature : $_applicationSignature");
        });
      });

      AndroidSmsRetriever.listenForOneTimeConsent().then((value) async {
        setState(() {
          final intRegex = RegExp(r'\d+', multiLine: true);
          final code = intRegex
              .allMatches(value ?? 'Phone Number Not Found')
              .first
              .group(0);
          print(code);
          String _smsCode = code ?? '12345';
          otpPinEntered = "";
          otpPinEntered = _smsCode;
          AndroidSmsRetriever.stopSmsListener();
        });
        await handleContinueButton();
      }).timeout(Duration(seconds: 30));
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
          digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
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
            widget.args[PHONE_NUMBER],
            otpPinEntered,
            widget.args[USERTYPE],
          ),
        );

        if (response.isSuccess!) {
          UserDataHandler.saveIsOnboardingCoachMarkDisplayed(false);
          UiUtils.showToast(OTP_VERIFIED);
          UserDataHandler.saveUserToken(response.data[AUTH_TOKEN]);
          var customerData = response.data[CUSTOMER_DATA];
          if (customerData != null) {
            UserDataHandler.saveCustomerData(customerData);
          }
          UserDataHandler.saveIsUserVerified(true);
          if(response.data[NEXT_PAGE]!=null){
            final String nextPage = response.data[NEXT_PAGE];
            if(nextPage.isNotEmpty)
              NavigationUtils.openScreenUntil(nextPage);
            else
              NavigationUtils.openScreenUntil(ScreenRoutes.uikBottomNavigationBar);
          }
          else
            NavigationUtils.openScreenUntil(ScreenRoutes.uikBottomNavigationBar);

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
            ApiRequestBody.getLoginAsPhoneRequest(widget.args[PHONE_NUMBER]));
        UiUtils.showToast("OTP Resent to :" + widget.args[PHONE_NUMBER]);
        setState(() {
          canResendOtp = false;
          seconds = 30; // Reset the timer to 30 seconds when OTP is resent
          digitSeconds = "30";
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 34,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ENTER_OTP,
                  style: TextStyle(
                    fontSize: DIMEN_32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "We sent it to ${widget.args[PHONE_NUMBER]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#9E9E9E"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            PinCodeTextField(
              appContext: context,
              length: 6, // Set the length of the OTP
              onChanged: (value) {
                // Handle OTP changes
              },
              onCompleted: handleOtpCompleted,
              textStyle: const TextStyle(fontSize: 20),
              useExternalAutoFillGroup: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.slide,
              animationDuration: const Duration(milliseconds: 300),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
            ),
            // OTPTextField(
            //   length: 6,
            //   width: double.infinity,
            //   fieldWidth: 40,
            //   style: const TextStyle(fontSize: 18),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldStyle: FieldStyle.box,
            //   onCompleted: handleOtpCompleted,
            // ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildContinueButton(),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildResendButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return isLoading
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
                : const Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
          )
        : Text(
            "Resend OTP in 00:$digitSeconds",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: HexColor(HEX_GRAY),
            ),
          );
  }
}
