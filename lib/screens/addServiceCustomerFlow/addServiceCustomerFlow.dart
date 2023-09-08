import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ADD_SERVICE_CUSTOMER = "Add Service Customer";
const BTS_NAME = "Name";
const BTS_PHONE_NUMBER = "Phone Number";
const BTS_AGE = "Age";
const BTS_EMAIL = "Email";
const ENTER_STATE_CODE = "Enter State";
const ENTER_DISTRICT_CODE = "Enter District";
const ENTER_BLOCK_CODE = "Enter Block";
const BTS_PINCODE = "Pincode";
const BTS_EMPLOYMENT = "Employment Status";
const CONTINUE = "Continue";
const REQUIRED_FIELD = "Required Field";

void main() {
  runApp(const AddServiceCustomerFlow());
}

class AddServiceCustomerFlow extends StatefulWidget {
  const AddServiceCustomerFlow({Key? key}) : super(key: key);

  @override
  State<AddServiceCustomerFlow> createState() => _AddServiceCustomerFlowState();
}

class _AddServiceCustomerFlowState extends State<AddServiceCustomerFlow> {
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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _pinCodeController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _employmentController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _blockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        persistentFooterButtons: _buildFooter(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        ADD_SERVICE_CUSTOMER,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(BTS_NAME, _nameController, _nameRequired),
            const SizedBox(height: 16),
            _buildTextField(
              BTS_PHONE_NUMBER,
              _phoneNumberController,
              _phoneNumberValid,
            ),
            const SizedBox(height: 16),
            _buildTextField(BTS_AGE, _ageController, _ageRequired),
            const SizedBox(height: 16),
            _buildTextField(BTS_EMAIL, _emailController, _emailValid),
            const SizedBox(height: 16),
            _buildTextField(
              ENTER_STATE_CODE,
              _stateController,
              _stateRequired,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              ENTER_DISTRICT_CODE,
              _districtController,
              _districtRequired,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              ENTER_BLOCK_CODE,
              _blockController,
              _blockRequired,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              BTS_PINCODE,
              _pinCodeController,
              _pinCodeRequired,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              BTS_EMPLOYMENT,
              _employmentController,
              _employmentRequired,
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFooter() {
    final footerWidgets = <Widget>[
      if (_requiredFields) _buildRequiredFieldMessage(),
      _buildContinueButton(),
    ];

    return footerWidgets;
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      bool isError,
      ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        errorText: isError ? null : REQUIRED_FIELD,
      ),
    );
  }

  Widget _buildRequiredFieldMessage() {
    return Text(
      REQUIRED_FIELD,
      style: TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (!_isFormValid()) {
            setState(() {
              _requiredFields = true;
            });
          } else {
            setState(() {
              _requiredFields = false;
            });
            // Your logic for continuing here
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            CONTINUE,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _phoneNumberValid &&
        _emailController.text.isNotEmpty &&
        _emailValid &&
        _ageController.text.isNotEmpty &&
        _stateController.text.isNotEmpty &&
        _districtController.text.isNotEmpty &&
        _blockController.text.isNotEmpty &&
        _pinCodeController.text.isNotEmpty &&
        _employmentController.text.isNotEmpty;
  }
}
