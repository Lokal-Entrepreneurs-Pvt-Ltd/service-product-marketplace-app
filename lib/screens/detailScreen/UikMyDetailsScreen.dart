import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../main.dart';
import '../../screen_routes.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';

// move to screen folder

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

var showVerifyPhoneNumber = false;

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final GSTController = TextEditingController();

  final authToken = UserDataHandler.getUserToken();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() {
    emailController.text = UserDataHandler.getUserEmail();
    phoneController.text = UserDataHandler.getUserPhone();
    nameController.text = UserDataHandler.getUserName();
    birthController.text = UserDataHandler.getUserDob();
    GSTController.text = UserDataHandler.getUserGST();
    showVerifyPhoneNumber = UserDataHandler.getUserPhone().isNotEmpty &&
        !UserDataHandler.getIsUserVerified();
  }

  String setButtonText() {
    if (showVerifyPhoneNumber) {
      return VERIFY_NUMBER;
    }
    return SAVE_DETAILS;
  }

  Future<void> handleOnButtonClick() async {
    if (nameController.text.isEmpty) {
      UiUtils.showToast(ENTER_EMAIL);
      return;
    } else if (phoneController.text.isEmpty) {
      UiUtils.showToast(ENTER_PHONE);
      return;
    } else if (emailController.text.isEmpty) {
      UiUtils.showToast(ENTER_EMAIL);
      return;
    } else if (GSTController.text.isEmpty) {
      UiUtils.showToast(ENTER_GST);
      return;
    }

    if (showVerifyPhoneNumber) {
      final response = await ApiRepository.sendOtp(
        ApiRequestBody.getSendOtpRequest(phoneController.text),
      );

      if (response.isSuccess!) {
        UiUtils.showToast(OTP_SENT);

        var context = NavigationService.navigatorKey.currentContext;
        Navigator.pushNamed(
          context!,
          ScreenRoutes.otpScreen,
          arguments: phoneController.text,
        );
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } else {
      final response = await ApiRepository.updateCustomerInfo(
        ApiRequestBody.getSaveDetailsRequest(
          nameController.text,
          emailController.text,
          GSTController.text,
          birthController.text,
          phoneController.text,
        ),
      );

      if (response.isSuccess!) {
        var customerData = response.data;
        if (customerData != null) {
          UserDataHandler.saveCustomerData(customerData);
        }

        UiUtils.showToast(ACCOUNT_DETAILS_UPDATED);

        Navigator.of(context).pop();
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Details",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: 26,
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            NavigationUtils.pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          right: 16,
          top: 8,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            MyTextField(
              labelText: FULL_NAME,
              width: 343,
              height: 64,
              Controller: nameController,
            ),
            MyTextField(
              labelText: PHONE,
              width: 343,
              height: 64,
              Controller: phoneController,
            ),
            MyTextField(
              labelText: EMAIL,
              width: 343,
              height: 64,
              Controller: emailController,
            ),
            // MyTextField(
            //   labelText: "Date of birth",
            //   width: 343,
            //   height: 64,
            //   Controller: birthController,
            // ),
            MyTextField(
              labelText: GSTIN,
              width: 343,
              height: 64,
              Controller: GSTController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: UikButton(
                onClick: () {
                  handleOnButtonClick();
                },
                text: setButtonText(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
