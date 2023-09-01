
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/strings.dart';
import 'package:lokal/screens/addServiceCustomerFlow/apiCallerScreen.dart';
import '../../constants/dimens.dart';
import '../../utils/UiUtils/UiUtils.dart';

class AddServiceCustomerFlow extends StatefulWidget {
  const AddServiceCustomerFlow({super.key});

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
            child: _buildInputForm(),
          ),
        ],
      )),
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
            if (value.isEmpty) {
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
        const Text(ENTER_STATE_CODE),
        TextField(
          controller: _stateController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: _stateRequired ? null : REQUIRED_FIELD,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
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
        const Text(ENTER_DISTRICT_CODE),
        TextField(
          controller: _districtController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: _districtRequired ? null : REQUIRED_FIELD,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
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
        const SizedBox(height: DIMEN_16),
        const Text(ENTER_BLOCK_CODE),
        TextField(
          controller: _blockController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: _blockRequired ? null : REQUIRED_FIELD,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
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
            if (value.isEmpty) {
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
            if (value.isEmpty) {
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
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEE440), // Set the desired color
              ),
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
              if (_nameController.text.isNotEmpty &&
                  _pinCodeController.text.isNotEmpty &&
                  _phoneNumberValid) {
                _requiredFields = false;
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ApiCallerScreen(
                    name: _nameController.text,
                    phoneNumber: _phoneNumberController.text,
                    age: _ageController.text,
                    email: _emailController.text,
                    state: _stateController.text,
                    district: _districtController.text,
                    block: _blockController.text,
                    pinCode: _pinCodeController.text,
                    employment: _employmentController.text,
                  ),
                ),
              );
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
}
