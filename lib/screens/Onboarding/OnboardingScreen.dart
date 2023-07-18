import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Widgets/UikButton/UikButton.dart';
import 'NewOnboardingScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;
  String? selectedUserType;
  List<String> userTypes = [CUSTOMER, PARTNER, AGENT];
  List<String> images = [
    "assets/images/Onboarding1.png",
    "assets/images/Onboarding2.png",
    "assets/images/Onboarding3.png",
  ];
  List<List<String>> texts = [
    [BRAND_THAT_EARN, JOIN_LOKAL],
    [INTERNET_NAVIGATE, FAST_INTERNET],
    [
      SERVICES_CONNECT,
      SERVICES_MSG
    ],
  ];
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: DIMEN_100),
                height: DIMEN_520,
                width: DIMEN_375,
                child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(children: [
                          Image.asset(
                            images[index % images.length],
                            width: double.infinity,
                          ),
                          Container(
                            // decoration: const BoxDecoration(
                            //     color: Color.fromRGBO(0, 0, 0, 0.1)),
                            margin: const EdgeInsets.fromLTRB(0, DIMEN_375, 0, 0),
                            width: double.infinity,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  texts[index % texts.length][0],
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: DIMEN_32,
                                  ),
                                ),
                                const SizedBox(
                                  height: DIMEN_6,
                                ),
                                Text(
                                  texts[index % texts.length][1],
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: DIMEN_14,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, DIMEN_20, 0, 0),
                                  child: SmoothPageIndicator(
                                    axisDirection: Axis.horizontal,
                                    controller: _pageController,
                                    effect: const ExpandingDotsEffect(
                                      spacing: DIMEN_4,
                                      radius: DIMEN_5,
                                      activeDotColor: Colors.black,
                                      dotHeight: DIMEN_5,
                                      dotWidth: DIMEN_5,
                                      expansionFactor: DIMEN_2,
                                    ),
                                    count: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      );
                    }),
              ),
              Text(
                ACCOUNT_TYPE,
                style: GoogleFonts.poppins(
                    fontSize: DIMEN_14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: DIMEN_7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildUserTypeRectangle(0),
                  buildUserTypeRectangle(1),
                  buildUserTypeRectangle(2),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: DIMEN_10, right: DIMEN_10),
                child: UikButton(
                  text: CONTINUE,
                  backgroundColor: const Color(0xffFEE440),
                  onClick: () async {
                    selectedUserType = userTypes[selectedIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewOnboardingScreen(
                            selectedUserType: selectedUserType),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserTypeRectangle(int index) {
    List<Widget> avatars = [
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: DIMEN_90,
              height: DIMEN_70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DIMEN_10),
                border: Border.all(
                  color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  width: DIMEN_2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  ),
                  const SizedBox(height: DIMEN_8),
                  Text(
                    CUSTOMER,
                    style: GoogleFonts.poppins(
                      fontSize: DIMEN_14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DIMEN_16),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: DIMEN_90,
              height: DIMEN_70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DIMEN_10),
                border: Border.all(
                  color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  width: DIMEN_2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business,
                    color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  ),
                  const SizedBox(height: DIMEN_8),
                  Text(
                    PARTNER,
                    style: GoogleFonts.poppins(
                      fontSize: DIMEN_14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DIMEN_16),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: DIMEN_90,
              height: DIMEN_70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DIMEN_10),
                border: Border.all(
                  color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  width: DIMEN_2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                  ),
                  const SizedBox(height: DIMEN_8),
                  Text(
                    AGENT,
                    style: GoogleFonts.poppins(
                      fontSize: DIMEN_14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Color(0xFF4169E1) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DIMEN_16),
          ],
        ),
      ),
    ];

    return avatars[index];
  }
}
