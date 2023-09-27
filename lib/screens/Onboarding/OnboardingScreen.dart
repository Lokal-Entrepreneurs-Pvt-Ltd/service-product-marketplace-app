import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/constants/strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'NewOnboardingScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<String> images = [
    "assets/images/NewOnboarding3.png",
    "assets/images/NewOnboarding2.png",
    "assets/images/NewOnboarding1.png",
  ];
  int _currentPage = 0;
  int totalImages = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return OnboardingSlider(
                  imagePath: images[index],
                  currentPage: index,
                  totalImages: images.length,
                  pageController: _pageController,
                  lastPage: index == images.length - 1,
                );
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
            Positioned(
              bottom: 100,
              left: 25,
              right: 0,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: totalImages,
                effect: const ExpandingDotsEffect(
                  dotHeight: 5,
                  dotWidth: 6,
                  spacing: 8,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 5,
              right: 0,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _pageController.animateToPage(
                        images.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        SKIP,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF212121),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: InkWell(
                      onTap: () {
                        if (_currentPage < images.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                      },
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffFEE440),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: DIMEN_8, horizontal: DIMEN_16),
                          child: Text(
                            _currentPage < images.length - 1
                                ? NEXT
                                : GET_STARTED,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rest of your code remains the same...

class OnboardingSlider extends StatefulWidget {
  final String imagePath;
  final int currentPage;
  final int totalImages;
  final bool lastPage;
  final PageController pageController;

  const OnboardingSlider({
    super.key,
    required this.imagePath,
    required this.currentPage,
    required this.totalImages,
    required this.lastPage,
    required this.pageController,
  });

  @override
  _OnboardingSliderState createState() => _OnboardingSliderState();
}

class _OnboardingSliderState extends State<OnboardingSlider> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
