import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';
import '../../constants/dimens.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';

class AddAgent extends StatefulWidget {
  const AddAgent({super.key});

  @override
  State<AddAgent> createState() => _AddAgentState();
}

class _AddAgentState extends State<AddAgent> {
  bool isAddFleetSelected = true;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _partnerIdController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _nameRequired = true;
  bool _partnerIdRequired = true;
  bool _requiredFields = false;
  int? selected;
  String phoneNo = "";
  String partnerId = "";

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
          MY_AGENT,
          style: GoogleFonts.poppins(
            fontSize: DIMEN_16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff212121),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: DIMEN_16, right: DIMEN_16, top: DIMEN_10),
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
                        ADD_AGENT,
                        style: GoogleFonts.poppins(
                          fontSize: DIMEN_18,
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
                        MANAGE_AGENT,
                        style: GoogleFonts.poppins(
                          fontSize: DIMEN_18,
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
              GROWTH_PARTNER,
              style: GoogleFonts.poppins(
                fontSize: DIMEN_26,
                fontWeight: FontWeight.w600,
                color: const Color(0xff212121),
              ),
            ),
            const SizedBox(
              height: DIMEN_20,
            ),
            Text(
              ADD_AGENT_MESSAGE,
              style: GoogleFonts.poppins(
                fontSize: DIMEN_20,
                fontWeight: FontWeight.w400,
                color: const Color(0xff212121),
              ),
            ),
            const SizedBox(
              height: DIMEN_20,
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
            const Text(PARTNER_ID),
            TextField(
              controller: _partnerIdController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: _partnerIdRequired ? null : REQUIRED_FIELD,
              ),
              onChanged: (value) {
                partnerId = value;
                if (value.length == 0) {
                  setState(() {
                    _partnerIdRequired = false;
                  });
                } else {
                  setState(() {
                    _partnerIdRequired = true;
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
                  if (_partnerIdController.text.isEmpty) {
                    _partnerIdRequired = false;
                  }
                  if (!_partnerIdController.text.isEmpty &&
                      !_nameController.text.isEmpty &&
                      _phoneNumberValid) {
                    _requiredFields = false;
                    NavigationUtils.showLoaderOnTop();
                    final response =
                        await ApiRepository.submitAddFleetScreenForm(
                            ApiRequestBody.submitAddFleetScreenFormRequest(
                      _nameController.text,
                      _phoneNumberController.text,
                      _partnerIdController.text,
                    )).catchError((err) {
                      NavigationUtils.pop();
                      UiUtils.showToast(err);
                    });
                    NavigationUtils.pop();
                    if (response.isSuccess!) {
                      if (response.data) {
                        Navigator.pushNamed(context, ScreenRoutes.addFleetOtp,
                            arguments: {
                              'phoneNo': phoneNo,
                              'partnerId': partnerId
                            });
                      } else {
                        HttpScreenClient.displayDialogBox(ADD_AGENT_FAILED);
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
    );
  }
}
