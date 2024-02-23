import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/ActionUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/props/UikAction.dart';
import 'package:ui_sdk/utils/extensions.dart';

class UserAccountDetails extends StatefulWidget {
  final dynamic args;
  const UserAccountDetails({super.key, required this.args});

  @override
  State<UserAccountDetails> createState() => _UserAccountDetailsState();
}

class _UserAccountDetailsState extends State<UserAccountDetails> {
  Future<Map<String, dynamic>?>? _futureData;
  Map<String, dynamic> profileDetails = {};
  List<Map<String, dynamic>> profileItems = [];
  bool updating = true;
  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.yellow),
    );
  }

  Future<Map<String, dynamic>?> fetchData() async {
    // try {
    //   // final response = await ApiRepository.getUserProfile({});
    //   if (response.isSuccess!) {
    //     final userData = response.data;

    //     if (userData != null) {
    //       updating = false;
    //       setState(() {});
    //     }
    //   } else {
    //     UiUtils.showToast(response.error![MESSAGE]);
    //   }
    // } catch (e) {
    //   print(e);
    //   UiUtils.showToast("Error fetching initial data");
    // }
    final response = {
      "profiledetails": {
        "name": "Ram",
        "age": "10 yrs",
        "phone": "95554121",
        "email": "asdads@dccda.com",
        "image":
            "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708691008618-Group%20513258%20(1).png",
        "shareurl": "",
        "action": {
          "tap": {
            "type": "OPEN_LOKAL_QR",
            "data": {
              "url":
                  "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
            }
          }
        }
      },
      "profileitems": [
        {
          "title": "Profile Details",
          "tags": ["Graduation", "1 Year Experience", "Industry-Delivery"],
          "description": "This is Profile Details",
          "action": {
            "tap": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://sylhetmirror.com/userProfileInfo/"}
            }
          }
        },
        {
          "title": "General Details",
          "tags": ["Bank Account", "Bike", "Address", "Graduate"],
          "description": "This is General Details",
          "action": {
            "tap": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://sylhetmirror.com/userGeneralInfo/"}
            }
          }
        },
        {
          "title": "Other Details",
          "tags": ["Bank Account", "Bike", "Permanent Address"],
          "description": "",
          "action": {
            "tap": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://sylhetmirror.com/userOtherInfo/"}
            }
          }
        },
        {
          "title": "Document Details",
          "tags": ["Aadhar Front", "Aadhar Back", "PAN"],
          "description": "",
          "action": {
            "tap": {
              "type": "OPEN_PAGE",
              "data": {"url": "https://sylhetmirror.com/userDocumentInfo/"}
            }
          }
        }
      ]
    };
    profileDetails = response["profiledetails"] as Map<String, dynamic>;
    profileItems = response["profileitems"] as List<Map<String, dynamic>>;
    updating = false;
    setState(() {});
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _futureData,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return updating ? buildLoadingIndicator() : buildBody();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return buildLoadingIndicator();
          }
        },
      ),
    );
  }

  Widget buildBody() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileDetails(),
            for (var profileitem in profileItems)
              buildProfileItem(
                title: profileitem["title"],
                tags: profileitem["tags"],
                description: profileitem["description"],
                action: profileitem["action"],
              )
          ],
        ),
      ),
    );
  }

  Widget buildProfileDetails() {
    return GestureDetector(
      onTap: () {
        handleTap(profileDetails["action"]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://storage.googleapis.com/lokal-app-38e9f.appspot.com/misc%2F1708690875012-Group%20513255.png"),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  profileDetails["image"],
                  width: 68,
                  height: 68,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profileDetails["name"]}, ${profileDetails["age"]}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      profileDetails["email"],
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ("#9E9E9E").toColor(),
                      ),
                    ),
                    Text(
                      profileDetails["phone"],
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ("#9E9E9E").toColor(),
                      ),
                    ),
                  ],
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

  Widget buildProfileItem({
    required String title,
    List<String> tags = const [],
    String description = "",
    Map<String, dynamic> action = const {},
  }) {
    return GestureDetector(
      onTap: () {
        handleTap(action);
      },
      child: Card(
        elevation: 0.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
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
                            color: UikColor.gengar_500.toColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(right: 30),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 8.0,
                      children: tags.map((item) {
                        return Text(
                          '•  $item',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ("#9E9E9E").toColor(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [4, 1],
                      strokeWidth: 1,
                      radius: Radius.circular(8),
                      color: Colors.black,
                      stackFit: StackFit.passthrough,
                      child: Container(
                        decoration: BoxDecoration(
                          color: UikColor.giratina_100.toColor(),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (description.isEmpty)
                                ? Text(
                                    'Additional Info',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    description,
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
              width: double.maxFinite,
              height: 2,
              color: ("#E4E4E4").toColor(),
            ),
          ],
        ),
      ),
    );
  }

  void handleTap(Map<String, dynamic> action) {
    UikAction uikAction = UikAction.fromJson(action);
    ActionUtils.executeAction(uikAction);
  }
}
