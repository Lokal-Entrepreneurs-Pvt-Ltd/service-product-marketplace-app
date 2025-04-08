// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lokal/constants/dimens.dart';
// import 'package:lokal/constants/json_constants.dart';
// import 'package:lokal/constants/strings.dart';
// import 'package:lokal/screen_routes.dart';
// import 'package:lokal/utils/NavigationUtils.dart';
// import 'package:lokal/utils/UiUtils/UiUtils.dart';
// import 'package:lokal/utils/network/ApiRepository.dart';
// import 'package:lokal/utils/network/ApiRequestBody.dart';
// import 'package:lokal/utils/storage/user_data_handler.dart';
// import 'package:lokal/utils/uik_color.dart';
// import 'package:lokal/widgets/UikButton/UikButton.dart';
// import 'package:ui_sdk/utils/extensions.dart';
//
// class UnifiedAuthScreen extends StatefulWidget {
//   const UnifiedAuthScreen({Key? key}) : super(key: key);
//
//   @override
//   _UnifiedAuthScreenState createState() => _UnifiedAuthScreenState();
// }
//
// class _UnifiedAuthScreenState extends State<UnifiedAuthScreen> {
//   final TextEditingController phoneController = TextEditingController();
//   String selectedUserType = PARTNER;
//   final List<String> userTypes = [PARTNER, AGENT, CANDIDATE];
//   bool isLoading = false;
//   bool isLogin = true; // Toggle between login and signup
//
//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildAppBar(),
//             const SizedBox(height: DIMEN_24),
//             _buildLogo(),
//             const SizedBox(height: DIMEN_24),
//             Expanded(
//               child: _buildAuthForm(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: DIMEN_16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => NavigationUtils.pop(),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 isLogin = !isLogin;
//               });
//             },
//             child: Text(
//               isLogin ? "New to Lokal? Sign Up" : "Already have an account? Login",
//               style: GoogleFonts.poppins(
//                 color: const Color(0XFF3F51B5),
//                 fontSize: DIMEN_14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogo() {
//     return Center(
//       child: Image.asset(
//         'assets/images/lokal_logo.png',
//         width: 200,
//         height: 100,
//       ),
//     );
//   }
//
//   Widget _buildAuthForm() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(DIMEN_20),
//           topRight: Radius.circular(DIMEN_20),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(DIMEN_16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: DIMEN_24),
//               _buildTitle(),
//               const SizedBox(height: DIMEN_24),
//               _buildUserTypeSelection(),
//               const SizedBox(height: DIMEN_24),
//               _buildPhoneField(),
//               const SizedBox(height: DIMEN_32),
//               _buildContinueButton(),
//               const SizedBox(height: DIMEN_16),
//               _buildPrivacyAndTermsText(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTitle() {
//     return Text(
//       isLogin ? "Welcome Back!" : "Create Your Account",
//       style: GoogleFonts.poppins(
//         fontSize: DIMEN_24,
//         fontWeight: FontWeight.w600,
//         color: const Color(0xFF212121),
//       ),
//     );
//   }
//
//   Widget _buildUserTypeSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           isLogin ? "Login as" : "Register as",
//           style: GoogleFonts.poppins(
//             fontSize: DIMEN_16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF000000),
//           ),
//         ),
//         const SizedBox(height: DIMEN_8),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: UikColor.gengar_500.toColor()),
//             borderRadius: BorderRadius.circular(100),
//             color: Colors.white,
//           ),
//           height: 48,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: DropdownButton<String>(
//             value: selectedUserType,
//             icon: Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: SvgPicture.network(
//                 "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1710760508910-chevron-down.svg",
//               ),
//             ),
//             iconSize: 24,
//             iconEnabledColor: UikColor.gengar_500.toColor(),
//             elevation: 16,
//             borderRadius: BorderRadius.circular(12),
//             alignment: Alignment.center,
//             underline: Container(),
//             isExpanded: true,
//             onChanged: (String? value) {
//               setState(() {
//                 selectedUserType = value!;
//               });
//             },
//             items: userTypes.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: GoogleFonts.poppins(
//                     fontSize: DIMEN_16,
//                     fontWeight: FontWeight.w400,
//                     color: UikColor.gengar_500.toColor(),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPhoneField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Phone Number",
//           style: GoogleFonts.poppins(
//             fontSize: DIMEN_16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF000000),
//           ),
//         ),
//         const SizedBox(height: DIMEN_8),
//         TextField(
//           controller: phoneController,
//           keyboardType: TextInputType.phone,
//           decoration: InputDecoration(
//             hintText: "Enter your phone number",
//             hintStyle: GoogleFonts.poppins(
//               color: UikColor.giratina_400.toColor(),
//               fontSize: DIMEN_16,
//               fontWeight: FontWeight.w400,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: DIMEN_16,
//               horizontal: DIMEN_16,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: UikColor.gengar_500.toColor(),
//                 width: 1,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: UikColor.gengar_500.toColor(),
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: UikColor.gengar_500.toColor(),
//                 width: 2,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContinueButton() {
//     return UikButton(
//       onClick: () {
//         if (phoneController.text.isNotEmpty) {
//           _handleAuth();
//         }
//       },
//       text: "Continue",
//       // isLoading: isLoading,
//       // isEnabled: phoneController.text.isNotEmpty,
//     );
//   }
//
//   Widget _buildPrivacyAndTermsText() {
//     return Center(
//       child: RichText(
//         text: TextSpan(
//           text: "By continuing, you agree to our ",
//           style: GoogleFonts.poppins(
//             color: Colors.grey[600],
//             fontSize: DIMEN_14,
//           ),
//           children: [
//             TextSpan(
//               text: "Terms of Service",
//               style: GoogleFonts.poppins(
//                 color: const Color(0XFF3F51B5),
//                 fontWeight: FontWeight.w500,
//               ),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   // Handle terms of service tap
//                 },
//             ),
//             const TextSpan(text: " and "),
//             TextSpan(
//               text: "Privacy Policy",
//               style: GoogleFonts.poppins(
//                 color: const Color(0XFF3F51B5),
//                 fontWeight: FontWeight.w500,
//               ),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   // Handle privacy policy tap
//                 },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _handleAuth() async {
//     if (phoneController.text.isEmpty) {
//       UiUtils.showToast("Please enter your phone number");
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await ApiRepository.pho({
//         'phoneNumber': phoneController.text,
//         'userType': selectedUserType,
//       });
//
//       if (response.isSuccess!) {
//         // After successful API call, navigate to OTP screen
//         NavigationUtils.openScreen(
//           ScreenRoutes.otpScreen2,
//            {
//             'phone': phoneController.text,
//             'userType': selectedUserType,
//             'isLogin': isLogin,
//           },
//         );
//       } else {
//         UiUtils.showToast(response.error?['message'] ?? "An error occurred. Please try again.");
//       }
//     } catch (e) {
//       UiUtils.showToast("An error occurred. Please try again.");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }