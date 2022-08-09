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
  final boxheight;
  final dotcolor, ActiveDotColor;
  final DotHeight, DotWidth;
  final spacing;
  final DotRadius;
  final expansionFactor;
  Pagination(
      {Key? key,
      required this.pages,
      this.boxheight,
      this.dotcolor,
      this.ActiveDotColor,
      this.DotHeight,
      this.DotWidth,
      this.spacing,
      this.DotRadius,
      this.expansionFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<StatelessWidget> pages;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //page view
          SizedBox(
            height: boxheight,
            child: PageView(
              controller: pagecontroller,
              children: pages,
            ),
          ),

          // dot indicator
          SmoothPageIndicator(
            controller: pagecontroller,
            count: pages.length,
            effect: ExpandingDotsEffect(
                activeDotColor: ActiveDotColor,
                dotColor: dotcolor,
                dotHeight: DotHeight,
                dotWidth: DotWidth,
                spacing: spacing,
                radius: DotRadius,
                expansionFactor: 2.1),
          ),
        ],
      ),
    );
  }
}
