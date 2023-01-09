import 'package:flutter/material.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikPaymentDetailsScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Widgets/UikSearchBar/searchbar.dart';
import '../widgets/UikCell/UikCell.dart';
import 'UikHome.dart';

class UikBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150), // Set this height
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(
                    titleText: "Sector 14",
                    subtitleText: "Gurugoan-Haryana-India",
                    leftChild: Icon(Icons.location_on),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SearchBar(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              UikHome().page,
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
              color: const Color(0xFF6247FF),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "12 items | 1200.00",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "View Cart",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
                  icon: Icon(Icons.euro_symbol),
                ),
                Tab(
                  icon: Icon(Icons.assignment),
                ),
                Tab(
                  icon: Icon(Icons.account_balance_wallet),
                ),
                Tab(
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
