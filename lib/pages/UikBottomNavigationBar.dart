import 'package:flutter/material.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';

import '../main.dart';
import 'UikHome.dart';

class UikBottomNavigationBar extends StatefulWidget {
  const UikBottomNavigationBar({super.key});

  @override
  State<UikBottomNavigationBar> createState() => _UikBottomNavigationBarState();
}

class _UikBottomNavigationBarState extends State<UikBottomNavigationBar> {
  final int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
     UikHome().getPage(),
  ];

  int totalCartItems = CartDataHandler.getCartItems().length;

  void _onItemTapped(int index) {
    var context = NavigationService.navigatorKey.currentContext;
    if (index == _selectedIndex) return;
    if (index == 1) {
      Map<String, dynamic>? args = {
        "academyId": 3
      };
      NavigationUtils.openScreen(ScreenRoutes.partnerTrainingHome, args);
    }
    if (index == 2) {
      Map<String, dynamic>? args = {
        "url": "https://www.extrape.com/blog/category/start-here/"
      };
      NavigationUtils.openScreen(ScreenRoutes.webScreenView,args);
    }
    if (index == 3) {
      Navigator.pushNamed(context!, ScreenRoutes.myAccountScreen);
    }
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildNavItem(Icons.home, 'Home', 0),
                buildNavItem(Icons.menu_book, 'Academy', 1),
                buildNavItem(Icons.payment, 'ExtraPe', 2),
                buildNavItem(Icons.person_outline_sharp, 'Account', 3),
                // Add more items as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
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
    Navigator.pushNamed(context!, ScreenRoutes.cartScreen);
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
