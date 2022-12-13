import 'package:flutter/material.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';

import 'UikHome.dart';

class UikBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xFF3F5AA6),
          //   title: Text("Title text"),
          // ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              // UikComponentDisplayer().page,
              UikHome().page,
              // UikCatalogScreen().page,
              // UikSearchCatalog().page,
              // UikProductPage().page,
              // UikOrder().page,
              // UikFilter().page,
              // UikCart().page
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
      child: const Material(
        color: Colors.transparent,
        child: TabBar(
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
      ),
    );
  }
}
