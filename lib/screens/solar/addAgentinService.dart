import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/textInputContainer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_sdk/utils/extensions.dart';

class AddAgentInService extends StatefulWidget {
  final dynamic args;
  const AddAgentInService({super.key, this.args});

  @override
  State<AddAgentInService> createState() => _AddAgentInServiceState();
}

class _AddAgentInServiceState extends State<AddAgentInService> {
  String name = "";
  String work = "";
  String email = "";
  String phoneNumber = "";
  String otpPinEntered = "";
  String? errorPhoneMessage = null;
  String? errorEmailMessage = null;
  int seconds = 30; // Change the timer duration to 30 seconds
  // String digitSeconds = "30"; // Update the initial digit display
  Timer? timer;
  bool canResendOtp = false; // New variable to track if OTP can be resent
  bool isLoading =
      false; // New variable to track if "Continue" button is loading
  bool isLoadingResendOtp = false;
  bool fromAllAgent = false;

  @override
  void initState() {
    fromAllAgent = widget.args["fromAllAgent"] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            NavigationUtils.pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1715678068186-shape.svg",
              height: 16,
              width: 20,
            ),
          ),
        ),
      ),
      body: buildBody(),
      persistentFooterButtons: [
        Column(
          children: [
            buildContinueButton(context),
          ],
        )
      ],
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          // canResendOtp = true; // Allow OTP to be resent after the timer ends
          isLoadingResendOtp = false;
          seconds = 30;
        });
        timer.cancel();
      }
    });
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildTitle("Add your team Details", 18, FontWeight.w500),
              ),
              formFilled(),
              buildTitle(
                  "Enter the OTP send on the team member’s registered Mobile Number on Lokal",
                  14,
                  FontWeight.w400),
              _buildPinAndResend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget areaNotAvailable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: buildTitle(
            "We assure Lokal, will arrange in a month, give time of 30 days",
            16,
            FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget formFilled() {
    return Column(
      children: [
        TextInputContainer(
          fieldName: "Name",
          initialValue: name,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              name = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "Work",
          initialValue: work,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            setState(() {
              work = p0 ?? "";
            });
          },
        ),
        TextInputContainer(
          fieldName: "Email",
          initialValue: email,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          onFileSelected: (p0) {
            email = p0 ?? "";
            if (UiUtils.isEmailValid(email) || email.isEmpty) {
              errorEmailMessage = null;
            } else {
              errorEmailMessage = "Please Enter Valid Email";
            }
            setState(() {});
          },
          errorText: errorEmailMessage,
        ),
        TextInputContainer(
          fieldName: "Mobile",
          initialValue: phoneNumber,
          isEnterYourEnabled: false,
          enabled: true,
          showCursor: true,
          textInputType: TextInputType.phone,
          onFileSelected: (p0) {
            phoneNumber = p0 ?? "";
            if (UiUtils.isPhoneNoValid(phoneNumber) || phoneNumber.isEmpty) {
              errorPhoneMessage = null;
            } else {
              errorPhoneMessage = "Please Enter 10 digit Valid Mobile Number";
            }
            setState(() {});
          },
          errorText: errorPhoneMessage,
        ),
      ],
    );
  }

  Widget buildContinueButton(BuildContext context) {
    bool allFieldsFilled = (phoneNumber.isNotEmpty &&
        otpPinEntered.isNotEmpty &&
        email.isNotEmpty &&
        work.isNotEmpty &&
        name.isNotEmpty &&
        errorPhoneMessage == null &&
        errorEmailMessage == null);

    return Container(
      alignment: Alignment.center,
      child: (isLoading)
          ? Container(
              width: double.maxFinite,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.transparent, width: 1.0),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
            )
          : UikButton(
              text: "Save",
              textColor: Colors.black,
              textSize: 16.0,
              textWeight: FontWeight.w500,
              backgroundColor: allFieldsFilled ? Colors.yellow : Colors.grey,
              onClick: allFieldsFilled ? updatedata : null,
            ),
    );
  }

  void updatedata() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await ApiRepository.verifyAndAddAgentOtp({
        "email": email,
        "name": name,
        "mobile": phoneNumber,
        "otp": otpPinEntered,
        "work": work
      });
      if (response.isSuccess!) {
        if (response.data != null) {
          UiUtils.showToast(ADD_AGENT_SUCESSFULL);
          if (fromAllAgent) {
            NavigationUtils.pushAndPopUntil(ScreenRoutes.allAgentForService,
                ScreenRoutes.allAgentForService);
          } else {
            NavigationUtils.pop();
          }
        } else {
          UiUtils.showToast(ADD_AGENT_FAILED);
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error In Request");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTitle(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    );
  }

  void handleOtpCompleted(String pin) async {
    if (pin.length == 6) {
      setState(() {
        otpPinEntered = pin;
      });
    }
  }

  Widget _buildPinAndResend() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      alignment: Alignment.centerLeft,
      child: Column(
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
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(child: _buildResendTimer()),
              Container(
                alignment: Alignment.center,
                width: 98,
                height: 36,
                child: UikButton(
                  text: canResendOtp ? "Resend OTP" : "Send OTP",
                  textColor: Colors.black,
                  textSize: 14.0,
                  textWeight: FontWeight.w400,
                  backgroundColor:
                      !isLoadingResendOtp ? Colors.yellow : Colors.grey,
                  onClick: !isLoadingResendOtp
                      ? () async {
                          if (errorEmailMessage == null &&
                              errorPhoneMessage == null &&
                              phoneNumber.isNotEmpty &&
                              email.isNotEmpty) {
                            setState(() {
                              isLoadingResendOtp = true;
                            });
                            try {
                              final response =
                                  await ApiRepository.addTeamMemberRequest(
                                {
                                  "mobile": phoneNumber,
                                  "email": email,
                                },
                              );

                              if (response.isSuccess!) {
                                UiUtils.showToast("OTP sent successfully");
                                setState(() {
                                  isLoadingResendOtp = true;
                                  canResendOtp = true;
                                });
                                startTimer();
                              }
                            } catch (err) {
                              print(err.toString());
                            }
                            setState(() {
                              isLoadingResendOtp = false;
                            });
                          } else {
                            UiUtils.showToast(
                                "Please Provide correct number and email");
                          }
                        }
                      : null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildResendTimer() {
    return (seconds >= 30)
        ? Container()
        : Text(
            "Resend OTP in 00:$seconds",
            style: TextStyles.poppins.body2.medium.colors(UikColor.gengar_500),
          );
  }
}
