import 'package:flutter/material.dart';

import '../../widgets/UikIcon/uikIcon.dart';
// import 'package:login/Widgets/UikiIcon/uikIcon.dart';

class MyTabBar extends StatefulWidget {
  final List<IconData> ll;
  final isBorder;
  final indicatorColor;
  final backgroundColor;
  final iconSize;
  final topMargin;
  MyTabBar({
    this.topMargin = 18.74,
    this.iconSize = 27.0,
    this.backgroundColor = Colors.white,
    required this.ll,
    this.isBorder,
    this.indicatorColor = Colors.white,
  });
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
        //  padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(
          top: widget.topMargin,
        ),
        decoration: BoxDecoration(
          border: (widget.isBorder != null) ? Border.all() : null,
          borderRadius: BorderRadius.circular(10),
          color: widget.backgroundColor,
        ),
        child: TabBar(
          indicatorColor: widget.indicatorColor,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: <Widget>[
            for (int i = 0; i < ll.length; i++) ...[
              Tab(
                icon: UikIcon(
                  valIcon: ll[i],
                  iconSize: widget.iconSize,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
