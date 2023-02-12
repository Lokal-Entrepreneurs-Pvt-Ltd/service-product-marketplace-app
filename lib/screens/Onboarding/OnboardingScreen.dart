import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/screens/RegisterScreen/RegisterScreen.dart';
import 'package:lokal/screens/signUp/signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> images = [
    "assets/images/onboard4.jpeg",
    "assets/images/onboard2.jpeg",
    "assets/images/onboard3.jpeg",
    "assets/images/onboard1.jpeg"
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
              SizedBox(
                height: 577,
                width: 375,
                child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(children: [
                          Image.network(
                            images[index % images.length],
                            width: double.infinity,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.1)),
                            margin: const EdgeInsets.fromLTRB(0, 335, 0, 0),
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Apply Online",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "After you fill up the form, our onboarding team will reachout to you for further guidance and handholding",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        137, 70, 0, 0),
                                    child: SmoothPageIndicator(
                                      axisDirection: Axis.horizontal,
                                      controller: _pageController,
                                      effect: const ExpandingDotsEffect(
                                        spacing: 4,
                                        radius: 5,
                                        activeDotColor: Colors.yellow,
                                        dotHeight: 5,
                                        dotWidth: 5,
                                        expansionFactor: 2,
                                      ),
                                      count: 4,
                                    ))
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
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 21, 18, 10),
                          child: Text(
                            "Earn More. Earn Respect. Become a Brand.",
                            style: TextStyle(
                              color: HexColor("#212121"),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 54),
                          child: Text(
                            "Join 2000+ plus Lokal Partners across India ",
                            style: TextStyle(
                              color: HexColor("#212121"),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 40,
                    width: 162,
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a Partner?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: HexColor("#9E9E9E")),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: HexColor("#212121"),
                              ),
                            ))
                      ],
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
