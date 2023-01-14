import 'package:flutter/material.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';

class UikBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              UikHomeWrapper(),
              UikCatalogScreen().page,
              UikSearchCatalog().page,
              UikProductPage().page,
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      width: 375,
      height: 104,
      color: const Color(0xFFFFFFFF),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
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
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xffBDBDBD),
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.home_outlined),
                ),
                Tab(
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
                Tab(
                  icon: Icon(Icons.settings_outlined),
                ),
                Tab(
                  icon: Icon(Icons.person_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
