import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

class MobileNumberScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const MobileNumberScreen({Key? key, this.args = const {}}) : super(key: key);

  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final mobileNumberController = TextEditingController();

  bool isLoading = false;
  bool isPhoneInput = true;
  String userName = "";
  String number = "";

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    fetchData();
  }

  void fetchData() async {
    number = widget.args["phoneNumber"] ?? "";
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          setState(() {
            if (number.isEmpty) {
              mobileNumberController.text = userData['phoneNumber'].toString();
            } else {
              mobileNumberController.text = number;
            }
            userName = userData["firstName"] ?? "";
          });
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: DIMEN_24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: DIMEN_21),
              child: _buildTitle(),
            ),
          ),
          _buildBody(),
          // const SizedBox(height: DIMEN_35),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFfafafa),
      leading: _buildAppBarLeading(),
      // actions: [
      //   _buildAppBarAction(),
      // ],
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
            const SizedBox(height: 23),
            _buildEmailField(),
            const SizedBox(height: DIMEN_16),
            _buildContinueButton(),
            const SizedBox(height: DIMEN_16),
            // _buildPrivacyAndTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginAsText() {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hey! $userName Please",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF212121),
            ),
          ),
          Text(
            "Enter Mobile No.",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF212121),
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
        controller: mobileNumberController,
        keyboardType: TextInputType.emailAddress, // Set keyboard type for email
        decoration: InputDecoration(
          hintText: "Enter Mobile No.",
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
          errorText: (!isPhoneInput ? VALID_PHONE_NO : null),
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
                isPhoneInput =
                    UiUtils.isPhoneNoValid(mobileNumberController.text);
                try {
                  if (isPhoneInput) {
                    Map<String, dynamic> map = widget.args ?? {};
                    if (number.isEmpty) {
                      map.addAll({
                        "phoneNumber": mobileNumberController.text.toString()
                      });
                    } else {
                      map["phoneNumber"] =
                          mobileNumberController.text.toString();
                    }

                    final response =
                        await ApiRepository.updateUserAuthForEmail(map);
                    if (response.isSuccess!) {
                      NavigationUtils.openScreen(
                          ScreenRoutes.otpMobileScreen, map);
                    } else {
                      _handleLoginError(response);
                    }
                  } else {
                    UiUtils.showToast("Please Enter Valid Phone no./Email Id");
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
