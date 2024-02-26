import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/utils/extensions.dart';

import '../../utils/ActionUtils.dart';
import '../../utils/network/ApiRepository.dart';
import 'package:ui_sdk/props/UikAction.dart';

class UserAccountDetails extends StatefulWidget {
  final dynamic args;

  const UserAccountDetails({Key? key, this.args}) : super(key: key);

  @override
  State<UserAccountDetails> createState() => _UserAccountDetailsState();
}

class _UserAccountDetailsState extends State<UserAccountDetails> {
  late Future<ApiResponse> apiResponse;

  @override
  void initState() {
    super.initState();
    apiResponse = fetchData();
  }

  Future<ApiResponse> fetchData() async {
    // Replace this with your actual API call
    return ApiRepository.getUserAccountDetails(widget.args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Text(
            "Version: ${UserDataHandler.getAppVersion()}",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ("#9E9E9E").toColor()),
          ),
        ),
      ],
      body: FutureBuilder<ApiResponse>(
        future: apiResponse,
        builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final data = snapshot.data?.data;
            final profileDetails = data["profileDetails"];
            final profileItems =
                List<Map<String, dynamic>>.from(data["profileItems"]);

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  _buildProfileDetails(profileDetails),
                  for (var profileItem in profileItems)
                    _buildProfileItem(profileItem),
                  GestureDetector(
                    onTap: () {
                      UikAction signoutAction = UikAction();
                      signoutAction.tap.type = "OPEN_SIGN_OUT";
                      ActionUtils.executeAction(signoutAction);
                    },
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Sign Out",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    );
  }

  Widget _buildProfileDetails(Map<String, dynamic> profileDetails) {
    return GestureDetector(
      onTap: () {
        UikAction action = UikAction.fromJson(profileDetails["action"]);
        ActionUtils.executeAction(action);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708690875012-Group%20513255.png"),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.network(
            //   profileDetails["image"],
            //   width: 68,
            //   height: 68,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profileDetails["name"]}, ${profileDetails["age"]}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  profileDetails["email"],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  profileDetails["phone"],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SvgPicture.network(
              "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708692349940-qr-code-scan-svgrepo-com%201.svg",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(Map<String, dynamic> profileItem) {
    return GestureDetector(
      onTap: () {
        UikAction action = UikAction.fromJson(profileItem["action"]);
        ActionUtils.executeAction(action);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      profileItem["title"],
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 8.0,
                  children: List<String>.from(profileItem["tags"]).map((item) {
                    return Text(
                      '•  $item',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: [4, 1],
                    strokeWidth: 1,
                    radius: Radius.circular(8),
                    color: Colors.black,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profileItem["description"].isNotEmpty
                                ? profileItem["description"]
                                : 'Additional Info',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SvgPicture.network(
                            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708688244282-arrow-right-up.svg",
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
