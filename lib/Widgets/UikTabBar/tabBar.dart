// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyTabBar());
// }

class MyTabBar extends StatefulWidget {
  final shopping;
  final favorite;
  final notification;
  final identity;
  final settings;
  final number;

  MyTabBar(
      {this.favorite,
      this.shopping,
      this.identity,
      this.notification,
      this.settings,
      required this.number});
  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  // const TabBar({Key? key}) : super(key: key);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.number, vsync: this);
  }

  // ignore: unused_field
  // static const IconData bell = IconData(0xf3e1, fontFamily: "iconFont",fontPackage: );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Spacer(),
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              // child: Row(
              //   children: [
              //     Flexible(
              //       child: Container(
              //         child: Icon(Icons.abc),
              //       ),
              //     ),
              //     Flexible(
              //       child: Container(
              //         child: Icon(Icons.mic),
              //       ),
              //     ),
              //     Flexible(
              //       child: Container(
              //         child: Icon(Icons.search),
              //       ),
              //     ),
              //     Flexible(
              //       child: Container(
              //         child: Icon(Icons.notification_add),
              //       ),
              //     ),
              //   ],
              // ),

              child: TabBar(
                indicatorColor: Colors.grey,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                tabs: <Widget>[
                  if (widget.shopping != null)
                    Tab(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        // color: Colors.black,
                      ),
                    ),
                  if (widget.favorite != null)
                    Tab(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        // color: Colors.black,
                      ),
                    ),
                  if (widget.notification != null)
                    Tab(
                      icon: Icon(
                        Icons.notifications_none_rounded,

                        // color: Colors.black,
                      ),
                    ),
                  if (widget.identity != null)
                    Tab(
                      icon: Icon(
                        Icons.perm_identity_rounded,
                        // color: Colors.black,
                      ),
                    ),
                  if (widget.settings != null)
                    Tab(
                      icon: Icon(
                        Icons.settings_outlined,
                        // color: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
