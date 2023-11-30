// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:lokal/pages/UikMyAccountScreen.dart';

class MyAccountWrapper extends StatefulWidget {
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

  Future<String?> _initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
    // setState(() {
    //   String _appName = _packageInfo.appName;
    //   // String PackageName = _packageInfo.packageName;
    //   // String AppVersion = _packageInfo.version;
    //   // String BuildNumber = _packageInfo.buildNumber;
    //   // String BuildSignature = _packageInfo.buildSignature;
    // });
  }

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
            FutureBuilder(
                future: _initPackageInfo(),
                builder: (ctx, res) {
                  if (res.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey,
                        child: Text(
                          "Version: ${res.data!}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
