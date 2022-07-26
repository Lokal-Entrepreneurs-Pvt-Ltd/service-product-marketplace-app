import 'package:flutter/material.dart';
import 'package:login/Widgets/UikiIcon/uikIcon.dart';

class MyTabBar extends StatefulWidget {
  final List<IconData> ll;

  MyTabBar({required this.ll});
  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.ll.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var ll = widget.ll;
    return Scaffold(
      body: Container(
        width: double.infinity,
        // height: double.infinity,
        // height: 0,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: <Widget>[
            for (int i = 0; i < ll.length; i++) ...[
              Tab(
                icon: UikIcon(valIcon: ll[i]),
              )
            ],
          ],
        ),
      ),
    );
  }
}
