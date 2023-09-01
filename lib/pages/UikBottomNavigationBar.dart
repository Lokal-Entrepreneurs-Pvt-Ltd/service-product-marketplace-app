import 'package:flutter/material.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import '../main.dart';

class UikBottomNavigationBar extends StatefulWidget {
  const UikBottomNavigationBar({super.key});

  @override
  State<UikBottomNavigationBar> createState() => _UikBottomNavigationBarState();
}

class _UikBottomNavigationBarState extends State<UikBottomNavigationBar> {
  final int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const UikHomeWrapper(),
    // UikCartScreen().page,
    // UikMyAccountScreen().page,
  ];

  int totalCartItems = CartDataHandler.getCartItems().length;

  void _onItemTapped(int index) {
    var context = NavigationService.navigatorKey.currentContext;
    if (index == _selectedIndex) return;
    if (index == 1) {
      Navigator.pushNamed(context!, ScreenRoutes.myGames);
    }
    // if (index ==2) {
    //   Navigator.pushNamed(context!, ScreenRoutes.odOpHomeScreen);
    // }
    if (index == 2) {
      Navigator.pushNamed(context!, ScreenRoutes.myAccountScreen);
    }

    // if (index == 1) {
    //   Navigator.pushNamed(context!, ScreenRoutes.cartScreen);
    // } else if (index == 2) {
    //   Navigator.pushNamed(context!, ScreenRoutes.myAccountScreen);
    // }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _widgetOptions.elementAt(0),
            if (totalCartItems > 0)
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: BottomCartDetails(
                  totalItems: totalCartItems,
                  totalCost: 1000.0,
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.shopping_bag,
            //   ),
            //   label: "",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.gamepad_outlined,
              ),
              label: "",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.map,
            //   ),
            //   label: "",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_sharp,
              ),
              label: "",
            )
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
    // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
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
