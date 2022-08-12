import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Pagination extends StatefulWidget {
  final List<StatelessWidget> pageList;
  final dotcolor, activeDotColor;
  final dotHeight, dotWidth;
  final spacing;
  final dotRadius;
  final bgColor;

  const Pagination({
    super.key,
    required this.pageList,
    required this.dotcolor,
    required this.activeDotColor,
    required this.dotHeight,
    required this.dotWidth,
    required this.spacing,
    required this.dotRadius,
    this.bgColor = Colors.transparent,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final pages = PageView(
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        controller: pageController,
        children: widget.pageList);

    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(30),
        // color: Colors.amber,
        child: Stack(
          children: [
            pages,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // width: 100,
                height: 13,
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: widget.bgColor,
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: widget.pageList.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: widget.activeDotColor,
                          dotColor: widget.dotcolor,
                          dotHeight: widget.dotHeight,
                          dotWidth: widget.dotWidth,
                          spacing: widget.spacing,
                          radius: widget.dotRadius,
                          expansionFactor: 2.1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
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
          PageView(
            controller: pagecontroller,
            children: pages,
            onPageChanged: (int index) {},
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
*/
