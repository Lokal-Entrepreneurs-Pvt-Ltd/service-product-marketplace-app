import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/constants/strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Widgets/UikButton/UikButton.dart';
import 'NewOnboardingScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<String> images = [
    "assets/images/NewOnborading1.png",
    "assets/images/NewOnboarding2.png",
    "assets/images/NewOnboarding3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return OnboardingSlider(
              imagePath: images[index],
              currentPage: index, // Pass the index as currentPage
              totalImages: images.length,
              lastPage: index == images.length - 1,
              pageController: _pageController,
            );
          },
        ),
      ),
    );
  }
}

class OnboardingSlider extends StatefulWidget {
  final String imagePath;
  final int currentPage;
  final int totalImages;
  final bool lastPage;
  final PageController pageController;

  const OnboardingSlider({super.key, 
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
                if (widget.currentPage == 1) // Display only for the 2nd image
                  Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                if (widget.currentPage != 1) // Display for other images
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(
                  height: DIMEN_32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: SmoothPageIndicator(
                    controller: widget.pageController,
                    count: widget.totalImages,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 5, // Customize dot height
                      dotWidth: 6, // Customize dot width
                      spacing: 8, // Customize spacing between dots
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: DIMEN_32,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextButton(
                        onPressed: () {
                          widget.pageController.animateToPage(
                            widget.totalImages - 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        child: const Text(
                          SKIP,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: UikButton(
                        heightSize: 36,
                        widthSize: 113,
                        text: GET_STARTED,
                        backgroundColor: const Color(0xffFEE440),
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewOnboardingScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
