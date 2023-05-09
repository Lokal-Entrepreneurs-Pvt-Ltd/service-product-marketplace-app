import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/screens/login/login.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> images = [
    "assets/images/Onboarding1.png",
    "assets/images/Onboarding2.png",
    "assets/images/Onboarding3.png",
  ];
  List<List<String>> texts = [
    ["Brand that earn!", "Join 2000+ Lokal Partners across India"],
    ["Internet that navigate", "Fast internet to unconnected corners of india"],
    [
      "Services that connect",
      "Having services that helps to reach more people"
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
                margin: EdgeInsets.only(top: 100),
                height: 520,
                width: 375,
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
                            margin: const EdgeInsets.fromLTRB(0, 375, 0, 0),
                            width: double.infinity,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  texts[index % texts.length][0],
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  texts[index % texts.length][1],
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: SmoothPageIndicator(
                                    axisDirection: Axis.horizontal,
                                    controller: _pageController,
                                    effect: const ExpandingDotsEffect(
                                      spacing: 4,
                                      radius: 5,
                                      activeDotColor: Colors.black,
                                      dotHeight: 5,
                                      dotWidth: 5,
                                      expansionFactor: 2,
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
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#FEE440")),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "Become Partner",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: HexColor("#212121")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.yellow),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#FFFFFF")),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPageScreen()));
                      },
                      child: Text(
                        "Log In ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: HexColor("#000000")),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
