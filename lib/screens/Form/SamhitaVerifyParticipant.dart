
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/strings.dart';
import '../../constants/dimens.dart';
import '../../constants/json_constants.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';

class SamhitaVerifyParticipant extends StatefulWidget {
  const SamhitaVerifyParticipant({super.key});

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
  final _samhitaIdController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _samhitaIdRequired = true;
  bool _nameRequired = true;
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
              Image.asset("assets/images/Samhita.png"),
              const SizedBox(
                height: DIMEN_10,
              ),
              Text(
                VERIFY_PARTICIPANT,
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
              const Text(BTS_SAMHITA_ID),
              TextField(
                controller: _samhitaIdController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _samhitaIdRequired ? null : REQUIRED_FIELD,
                ),
                onChanged: (value) {
                  samhitaId = value;
                  if (value.isEmpty) {
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
                    if (_samhitaIdController.text.isEmpty) {
                      _samhitaIdRequired = false;
                    }
                    if (_nameController.text.isNotEmpty &&
                        _samhitaIdController.text.isNotEmpty &&
                        _phoneNumberValid) {
                      _requiredFields = false;
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository
                          .submitSamhitaVerifyParticipantForm(ApiRequestBody
                              .submitSamhitaVerifyParticipantFormRequest(
                        _nameController.text,
                        _phoneNumberController.text,
                        _samhitaIdController.text,
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });

                      NavigationUtils.pop();
                      if (response.isSuccess!) {
                        // ignore: use_build_context_synchronously
                        // HttpScreenClient.displayDialogBox(SAMHITA_VERIFICATION_SUCCESSFUL);
                        if (response.data) {
                          // HttpScreenClient.displayDialogBox(SAMHITA_VERIFICATION_SUCCESSFUL);
                          Navigator.pushNamed(context, ScreenRoutes.samhitaOtp,
                              arguments: {
                                'phoneNo': phoneNo,
                                'samhitaId': samhitaId
                              });
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
                  child: const Text(VERIFY_PARTICIPANT),
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
