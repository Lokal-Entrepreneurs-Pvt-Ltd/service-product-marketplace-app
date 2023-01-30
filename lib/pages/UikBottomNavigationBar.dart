import 'package:flutter/material.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';
import 'UikHome.dart';

class UikBottomNavigationBar extends StatefulWidget {
  @override
  State<UikBottomNavigationBar> createState() => _UikBottomNavigationBarState();
}

class _UikBottomNavigationBarState extends State<UikBottomNavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    UikHome().page,
    UikCartScreen().page,
    UikMyAccountScreen().page,
  ];
  void _onItemTapped(int index) {
    var context = NavigationService.navigatorKey.currentContext;
    if (index == _selectedIndex) return;
    if (index == 0) {
      Navigator.pushNamed(context!, ApiRoutes.homeScreen);
    } else if (index == 1) {
      Navigator.pushNamed(context!, ApiRoutes.cartScreen);
    } else if (index == 2) {
      Navigator.pushNamed(context!, ApiRoutes.myAccountScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: UikHomeWrapper(),
        bottomNavigationBar: Container(
          width: 375,
          height: 104,
          color: const Color(0xFFFFFFFF),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    openCartScreen();
                  },
                  child: Container(
                    height: 37,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFF6247FF),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "12 items | 1200.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "View Cart",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ),
                BottomNavigationBar(
                  onTap: _onItemTapped,
                  currentIndex: _selectedIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: "",
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openCartScreen() {
  var context = NavigationService.navigatorKey.currentContext;
  // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
  Navigator.pushNamed(context!, ApiRoutes.cartScreen);
}
