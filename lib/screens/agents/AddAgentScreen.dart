import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
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
import 'manageAgentScreen.dart';

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({super.key});

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  bool isAddAgentSelected = true;
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _phoneNumberValid = true;
  bool _emailValid = true;
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
            MY_AGENT,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xff212121),
            ),
          ),
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        ADD_AGENT,
                        style: GoogleFonts.poppins(
                          fontSize: DIMEN_18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddAgentSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        MANAGE_AGENT,
                        style: GoogleFonts.poppins(
                          fontSize: DIMEN_18,
                          fontWeight: FontWeight.w500,
                          color:
                              isAddAgentSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: DIMEN_16, right: DIMEN_16, top: DIMEN_10),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: DIMEN_20,
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
                              errorText:
                                  _phoneNumberValid ? null : VALID_PHONE_NO,
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
                          Container(
                            height: DIMEN_60,
                            margin: const EdgeInsets.only(
                                left: DIMEN_5,
                                right: DIMEN_5,
                                bottom: DIMEN_20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFFEE440)),
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
                                NavigationUtils.showLoaderOnTop();
                                final response = await ApiRepository
                                        .verifyAgentForPartner(ApiRequestBody
                                            .submitAddAgentScreenFormRequest(
                                                _nameController.text,
                                                _phoneNumberController.text,
                                                UserDataHandler.getUserId()
                                                    .toString(),
                                                _emailController.text))
                                    .catchError((err) {
                                  NavigationUtils.pop();
                                  UiUtils.showToast(err);
                                });
                                NavigationUtils.pop();
                                if (response.isSuccess!) {
                                  if (response.data) {
                                    Navigator.pushNamed(
                                        context, ScreenRoutes.addAgentOtpScreen,
                                        arguments: {
                                          'phoneNo': phoneNo,
                                          'partnerId':
                                              UserDataHandler.getUserId()
                                                  .toString()
                                        });
                                  } else {
                                    HttpScreenClient.displayDialogBox(
                                        ADD_AGENT_FAILED);
                                  }
                                } else {
                                  UiUtils.showToast(response.error![MESSAGE]);
                                }
                                setState(() {});
                              },
                              child: const Text(
                                CONTINUE,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ManageAgentScreen().page,
                  ],
                ))
              ],
            )));
  }
}
