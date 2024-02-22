import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikDynamicPage.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../main.dart';
import 'UikHome.dart';

class UikBottomNavigationBar extends StatefulWidget {
  const UikBottomNavigationBar({super.key});

  @override
  State<UikBottomNavigationBar> createState() => _UikBottomNavigationBarState();
}

class _UikBottomNavigationBarState extends State<UikBottomNavigationBar> {
  final int _selectedIndex = 0;
  TutorialCoachMark? _tutorialCoachMark;
  List<TargetFocus> targets = [];
  GlobalKey homekey = GlobalKey();
  GlobalKey menukey = GlobalKey();
  GlobalKey accountkey = GlobalKey();
  GlobalKey newsKey = GlobalKey();
  GlobalKey jobkey = GlobalKey();

  static final List<Widget> _widgetOptions = <Widget>[
    UikHome().getPage(),
  ];

  int totalCartItems = CartDataHandler.getCartItems().length;

  void _onItemTapped(int index) {
    var context = AppRoutes.rootNavigatorKey.currentContext;
    if (index == _selectedIndex) return;
    if (index == 1) {
      Map<String, dynamic>? args = {"academyId": 3};
      NavigationUtils.openScreen(ScreenRoutes.partnerTrainingHome, args);
    }
    // if (index == 2) {
    //   Map<String, dynamic>? args = {
    //     "url": "https://www.extrape.com/blog/category/start-here/"
    //   };
    //   NavigationUtils.openScreen(ScreenRoutes.webScreenView,args);
    // }
    if (index == 0) {
      context!.push(ScreenRoutes.alljobs);
    }
    if (index == 2) {
      context!.push(ScreenRoutes.myAccountScreen, extra: {});
    }
    if (index == 3) {
      context!.push(ScreenRoutes.newsPage, extra: {});
    }
  }

  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), (() {
      if (!UserDataHandler.getIsOnboardingCoachMarkDisplayed())
        _showTutorialCoachMark();
    }));
    super.initState();
  }

  void _showTutorialCoachMark() {
    initTarget();
    _tutorialCoachMark = TutorialCoachMark(
        opacityShadow: 0.3,
        targets: targets,
        pulseEnable: false,
        hideSkip: true,
        focusAnimationDuration: Duration(milliseconds: 0),
        unFocusAnimationDuration: Duration(milliseconds: 0))
      ..show(context: context);
    UserDataHandler.saveIsOnboardingCoachMarkDisplayed(true);
  }

  void initTarget() {
    targets = [
      TargetFocus(
        identify: "home-key",
        keyTarget: homekey,
        shape: ShapeLightFocus.Circle,
        radius: 80,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachMark(
                text: "Home page where you will find Services/Jobs",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
      // TargetFocus(
      //   identify: "home-key",
      //   keyTarget: jobkey,
      //   shape: ShapeLightFocus.Circle,
      //   radius: 80,
      //   contents: [
      //     TargetContent(
      //       align: ContentAlign.top,
      //       builder: (context, controller) {
      //         return CoachMark(
      //           text: "This is the Job page where you find related job",
      //           onNext: () {
      //             controller.next();
      //           },
      //         );
      //       },
      //     ),
      //   ],
      // ),
      TargetFocus(
        identify: "home-key",
        keyTarget: menukey,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachMark(
                text: "All Lokal Training Academy info",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "home-key",
        keyTarget: accountkey,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachMark(
                text: "All information related to your account.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: UikHome().page,
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0, // Remove shadow
          child: SizedBox(
            height: 56, // Adjust the height as needed
            child: Row(
              // scrollDirection: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildNavItem(Icons.home, 'Home', 0, homekey),
                // buildNavItem(Icons.work, "Job", 1, jobkey),
                buildNavItem(Icons.menu_book, 'Academy', 2, menukey),
                buildNavItem(
                    Icons.person_outline_sharp, 'Account', 3, accountkey),
                buildNavItem(
                    Icons.newspaper, 'News', 3, newsKey),
                // buildNavItem(Icons.payment, 'ExtraPe', 3),
                // Add more items as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index, GlobalKey key) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          key: key,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon,
                color: _selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
            Text(label,
                style: TextStyle(
                  color: _selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}

class BottomCartDetails extends StatelessWidget {
  const BottomCartDetails({
    super.key,
    required this.totalItems,
    this.totalCost = 0.0,
  });

  final int totalItems;
  final double totalCost;

  void openCartScreen() {
    var context = NavigationService.navigatorKey.currentContext;
    NavigationUtils.openScreen(ScreenRoutes.cartScreen, {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openCartScreen();
      },
      child: Container(
        height: 37,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: const Color(0xFF6247FF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$totalItems items | $totalCost",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const Text(
              "View Cart",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoachMark extends StatefulWidget {
  const CoachMark(
      {super.key,
      required this.text,
      this.skip = "SKIP",
      this.next = "NEXT",
      this.onSkip,
      this.onNext});

  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;
  @override
  State<CoachMark> createState() => _CoachMarkState();
}

class _CoachMarkState extends State<CoachMark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.yellow[100], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.text),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: widget.onSkip, child: Text(widget.skip)),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: widget.onNext, child: Text(widget.next)),
            ],
          )
        ],
      ),
    );
  }
}
