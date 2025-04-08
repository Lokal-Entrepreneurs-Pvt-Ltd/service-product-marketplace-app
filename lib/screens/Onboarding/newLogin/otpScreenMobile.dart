// import 'dart:async';
//
// import 'package:android_sms_retriever/android_sms_retriever.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:lokal/constants/dimens.dart';
// import 'package:lokal/constants/json_constants.dart';
// import 'package:lokal/constants/strings.dart';
// import 'package:lokal/screen_routes.dart';
// import 'package:lokal/utils/CodeUtils.dart';
// import 'package:lokal/utils/NavigationUtils.dart';
// import 'package:lokal/utils/UiUtils/UiUtils.dart';
// import 'package:lokal/utils/network/ApiRepository.dart';
// import 'package:lokal/utils/network/ApiRequestBody.dart';
// import 'package:lokal/utils/storage/preference_constants.dart';
// import 'package:lokal/utils/storage/session_utils.dart';
// import 'package:lokal/utils/storage/user_data_handler.dart';
// import 'package:lokal/utils/uik_color.dart';
// import 'package:lokal/widgets/UikButton/UikButton.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:ui_sdk/props/ApiResponse.dart';
// import 'package:ui_sdk/utils/extensions.dart';
//
// class OtpScreenMobile extends StatefulWidget {
//   final String phone;
//   final String userType;
//   final bool isLogin;
//
//   const OtpScreenMobile({
//     Key? key,
//     required this.phone,
//     required this.userType,
//     required this.isLogin,
//   }) : super(key: key);
//
//   @override
//   _OtpScreenMobileState createState() => _OtpScreenMobileState();
// }
//
// class _OtpScreenMobileState extends State<OtpScreenMobile> {
//   final List<TextEditingController> _otpControllers = List.generate(
//     6,
//     (index) => TextEditingController(),
//   );
//   final List<FocusNode> _focusNodes = List.generate(
//     6,
//     (index) => FocusNode(),
//   );
//   bool isLoading = false;
//   String? errorMessage;
//   int resendTimer = 30;
//   bool canResend = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _startResendTimer();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _otpControllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//   void _startResendTimer() {
//     setState(() {
//       resendTimer = 30;
//       canResend = false;
//     });
//
//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted) {
//         setState(() {
//           resendTimer--;
//           if (resendTimer <= 0) {
//             canResend = true;
//           } else {
//             _startResendTimer();
//           }
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => NavigationUtils.pop(),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(DIMEN_16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: DIMEN_24),
//                 _buildTitle(),
//                 const SizedBox(height: DIMEN_16),
//                 _buildSubtitle(),
//                 const SizedBox(height: DIMEN_32),
//                 _buildOtpInput(),
//                 if (errorMessage != null) ...[
//                   const SizedBox(height: DIMEN_16),
//                   _buildErrorMessage(),
//                 ],
//                 const SizedBox(height: DIMEN_32),
//               //  _buildVerifyButton(),
//                 const SizedBox(height: DIMEN_24),
//                 _buildResendCode(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTitle() {
//     return Text(
//       "Enter Verification Code",
//       style: GoogleFonts.poppins(
//         fontSize: DIMEN_24,
//         fontWeight: FontWeight.w600,
//         color: const Color(0xFF212121),
//       ),
//     );
//   }
//
//   Widget _buildSubtitle() {
//     return Text(
//       "We've sent a verification code to ${widget.phone}",
//       style: GoogleFonts.poppins(
//         fontSize: DIMEN_16,
//         color: Colors.grey[600],
//       ),
//     );
//   }
//
//   Widget _buildOtpInput() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(6, (index) {
//         return SizedBox(
//           width: 45,
//           height: 45,
//           child: TextField(
//             controller: _otpControllers[index],
//             focusNode: _focusNodes[index],
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             maxLength: 1,
//             style: GoogleFonts.poppins(
//               fontSize: DIMEN_20,
//               fontWeight: FontWeight.w500,
//             ),
//             decoration: InputDecoration(
//               counterText: "",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: errorMessage != null
//                       ? Colors.red
//                       : UikColor.gengar_500.toColor(),
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: errorMessage != null
//                       ? Colors.red
//                       : UikColor.gengar_500.toColor(),
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: errorMessage != null
//                       ? Colors.red
//                       : UikColor.gengar_500.toColor(),
//                   width: 2,
//                 ),
//               ),
//             ),
//             onChanged: (value) {
//               if (value.length == 1) {
//                 if (index < 5) {
//                   _focusNodes[index + 1].requestFocus();
//                 } else {
//                   _focusNodes[index].unfocus();
//                 }
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildErrorMessage() {
//     return Text(
//       errorMessage!,
//       style: GoogleFonts.poppins(
//         color: Colors.red,
//         fontSize: DIMEN_14,
//       ),
//     );
//   }
//
//   // Widget _buildVerifyButton() {
//   //   return {};
//   //   // return UikButton(
//   //   //   onPressed: _verifyOtp,
//   //   //   text: "Verify",
//   //   //   isLoading: isLoading,
//   //   //   isEnabled: _isOtpComplete(),
//   //   // );
//   // }
//
//   Widget _buildResendCode() {
//     return Center(
//       child: TextButton(
//         onPressed: canResend ? _resendCode : null,
//         child: Text(
//           canResend
//               ? "Resend Code"
//               : "Resend code in ${resendTimer}s",
//           style: GoogleFonts.poppins(
//             color: canResend
//                 ? const Color(0XFF3F51B5)
//                 : Colors.grey,
//             fontSize: DIMEN_14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool _isOtpComplete() {
//     return _otpControllers.every((controller) => controller.text.isNotEmpty);
//   }
//
//   String _getOtp() {
//     return _otpControllers.map((controller) => controller.text).join();
//   }
//
//   void _verifyOtp() async {
//     if (!_isOtpComplete()) {
//       setState(() {
//         errorMessage = "Please enter the complete OTP";
//       });
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//
//     try {
//       final response = await ApiRepository.verifyOtp({
//         'phoneNumber': widget.phone,
//         'otp': _getOtp(),
//         'userType': widget.userType,
//       });
//
//       if (response.isSuccess!) {
//         // After successful verification
//         if (widget.isLogin) {
//           // Save user data and navigate to home screen
//           await UserDataHandler.saveUserData(response.data);
//           NavigationUtils.openScreen(ScreenRoutes.homeScreen);
//         } else {
//           // Navigate to complete profile screen
//           NavigationUtils.openScreen(
//             ScreenRoutes.completeProfileScreen,
//             arguments: {
//               'phone': widget.phone,
//               'userType': widget.userType,
//             },
//           );
//         }
//       } else {
//         setState(() {
//           errorMessage = response.error?['message'] ?? "Invalid OTP. Please try again.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "An error occurred. Please try again.";
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void _resendCode() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//
//     try {
//       final response = await ApiRepository.phoneNumberAuth({
//         'phoneNumber': widget.phone,
//         'userType': widget.userType,
//       });
//
//       if (response.isSuccess!) {
//         _startResendTimer();
//         UiUtils.showToast("Verification code sent successfully");
//       } else {
//         UiUtils.showToast(response.error?['message'] ?? "Failed to resend code. Please try again.");
//       }
//     } catch (e) {
//       UiUtils.showToast("Failed to resend code. Please try again.");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }
