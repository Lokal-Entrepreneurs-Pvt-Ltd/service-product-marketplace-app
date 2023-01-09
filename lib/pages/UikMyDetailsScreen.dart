import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikTextField/UikTextField.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../utils/storage/user_data_handler.dart';
import '../../widgets/UikNavbar/UikNavbar.dart';

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

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
    phoneController.text = await UserDataHandler.getUserPhone();
    nameController.text = await UserDataHandler.getUserName();
    birthController.text = await UserDataHandler.getUserBirth();
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
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ))
        ],
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
            // Container(
            //   margin: const EdgeInsets.only(
            //     left: 16,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Full Name"),
            //     ],
            //   ),
            //   width: 363,
            //   height: 64,
            //   decoration: BoxDecoration(
            //     color: Colors.grey,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
            MyTextField(
              labelText: "Phone",
              width: 343,
              height: 64,
              Controller: phoneController,
              rightElement: Row(
                children: const [
                  Text(
                    "verifying",
                    style: TextStyle(fontSize: 12),
                  ),
                  Icon(
                    Icons.refresh,
                    size: 13,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                bottom: 16,
              ),
              child: OtpTextField(
                numberOfFields: 6,
                borderColor: const Color(0xFFF5F5F5),
                showFieldAsBox: true,
                fieldWidth: 46,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            MyTextField(
              labelText: "Email",
              width: 343,
              height: 64,
              Controller: emailController,
            ),
            MyTextField(
              labelText: "Date of Birth",
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
          ],
        ),
      ),
    );
  }
}
