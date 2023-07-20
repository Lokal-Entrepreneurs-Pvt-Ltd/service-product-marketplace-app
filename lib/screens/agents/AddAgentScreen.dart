import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
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

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({super.key});

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  bool isAddAgentSelected = true;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _nameRequired = true;
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
          "My Agents",
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
                          isAddAgentSelected = true;
                        });
                      },
                      child: Text(
                        'Add Agent',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddAgentSelected ? Colors.black : Colors.grey,
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
                          isAddAgentSelected = false;
                        });
                      },
                      child: Text(
                        'Manage Agents',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddAgentSelected ? Colors.grey : Colors.black,
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
              ADD_AGENT_MESSAGE,
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
                    NavigationUtils.showLoaderOnTop();
                    final response =
                        await ApiRepository.verifyAgentForPartner(
                            ApiRequestBody.submitAddAgentScreenFormRequest(
                      _nameController.text,
                      _phoneNumberController.text,
                      UserDataHandler.getUserId().toString(),
                    )).catchError((err) {
                      NavigationUtils.pop();
                      UiUtils.showToast(err);
                    });
                    NavigationUtils.pop();
                    if (response.isSuccess!) {
                      if (response.data) {
                        Navigator.pushNamed(context, ScreenRoutes.addAgentOtpScreen, arguments: {'phoneNo': phoneNo, 'partnerId':  UserDataHandler.getUserId().toString()});
                      } else {
                        HttpScreenClient.displayDialogBox("Error!!");
                      }
                    } else {
                      UiUtils.showToast(response.error![MESSAGE]);
                    }
                     setState(() {});
                  }
                ,
                child: const Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
