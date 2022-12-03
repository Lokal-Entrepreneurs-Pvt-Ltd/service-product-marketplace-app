import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/pages/UikCart.dart';
import 'package:login/pages/UikCatalogScreen.dart';
import 'package:login/pages/UikOrder.dart';
import 'package:login/pages/UikFilter.dart';
import 'package:login/pages/UikProductPage.dart';
import 'package:login/pages/UikSearchCatalog.dart';

// import '../Widgets/UikAvatar/UikAvatar.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
// import '../Widgets/UikCell/UikCell.dart';
import '../widgets/UikCell/UikCell.dart';
import 'UikComponentDisplayer.dart';
import 'UikHome.dart';
import 'UikMyAccountScreen.dart';
import 'UikComponentDisplayer.dart';

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
              UikCatalogScreen().page,
              UikSearchCatalog().page,
              UikProductPage().page,
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
      color: Color(0xFFFFFFFF),
      child: Material(
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
