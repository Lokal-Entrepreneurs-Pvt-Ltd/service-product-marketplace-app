import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/pages/UikCart.dart';
import 'package:login/pages/UikOrder.dart';

// import '../Widgets/UikAvatar/UikAvatar.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
// import '../Widgets/UikCell/UikCell.dart';
import '../widgets/UikCell/UikCell.dart';
import 'UikComponentDisplayer.dart';
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
              UikComponentDisplayer().page,
              MyAccount(
                ll: [
                  const Cell(
                    titleText: "Nadeem Khan",
                    subtitleText: "Beginner Partner",
                    leftChild: UikAvatar(
                      shape: UikAvatarShape.circle,
                      size: UikSize.SMALL,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    ),
                  ),
                  const Cell(
                    titleText: "My Details",
                    leftChild: Icon(Icons.person),
                  ),
                  const Cell(
                    titleText: "My Orders",
                    leftChild: Icon(Icons.mic),
                  ),
                  const Cell(
                    titleText: "My Wishlist",
                    leftChild: Icon(Icons.favorite_border),
                  ),
                  const Cell(
                    titleText: "Subscriptions",
                    leftChild: Icon(Icons.abc),
                  ),
                  const Cell(
                    titleText: "Sign out",
                    leftChild: Icon(Icons.person),
                  ),
                ],
              ),
              UikOrder().page,
              UikCart().page
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
