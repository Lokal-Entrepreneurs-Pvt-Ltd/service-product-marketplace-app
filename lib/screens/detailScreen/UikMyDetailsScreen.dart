import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../utils/storage/user_data_handler.dart';
import '../../../widgets/UikNavbar/UikNavbar.dart';

// move to screen folder

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final GSTController = TextEditingController();

  final authToken = UserDataHandler.getUserToken();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
    phoneController.text = await UserDataHandler.getUserPhone();
    nameController.text = await UserDataHandler.getUserName();
    birthController.text = await UserDataHandler.getUserDob();
    GSTController.text = await UserDataHandler.getUserGST();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Details",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: 26,
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          right: 16,
          top: 8,
        ),
        color: Colors.white,
        child: ListView(
          children: [
            MyTextField(
              labelText: "Full Name",
              width: 343,
              height: 64,
              Controller: nameController,
            ),
            MyTextField(
              labelText: "Phone",
              width: 343,
              height: 64,
              Controller: phoneController,
            ),
            /* MyTextField(
              labelText: "Email",
              width: 343,
              height: 64,
              Controller: emailController,
            ), */
            MyTextField(
              labelText: "Date of birth",
              width: 343,
              height: 64,
              Controller: birthController,
            ),
            MyTextField(
              labelText: "GSTIN",
              width: 343,
              height: 64,
              Controller: GSTController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: UikButton(
                onClick: () async {
                  final response = await http.post(
                    Uri.parse(
                        'https://dev.localee.co.in/api/customer/updatecustomerinfo'),
                    headers: {
                      "ngrok-skip-browser-warning": "value",
                      "Authorization": "Bearer $authToken",
                    },
                    body: {
                      "name": nameController.text,
                      "email": emailController.text,
                      "taxvat": GSTController.text,
                      "dob": birthController.text,
                      "phone": phoneController.text,
                    },
                  );

                  UserDataHandler.saveUserName(nameController.text);
                  UserDataHandler.saveUserEmail(emailController.text);
                  UserDataHandler.saveUserGST(GSTController.text);
                  UserDataHandler.saveUserDob(birthController.text);
                  UserDataHandler.saveUserPhone(phoneController.text);

                  print(response.body);

                  Navigator.of(context).pop();
                },
                text: "Save Details",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
