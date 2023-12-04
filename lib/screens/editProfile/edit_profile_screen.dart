import 'dart:io';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lokal/screens/editProfile/theme_helper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int _selectedIndex = 0;
  int _page = 0;
  File? profileFile;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  Future<FilePickerResult?> pickImage() async {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    return image;
  }

  Color kpink = Color(0xFFff6374);
  Color kblue = Color(0xFF71b8ff);
  Color kpurple = Color(0xFF9ba0fc);
  Color kblack = Color.fromARGB(255, 0, 0, 0);

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height *
                      0.3, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/img_group2 (2).jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.26,
                left: screenWidth * 0.35,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/img_ellipse194.png'),
                  radius: screenWidth * 0.1,
                ),
              ),
              Positioned(
                top: screenHeight * 0.36,
                right: screenWidth * 0.32,
                child: GestureDetector(
                  onTap: () => selectProfileImage(),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/img_search.jpg'),
                    radius: screenWidth * 0.03,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          // Handle back button press
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //ToDo
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 240),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 380,
                            margin: EdgeInsets.only(top: 11, right: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 34),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Plan",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: Text(
                                          "valid till",
                                          style: CustomTextStyles
                                              .labelLargeGray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "silver",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 1),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: appTheme.indigo400,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          "03 dec 24",
                                          style: CustomTextStyles
                                              .labelLargeIndigo400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 380,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, top: 21),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Mrigansh Gupta",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 16, right: 21),
                            child: Container(
                              width: 340,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile Number",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        "9462572846",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 26),
                                    child: Text(
                                      "update",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 17, top: 18, right: 21),
                            child: Container(
                              width: 340,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "email id",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "lokalcompany@gmail.com",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 45, top: 26, bottom: 3),
                                    child: Text(
                                      "update",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: 350,
                              height: 60,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 246, 230, 116),
                                border: Border.all(
                                  color: Color.fromARGB(255, 246, 230, 116),
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Save Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _page,
          showElevation: true,
          onItemSelected: onPageChanged,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: kblack,
              inactiveColor: Colors.grey[300],
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              inactiveColor: Colors.grey[300],
              activeColor: kblack,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              inactiveColor: Colors.grey[300],
              activeColor: kblack,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.account_circle),
              title: const Text('Account'),
              inactiveColor: Colors.grey[300],
              activeColor: kblack,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextStyles {
  // Label text style
  static get labelLargeGray500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray500,
      );
  static get labelLargeIndigo400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.indigo400,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
