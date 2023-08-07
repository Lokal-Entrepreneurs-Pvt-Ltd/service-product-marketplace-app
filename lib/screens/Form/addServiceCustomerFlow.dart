import 'dart:async';

import 'package:feedback/feedback.dart';
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

class AddServiceCustomerFlow extends StatefulWidget {
  AddServiceCustomerFlow({super.key});

  @override
  State<AddServiceCustomerFlow> createState() => _AddServiceCustomerFlowState();
}

class _AddServiceCustomerFlowState extends State<AddServiceCustomerFlow> {
  @override
  void initState() {
    super.initState();
  }

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _employmentController = TextEditingController();
  final _incomeController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _pinCodeRequired = true;
  bool _nameRequired = true;
  bool _ageRequired = true;
  bool _employmentRequired = true;
  bool _incomeRequired = true;
  bool _requiredFields = false;
  String phoneNo = "";

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
          margin: const EdgeInsets.only(
              left: DIMEN_16, right: DIMEN_16, top: DIMEN_10),
          child: ListView(
            children: [
              const SizedBox(
                height: DIMEN_10,
              ),
              Text(
                ADD_SERVICE_CUSTOMER,
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
                  errorText: _nameRequired ? null : VALID_NAME,
                ),
                onChanged: (value) {
                  if (!UiUtils.isNameValid(value)) {
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
                  errorText: _phoneNumberValid ? null : VALID_PHONE_NO,
                ),
                onChanged: (value) {
                  phoneNo = value;
                  if (value.length < 10) {
                    setState(() {
                      _phoneNumberValid = false;
                    });
                  } else {
                    setState(() {
                      _phoneNumberValid = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(BTS_EMAIL),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _emailValid ? null : VALID_EMAIL,
                ),
                onChanged: (value) {
                  if (!UiUtils.isEmailValid(value)) {
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
              const SizedBox(height: DIMEN_16),
              const Text(BTS_AGE),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.phone,
                maxLength: 2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _ageRequired ? null : VALID_AGE,
                ),
                onChanged: (value) {
                  if (value.length < 1) {
                    setState(() {
                      _ageRequired = false;
                    });
                  } else {
                    setState(() {
                      _ageRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(BTS_PINCODE),
              TextField(
                controller: _pinCodeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _pinCodeRequired ? null : VALID_PINCODE,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _pinCodeRequired = false;
                    });
                  } else {
                    setState(() {
                      _pinCodeRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(BTS_EMPLOYMENT),
              TextField(
                controller: _employmentController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _employmentRequired ? null : EMPLOYMENT_STATUS,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _employmentRequired = false;
                    });
                  } else {
                    setState(() {
                      _employmentRequired = true;
                    });
                  }
                },
              ),
              const SizedBox(height: DIMEN_16),
              const Text(BTS_INCOME),
              TextField(
                controller: _incomeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _incomeRequired ? null : VALID_INCOME,
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _incomeRequired = false;
                    });
                  } else {
                    setState(() {
                      _incomeRequired = true;
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
                margin: const EdgeInsets.only(
                    left: DIMEN_5, right: DIMEN_5, bottom: DIMEN_20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      _nameRequired = false;
                    }
                    if (_phoneNumberController.text.isEmpty) {
                      _phoneNumberValid = false;
                    }
                    if (_emailController.text.isEmpty) {
                      _emailValid = false;
                    }
                    if (_pinCodeController.text.isEmpty) {
                      _pinCodeRequired = false;
                    }
                    if (_ageController.text.isEmpty) {
                      _ageRequired = false;
                    }
                    if (_employmentController.text.isEmpty) {
                      _employmentRequired = false;
                    }
                    if (_incomeController.text.isEmpty) {
                      _incomeRequired = false;
                    }
                    if (!_nameController.text.isEmpty &&
                        !_pinCodeController.text.isEmpty &&
                        _phoneNumberValid) {
                      _requiredFields = false;
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository
                          .submitAddServiceCustomerForm(ApiRequestBody
                              .submitAddServiceCustomerFormRequest(
                        _nameController.text,
                        _phoneNumberController.text,
                        _pinCodeController.text,
                        _ageController.text,
                        _emailController.text,
                        _employmentController.text,
                        _incomeController.text
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });
                      NavigationUtils.pop();
                      if (response.isSuccess!) {
                        if (response.data) {
                          HttpScreenClient.displayDialogBox(
                              ADD_SERVICE_CUSTOMER_SUCCESS);
                        } else {
                          HttpScreenClient.displayDialogBox(
                              ADD_SERVICE_CUSTOMER_FAIL);
                        }
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    } else {
                      _requiredFields = true;
                    }
                    setState(() {});
                  },
                  child: const Text(CONTINUE),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  UiUtils.showFeedbackPanel(context);
                },
                child: const Text(PROVIDE_FEEDBACK),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
