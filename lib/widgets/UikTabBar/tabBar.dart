import 'package:flutter/material.dart';
import 'package:login/Widgets/UikiIcon/uikIcon.dart';

class MyTabBar extends StatefulWidget {
  final List<IconData> ll;
  // final heightsize;
  final isBorder;
  final indicatorColor;
  final backgroundColor;
  final iconSize;
  final bottomMargin;

  MyTabBar({
    // this.heightsize,
    this.bottomMargin,
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
        margin: EdgeInsets.only(),
        // height: widget.heightsize,
        width: double.infinity,
        //  padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          border: (widget.isBorder != null) ? Border.all() : null,
          borderRadius: BorderRadius.circular(10),
          color: widget.backgroundColor,
        ),
        child: TabBar(
          indicatorWeight: 0.1,
          indicatorColor: widget.indicatorColor,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelPadding: EdgeInsets.only(top: 5),
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
