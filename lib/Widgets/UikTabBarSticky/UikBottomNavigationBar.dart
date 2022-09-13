import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CartPage.dart';
import 'UikComponentDisplayer.dart';
import 'UikTabBarSticky.dart';

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
              Container(child: Icon(Icons.abc)),
              CartPage().page,
              UikComponentDisplayer().page,
              UikTabBarSticky()
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
      color: Color(0xFFFFFFFF),
      child: Material(
        color: Colors.transparent,
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xffBDBDBD),
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.white,
          tabs: [
            InkWell(
              splashColor: Colors.red,
              radius: 120.0,
              child: Tab(
                icon: Icon(Icons.euro_symbol),
              ),
              onTap: () {},
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
