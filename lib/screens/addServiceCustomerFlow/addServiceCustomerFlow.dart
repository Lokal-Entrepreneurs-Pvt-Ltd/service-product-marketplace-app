import 'dart:async';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/screens/Onboarding/LandingPage.dart';
import 'package:lokal/utils/storage/samhita_data_handler.dart';
import 'package:lottie/lottie.dart';
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
import '../Form/SamhitaOtp.dart';

class addUserServiceCustomer extends StatefulWidget {
  addUserServiceCustomer({super.key});

  @override
  State<addUserServiceCustomer> createState() => _addUserServiceCustomerState();
}

class _addUserServiceCustomerState extends State<addUserServiceCustomer> {
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
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _blockController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _pinCodeRequired = true;
  bool _nameRequired = true;
  bool _ageRequired = true;
  bool _employmentRequired = true;
  bool _stateRequired = true;
  bool _districtRequired = true;
  bool _blockRequired = true;
  bool _requiredFields = false;
  String phoneNo = "";
  bool _isLoading = false;
  bool _isResultVisible = false;
  ResultModel? _currentResult;

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
          body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: DIMEN_16, right: DIMEN_16, top: DIMEN_10),
            child: _isLoading
                ? _buildLoadingScreen()
                : _isResultVisible
                    ? _buildResultScreen()
                    : _buildInputForm(),
          ),
        ],
      )),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.network(
            LOADING_LOTTIE,
          ),
          const SizedBox(
            height: DIMEN_15,
          ),
          const Text(
            LOADING_TEXT,
            style: TextStyle(
                fontSize: DIMEN_25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: DIMEN_15,
          ),
          const Text(
            LOADING_SUB_TEXT,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return ListView(
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
        const Text(ENTER_DISTRICT),
        TextField(
          controller: _districtController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: _districtRequired ? null : REQUIRED_FIELD,
          ),
          onChanged: (value) {
            if (value.length == 0) {
              setState(() {
                _districtRequired = false;
              });
            } else {
              setState(() {
                _districtRequired = true;
              });
            }
          },
        ),
        const Text(ENTER_BLOCK),
        TextField(
          controller: _blockController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: _blockRequired ? null : REQUIRED_FIELD,
          ),
          onChanged: (value) {
            if (value.length == 0) {
              setState(() {
                _blockRequired = false;
              });
            } else {
              setState(() {
                _blockRequired = true;
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
              if (_stateController.text.isEmpty) {
                _stateRequired = false;
              }
              if (_districtController.text.isEmpty) {
                _districtRequired = false;
              }
              if (_blockController.text.isEmpty) {
                _blockRequired = false;
              }
              if (!_nameController.text.isEmpty &&
                  !_pinCodeController.text.isEmpty &&
                  _phoneNumberValid) {
                setState(() {
                  _isLoading = true;
                  _isResultVisible = false;
                });
                _requiredFields = false;
                NavigationUtils.showLoaderOnTop();
                final response =
                    await ApiRepository.submitAddUserServiceCustomerForm(
                            ApiRequestBody.submitAddUserServiceCustomerFormRequest(
                                _nameController.text,
                                _phoneNumberController.text,
                                _pinCodeController.text,
                                _ageController.text,
                                _emailController.text,
                                _employmentController.text,
                                _stateController.text,
                                _districtController.text,
                                _blockController.text))
                        .catchError((err) {
                  NavigationUtils.pop();
                  UiUtils.showToast(err);
                });
                NavigationUtils.pop();
                if (response.isSuccess!) {
                  if (response.data) {
                    setState(() {
                      _isLoading = false;
                      _isResultVisible = true;
                      _currentResult = ResultModel(
                        isSuccess: true,
                        message: ADD_SERVICE_CUSTOMER_SUCCESS,
                        animationAsset:
                            LOTTIE_SUCCESS,
                      );
                    });
                  } else {
                    setState(() {
                      _isLoading = false;
                      _isResultVisible = true;
                      _currentResult = ResultModel(
                        isSuccess: false,
                        message: ADD_SERVICE_CUSTOMER_FAIL,
                        animationAsset:
                            LOTTIE_ERROR,
                      );
                    });
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
    );
  }

  Widget _buildResultScreen() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(_currentResult!.isSuccess
                ? _currentResult!.animationAsset
                : LOTTIE_ERROR),
            const SizedBox(height: 16),
            Text(_currentResult!.message),
          ],
        ),
      ),
    );
  }
}

class ResultModel {
  final bool isSuccess;
  final String message;
  final String animationAsset;

  ResultModel({
    required this.isSuccess,
    required this.message,
    required this.animationAsset,
  });
}
