import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:lokal/DUIPageMessageHandler.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';

class PartnerInfo extends StatefulWidget {
  final dynamic args;
  const PartnerInfo({Key? key, this.args}) : super(key: key);

  @override
  State<PartnerInfo> createState() => _PartnerInfoState();
}

class _PartnerInfoState extends State<PartnerInfo> {
  Future<Map<String, dynamic>?>? _futureData;

  String name = "";
  String phoneNumber = "";
  String profilePic = "";
  Map<String, dynamic> map = {};
  int? userId;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      // Use FutureBuilder to wait for the fetchData to complete
      future: _futureData,
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the future has completed, build the body with fetched data
          return DUIFactory().createPage(
              'partnerinfo',
              map, messageHandler: DUIPageMessageHandler(
                  (message){
                if (message.name == "addNewLeads") {
                  NavigationUtils.openScreen(ScreenRoutes.addNewLeads1);
                }
              }));
        } else if (snapshot.hasError) {
          // Handle any errors that occur during data fetching
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          // Show a loading indicator while fetching data
          return buildLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadingIndicator() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.yellow),
      ),
    );
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      final response = await ApiRepository.getUserProfile({});
      if (response.isSuccess!) {
        final userDataMagento = response.data;
        final userData = response.data?['userModelData'];
        if (userData != null) {
          name = userDataMagento['firstName'] ?? '';
          phoneNumber = userDataMagento["phoneNumber"] ?? "";
          profilePic = userData["profilePicUrl"] ?? "";
          if (name.isNotEmpty) {
            map["userName"] = name;
          }
          if (phoneNumber.isNotEmpty) {
            map["phoneNumber"] = phoneNumber;
          }
          if (profilePic.isNotEmpty) {
            map["image"] = profilePic;
          }
        }
      } else {
        UiUtils.showToast(response.error![MESSAGE]);
      }
    } catch (e) {
      UiUtils.showToast("Error fetching initial data");
    }
    return null;
  }

  void updateState() {
    setState(() {});
  }
}
