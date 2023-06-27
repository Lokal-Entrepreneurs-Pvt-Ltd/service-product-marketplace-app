import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screens/Onboarding/LandingPage.dart';
import 'package:lokal/utils/storage/samhita_data_handler.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/json_constants.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';
import '../../utils/storage/user_data_handler.dart';
import 'SamhitaOtp.dart';

class SamhitaVerifyParticipant extends StatefulWidget {
  SamhitaVerifyParticipant({super.key});

  @override
  State<SamhitaVerifyParticipant> createState() =>
      _SamhitaVerifyParticipantState();
}

class _SamhitaVerifyParticipantState extends State<SamhitaVerifyParticipant> {
  @override
  void initState() {
    super.initState();
  }

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _samhitaIdController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _samhitaIdRequired = true;
  bool _nameRequired = true;
  bool _requiredFields = false;
  String args = "";

  @override
  void dispose() {
    //dispose method used to release the memory allocated to variables when state object is removed.
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: ListView(
            children: [
              Image.asset("assets/images/Samhita.png"),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Verify Participant',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Participant Name'),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _nameRequired ? null : 'This is Required',
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _nameRequired = false;
                    });
                  } else {
                    setState(() {
                      _nameRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Samhita Id'),
              TextField(
                controller: _samhitaIdController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _samhitaIdRequired ? null : 'This is Required',
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _samhitaIdRequired = false;
                    });
                  } else {
                    setState(() {
                      _samhitaIdRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Phone Number'),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _phoneNumberValid
                      ? null
                      : 'Please enter a valid phone number starting with 7, 8, or 9',
                ),
                onChanged: (value) {
                  args = value;
                  if (value.length < 10) {
                    setState(() {
                      _phoneNumberValid = false;
                    });
                  }
                  // else if (!RegExp(r'^[+789]\d{9}$').hasMatch(value)) {
                  //   setState(() {
                  //     _phoneNumberValid = false;
                  //   });
                  // }
                  else {
                    setState(() {
                      _phoneNumberValid = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Email'),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _emailValid ? null : 'Please enter a valid email',
                ),
                onChanged: (value) {
                  if (!isEmailValid(value)) {
                    setState(() {
                      _emailValid = false;
                    });
                  } else {
                    setState(() {
                      _emailValid = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              _requiredFields
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "Please Fill All required Fields",
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      _nameRequired = false;
                    }
                    if (_phoneNumberController.text.isEmpty) {
                      _phoneNumberValid = false;
                    }
                    if (_samhitaIdController.text.isEmpty) {
                      _samhitaIdRequired = false;
                    }
                    if (!isEmailValid(_emailController.text)) {
                      _emailValid = false;
                    }
                    if (isEmailValid(_emailController.text) &&
                        !_nameController.text.isEmpty &&
                        !_samhitaIdController.text.isEmpty &&
                        _phoneNumberValid) {
                      _requiredFields = false;
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository
                          .submitSamhitaVerifyParticipantForm(ApiRequestBody
                              .submitSamhitaVerifyParticipantFormRequest(
                        _nameController.text,
                        _phoneNumberController.text,
                        _emailController.text,
                        _samhitaIdController.text,
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });

                      NavigationUtils.pop();
                      if (response.isSuccess!) {
                        // ignore: use_build_context_synchronously
                        // HttpScreenClient.displayDialogBox(SAMHITA_VERIFICATION_SUCCESSFUL);
                        if (response.data[RESPONSE]) {
                          // HttpScreenClient.displayDialogBox(SAMHITA_VERIFICATION_SUCCESSFUL);
                          Navigator.pushNamed(context, ScreenRoutes.samhitaOtp,
                              arguments: args);
                        } else {
                          HttpScreenClient.displayDialogBox(
                              SAMHITA_VERIFICATION_FAILED);
                        }
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    } else {
                      _requiredFields = true;
                    }
                    setState(() {});
                  },
                  child: const Text('Verify Participant'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
