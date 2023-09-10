import 'package:flutter/material.dart';

import '../../utils/network/retrofit/api_routes.dart';
import '../../utils/storage/user_data_handler.dart';
import 'apiCallerScreen.dart';

void main() {
  runApp(const AddServiceCustomerFlow());
}

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
const REQUIRED_FIELD = "Enter Required Field";

class AddServiceCustomerFlow extends StatefulWidget {
  const AddServiceCustomerFlow({Key? key}) : super(key: key);

  @override
  State<AddServiceCustomerFlow> createState() => _AddServiceCustomerFlowState();
}

class _AddServiceCustomerFlowState extends State<AddServiceCustomerFlow> {
  final _formKey = GlobalKey<FormState>();
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


  late dynamic args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    super.didChangeDependencies();
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                BTS_NAME,
                _nameController,
                _nameRequired,
                validateName,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                BTS_PHONE_NUMBER,
                _phoneNumberController,
                _phoneNumberValid,
                validatePhoneNumber,
                TextInputType.phone
              ),
              const SizedBox(height: 16),
              _buildTextField(
                BTS_AGE,
                _ageController,
                _ageRequired,
                validateAge, TextInputType.number
              ),
              const SizedBox(height: 16),
              _buildTextField(
                BTS_EMAIL,
                _emailController,
                _emailValid,
                validateEmail,TextInputType.emailAddress
              ),
              // const SizedBox(height: 16),
              // _buildTextField(
              //   ENTER_STATE_CODE,
              //   _stateController,
              //   _stateRequired,
              //   validateState, TextInputType.streetAddress
              // ),
              // const SizedBox(height: 16),
              // _buildTextField(
              //   ENTER_DISTRICT_CODE,
              //   _districtController,
              //   _districtRequired,
              //   validateDistrict,
              // ),
              // const SizedBox(height: 16),
              // _buildTextField(
              //   ENTER_BLOCK_CODE,
              //   _blockController,
              //   _blockRequired,
              //   validateBlock,
              // ),
              const SizedBox(height: 16),
              _buildTextField(
                BTS_PINCODE,
                _pinCodeController,
                _pinCodeRequired,
                validatePincode,TextInputType.number
              ),
              const SizedBox(height: 16),
              _buildTextField(
                BTS_EMPLOYMENT,
                _employmentController,
                _employmentRequired,
                validateEmploymentStatus,
              ),
              const SizedBox(height: 16),
              // Rest of the fields...
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFooter() {
    final footerWidgets = <Widget>[
      _buildContinueButton(),
    ];

    return footerWidgets;
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      bool isError,
      FormFieldValidator<String>? validator,
      [TextInputType keyboardType = TextInputType.text]
      ) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        errorText: isError ? null : REQUIRED_FIELD,
      ),
      validator: validator,
    );
  }

  Widget _buildRequiredFieldMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
      child: Text(
        REQUIRED_FIELD,
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Form is valid, proceed with your logic
            String apiRoute = ApiRoutes.submitUserServiceCreateCustomerForm;
            Map<String, dynamic> apiArgs = {
              "userId": UserDataHandler.getUserId(),
              "serviceId": args['serviceId'],
              "name": _nameController.text,
              "phoneNumber": _phoneNumberController.text,
              "age": _ageController.text,
              "email": _emailController.text,
              // "stateCode": _stateController.text,
              // "districtCode": _districtController.text,
              // "blockCode": _blockController.text,
              "pincodeCode": _pinCodeController.text,
              "employmentType": _employmentController.text,
              "isVerified": false,
              "deliveryStatus": "IN_PROGRESS",
            };
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ApiCallerScreen(
                  apiRoute: apiRoute,
                  args: apiArgs,
                ),
              ),
            );
          } else {
            // Form is invalid, SnackBar will be shown as validation errors
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Form is Not valid'),
                backgroundColor: Colors.red, // You can change this color
              ),
            );
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

  // Custom validators
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    if (!isValidPhoneNumber(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }

    // Use a regular expression to check if the value contains only digits
    final isNumeric = int.tryParse(value);
    if (isNumeric == null || isNumeric < 0 || isNumeric > 99) {
      return 'Age must be a number between 0 and 99';
    }

    return null;
  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    if (!isValidEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

  String? validateDistrict(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

  String? validateBlock(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

  String? validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }

    final pincodeRegex = RegExp(r'^[1-9][0-9]{5}$'); // Matches Indian PIN codes

    if (!pincodeRegex.hasMatch(value)) {
      return 'Invalid PIN code';
    }

    return null;
  }

  String? validateEmploymentStatus(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

// Custom phone number validation logic for Indian numbers
  bool isValidPhoneNumber(String value) {
    // Define a regex pattern for Indian mobile numbers
    final indianPhoneNumberRegex = RegExp(r'^[6-9][0-9]{9}$');

    // Check if the value matches the Indian mobile number pattern
    return indianPhoneNumberRegex.hasMatch(value);
  }

  // Custom email validation logic
  bool isValidEmail(String value) {
    // Add your email validation logic here
    // For example, you can use a regular expression to check if it's a valid email
    // Return true if it's a valid email, false otherwise
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(value);
  }
}
