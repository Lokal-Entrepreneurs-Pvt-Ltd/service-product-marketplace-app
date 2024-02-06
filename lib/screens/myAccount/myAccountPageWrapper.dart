// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:lokal/pages/UikMyAccountScreen.dart';

class
MyAccountWrapper extends StatefulWidget {
  StatefulWidget page;
  MyAccountWrapper({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  State<MyAccountWrapper> createState() => _MyAccountWrapperState(page);
}

class _MyAccountWrapperState extends State<MyAccountWrapper> {
  final StatefulWidget page;
  _MyAccountWrapperState(this.page);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //UikMyAccountScreen().page,
            SizedBox(
              child: page,
              height: MediaQuery.of(context).size.height * 0.9,
            ),
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Version: ${UserDataHandler.getAppVersion()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
