import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({Key? key}) : super(key: key);

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _phoneNumberValid = false;
  bool _emailValid = false;
  bool _nameRequired = false;
  bool _isApiCallInProgress = false;
  String phoneNo = "";

  late dynamic args;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildAddAgentContent(),
          if (_isApiCallInProgress) _buildProgressBar(),
        ],
      ),
      persistentFooterButtons: [
        _buildContinueButton()
      ],
    );
  }

  Widget _buildProgressBar() {
    return Container(
      color: Colors.black.withOpacity(0.5), // Add a semi-transparent background
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity, // Match full screen width
      margin: EdgeInsets.zero, // Remove any margins
      padding: EdgeInsets.zero, // Remove any padding
      child: InkWell(
        onTap: () {
          if (!_isApiCallInProgress) {
            if (_nameRequired && _phoneNumberValid && _emailValid) {
              _handleContinueButtonPress();
            }
            else {
                UiUtils.showToast("Please fix the validation errors.");
                return;
              }

          }
        },
        child: UikButton(
          text: CONTINUE,
          textColor: Colors.black,
          textSize: 16.0,
          textWeight: FontWeight.w500,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      title: Text(
        ADD_AGENT,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xff212121),
        ),
      ),
    );
  }

  Widget _buildAddAgentContent() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: DIMEN_16,
              right: DIMEN_16,
              top: DIMEN_10,
            ),
            child: ListView(
              children: [
                const SizedBox(height: DIMEN_20),
                Text(
                  GROWTH_PARTNER,
                  style: GoogleFonts.poppins(
                    fontSize: DIMEN_26,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff212121),
                  ),
                ),
                const SizedBox(height: DIMEN_20),
                Text(
                  ADD_AGENT_MESSAGE,
                  style: GoogleFonts.poppins(
                    fontSize: DIMEN_20,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff212121),
                  ),
                ),
                const SizedBox(height: DIMEN_20),
                const Text(BTS_NAME),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText: _nameRequired ? null : REQUIRED_FIELD,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
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
              ],
            ),
          ),
        ),
      ],
    );
  }


  void _handleContinueButtonPress() async {
    setState(() {
      _isApiCallInProgress = true; // Set this flag to true when the API call starts.
    });

    final response = await ApiRepository.addPartnerAgent(
      ApiRequestBody.submitAddPartnerAgentRequest(
        UserDataHandler.getUserId().toString(),
        _nameController.text,
        _phoneNumberController.text,
        _emailController.text,
      ),
    ).catchError((err) {
      setState(() {
        _isApiCallInProgress = false; // Set this flag to false if an error occurs.
      });
      NavigationUtils.pop();
      UiUtils.showToast(err);
    });

    setState(() {
      _isApiCallInProgress = false; // Set this flag to false when the API call completes.
    });

    if (response.isSuccess!) {
      UiUtils.showToast("Agent Added");
      NavigationUtils.openScreenUntil(ScreenRoutes.userServiceTabsScreen, args);
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
      NavigationUtils.pop();
    }
  }
}
