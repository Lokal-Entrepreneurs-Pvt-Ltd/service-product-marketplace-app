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

class extraPayOptIn extends StatefulWidget {
  extraPayOptIn({super.key});

  @override
  State<extraPayOptIn> createState() =>
      _extraPayOptInState();
}

class _extraPayOptInState extends State<extraPayOptIn> {
  @override
  void initState() {
    super.initState();
  }

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _regionController = TextEditingController();
  final _stateController = TextEditingController();
  final _aadharController = TextEditingController();
  final _panController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _cityRequired = true;
  bool _regionRequired = true;
  bool _stateRequired = true;
  bool _nameRequired = true;
  bool _aadharRequired = true;
  bool _panRequired = true;
  bool _requiredFields = false;
  String phoneNo = "";
  String samhitaId = "";

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
          margin: const EdgeInsets.only(left: DIMEN_16, right: DIMEN_16, top: DIMEN_10),
          child: ListView(
            children: [
              // Image.asset("assets/images/Samhita.png"),
              const SizedBox(
                height: DIMEN_10,
              ),
              Text(
                EXTRA_PAY_OPT_IN,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: DIMEN_16),
              ),
              const SizedBox(
                height: DIMEN_10,
              ),
              const Text(BTS_NAME),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _nameRequired ? null : REQUIRED_FIELD,
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
              const SizedBox(height: DIMEN_16),
              const Text(BTS_PHONE_NUMBER),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _phoneNumberValid
                      ? null
                      : VALID_PHONE_NO,
                ),
                onChanged: (value) {
                  phoneNo = value;
                  if (value.length < 10) {
                    setState(() {
                      _phoneNumberValid = false;
                    });
                  }
                  else {
                    setState(() {
                      _phoneNumberValid = true;
                    });
                  }
                },
              ),
              const Text(ENTER_CITY),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _cityRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _cityRequired = false;
                    });
                  } else {
                    setState(() {
                      _cityRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(ENTER_REGION),
              TextField(
                controller: _regionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _regionRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _regionRequired = false;
                    });
                  } else {
                    setState(() {
                      _regionRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(ENTER_STATE),
              TextField(
                controller: _stateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _stateRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _stateRequired = false;
                    });
                  } else {
                    setState(() {
                      _stateRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(ENTER_AADHAR),
              TextField(
                controller: _aadharController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _aadharRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _aadharRequired = false;
                    });
                  } else {
                    setState(() {
                      _aadharRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(ENTER_PAN),
              TextField(
                controller: _panController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _panRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _panRequired = false;
                    });
                  } else {
                    setState(() {
                      _panRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              _requiredFields
                  ? Container(
                      margin: const EdgeInsets.only(bottom: DIMEN_10),
                      child: const Text(
                        REQUIRED_FIELD,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
              Container(
                height: DIMEN_60,
                margin: const EdgeInsets.only(left: DIMEN_5, right: DIMEN_5, bottom: DIMEN_20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      _nameRequired = false;
                    }
                    if (_phoneNumberController.text.isEmpty) {
                      _phoneNumberValid = false;
                    }
                    if (_cityController.text.isEmpty) {
                      _cityRequired = false;
                    }
                    if (_regionController.text.isEmpty) {
                      _regionRequired = false;
                    }
                    if (_stateController.text.isEmpty) {
                      _stateRequired = false;
                    }
                    if (_aadharController.text.isEmpty) {
                      _aadharRequired = false;
                    }
                    if (_panController.text.isEmpty) {
                      _panRequired = false;
                    }
                    if (!_nameController.text.isEmpty &&
                        !_cityController.text.isEmpty &&
                        !_regionController.text.isEmpty &&
                        !_stateController.text.isEmpty &&
                        !_aadharController.text.isEmpty &&
                        !_panController.text.isEmpty &&
                        _phoneNumberValid) {
                      _requiredFields = false;
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository
                          .submitExtraPayOptInForm(ApiRequestBody
                              .submitExtraPayOptInRequest(
                        _nameController.text,
                        _phoneNumberController.text,
                        _cityController.text,
                        _regionController.text,
                        _stateController.text,
                        _aadharController.text,
                        _panController.text,
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });

                      NavigationUtils.pop();
                      if (response.isSuccess!) {
                        if (response.data) {
                          HttpScreenClient.displayDialogBox(
                              EXTRAPAY_VERIFICATION_SUCCESSFUL);
                        } else {
                          HttpScreenClient.displayDialogBox(
                              EXTRAPAY_VERIFICATION_FAILED);
                        }
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    } else {
                      _requiredFields = true;
                    }
                    setState(() {});
                  },
                  child: const Text(SUBMIT),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}