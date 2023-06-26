import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/samhita_data_handler.dart';
import '../../constants/json_constants.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';
import 'SamhitaOtp.dart';

class SamhitaBecomeParticipant extends StatefulWidget {
  SamhitaBecomeParticipant({super.key});

  @override
  State<SamhitaBecomeParticipant> createState() =>
      _SamhitaBecomeParticipantState();
}

class _SamhitaBecomeParticipantState extends State<SamhitaBecomeParticipant> {
  @override
  void initState() {
    super.initState();
  }

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _nameRequired = true;
  bool _lastNameRequired = true;
  bool _requiredFields = false;

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
                'Become a Participant',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('First Name'),
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
              const Text('Last Name'),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _lastNameRequired ? null : 'This is Required',
                ),
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      _lastNameRequired = false;
                    });
                  } else {
                    setState(() {
                      _lastNameRequired = true;
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
                  if (value.length < 13) {
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
                    if (_lastNameController.text.isEmpty) {
                      _lastNameRequired = false;
                    }
                    if (!isEmailValid(_emailController.text)) {
                      _emailValid = false;
                    }
                    if (isEmailValid(_emailController.text) &&
                        !_nameController.text.isEmpty &&
                        !_lastNameController.text.isEmpty &&
                        _phoneNumberValid) {
                      _requiredFields = false;
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository
                          .submitSamhitaBecomeParticipantForm(ApiRequestBody
                              .submitSamhitaBecomeParticipantFormRequest(
                        _nameController.text,
                        _lastNameController.text,
                        _phoneNumberController.text,
                        _emailController.text,
                        SamhitaDataHandler.getRequestId(),
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });

                      NavigationUtils.pop();
                      if (response.isSuccess!) {
                        var requestIdReceived = response.data[REQUEST_ID];
                        SamhitaDataHandler.saveRequestId(requestIdReceived);
                        print(requestIdReceived);
                        // ignore: use_build_context_synchronously
                        // HttpScreenClient.displayDialogBox("Sign up Successful");
                        Navigator.pushNamed(context!, ScreenRoutes.samhitaOtp);
                        SamhitaOtp otp = SamhitaOtp();
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UikBottomNavigationBar()),
                        // );
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    } else {
                      _requiredFields = true;
                    }
                    setState(() {});
                  },
                  child: const Text('Sign up'),
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
