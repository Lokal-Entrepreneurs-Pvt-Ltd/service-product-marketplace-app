import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(Pagination(
    pages: const [],
  ));
}

class Pagination extends StatelessWidget {
  final pagecontroller = PageController();
  final List<StatelessWidget> pages;
  Pagination({Key? key, required this.pages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<StatelessWidget> pages;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //page view
          SizedBox(
            height: 200,
            child: PageView(
              controller: pagecontroller,
              children: pages,
            ),
          ),

          //dot indicator
          SmoothPageIndicator(
            controller: pagecontroller,
            count: pages.length,
            effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xff212121),
                dotColor: Color(0xffE0E0E0),
                dotHeight: 5,
                dotWidth: 5,
                spacing: 4,
                radius: 2.5,
                expansionFactor: 2.2
                // offset: 11
                ),
          ),
        ],
      ),
    );
  }
}
