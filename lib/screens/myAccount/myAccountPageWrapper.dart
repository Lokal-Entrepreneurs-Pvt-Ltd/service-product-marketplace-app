import 'package:flutter/material.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyAccountWrapper extends StatefulWidget {
  const MyAccountWrapper({super.key});

  @override
  State<MyAccountWrapper> createState() => _MyAccountWrapperState();
}

class _MyAccountWrapperState extends State<MyAccountWrapper> {
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
      body: Column(
        children: [
          UikMyAccountScreen().page,
          Expanded(child: Container()),
          FutureBuilder(
              future: _initPackageInfo(),
              builder: (ctx, res) {
                if (res.hasData) {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey,
                    child: Text(
                      "Version: ${res.data!}",
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
