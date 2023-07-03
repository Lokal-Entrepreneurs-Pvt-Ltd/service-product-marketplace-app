import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';

class AddFleet extends StatefulWidget {
  const AddFleet({super.key});

  @override
  State<AddFleet> createState() => _AddFleetState();
}

class _AddFleetState extends State<AddFleet> {
  bool isAddFleetSelected = true;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _nameRequired = true;
  bool _requiredFields = false;
  int? selected;
  String phoneNo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // Center aligns the title
        title: Text(
          "My Fleet",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff212121),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isAddFleetSelected = true;
                        });
                      },
                      child: Text(
                        'Add Fleet',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddFleetSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isAddFleetSelected = false;
                        });
                      },
                      child: Text(
                        'Manage Fleets',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddFleetSelected ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Become a Growth Partner',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: const Color(0xff212121),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              ADD_FLEET_MESSAGE,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color(0xff212121),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Name'),
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
                    : VALID_PHONE_NO,
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
            const SizedBox(height: 16.0),
            const Text('Email'),
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
            const SizedBox(height: 16.0),
            _requiredFields
                ? Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      REQUIRED_FIELD,
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
                  if (!UiUtils.isEmailValid(_emailController.text)) {
                    _emailValid = false;
                  }
                  if (UiUtils.isEmailValid(_emailController.text) &&
                      !_nameController.text.isEmpty &&
                      _phoneNumberValid) {
                    _requiredFields = false;
                    NavigationUtils.showLoaderOnTop();
                    final response =
                        await ApiRepository.submitAddFleetScreenForm(
                            ApiRequestBody.submitAddFleetScreenFormRequest(
                      _nameController.text,
                      _phoneNumberController.text,
                      _emailController.text,
                    )).catchError((err) {
                      NavigationUtils.pop();
                      UiUtils.showToast(err);
                    });
                    NavigationUtils.pop();
                    if (response.isSuccess!) {
                      if (response.data[RESPONSE]) {
                        Navigator.pushNamed(context, ScreenRoutes.addFleetOtp, arguments: {'phoneNo': phoneNo});
                      } else {
                        HttpScreenClient.displayDialogBox("Error!!");
                      }
                    } else {
                      UiUtils.showToast(response.error![MESSAGE]);
                    }
                  } else {
                    _requiredFields = true;
                  }
                  setState(() {});
                },
                child: const Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
