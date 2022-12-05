import 'package:flutter/material.dart';
// import 'package:lokal/Widgets/UikiIcon/uikIcon.dart';

class Tabs extends StatefulWidget {
  final ll;
  final isBorder;
  final borderRadius;
  final onlyTopBorderRadius;
  final labelColor;
  final unselectedLabelColor;
  final indicatorColor;
  final gapBetweenTabs;

  Tabs({
    required this.ll,
    this.isBorder = null,
    this.gapBetweenTabs = 50,
    this.indicatorColor = Colors.yellow,
    this.borderRadius,
    this.onlyTopBorderRadius,
    this.labelColor = Colors.black,
    this.unselectedLabelColor = const Color(0xFF9E9E9E),
  });

  @override
  State<Tabs> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // super.initState();
    _tabController = TabController(length: widget.ll.length, vsync: this);
  }

  int val = 0;
  @override
  Widget build(BuildContext context) {
    var ll = widget.ll;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          //  width: 400,
          child: TabBar(
            splashBorderRadius:
                (widget.isBorder == true) ? BorderRadius.circular(25) : null,
            indicator: (widget.isBorder == true)
                ? BoxDecoration(
                    color: widget.indicatorColor,
                    borderRadius: (widget.onlyTopBorderRadius != null)
                        ? BorderRadius.only(
                            topRight:
                                Radius.circular(widget.onlyTopBorderRadius),
                            topLeft:
                                Radius.circular(widget.onlyTopBorderRadius),
                          )
                        : (widget.borderRadius != null)
                            ? BorderRadius.circular(widget.borderRadius)
                            : null,
                    //  border: Border.all(color: Colors.green),
                  )
                : null,
            onTap: (value) {
              setState(() {
                val = value;
              });
            },

            padding: (widget.isBorder == true) ? EdgeInsets.zero : null,
            //indicatorPadding: (widget.isBorder == true) ? EdgeInsets.zero : null,
            labelPadding: (widget.isBorder == true) ? EdgeInsets.zero : null,
            physics: (widget.isBorder == true)
                ? NeverScrollableScrollPhysics()
                : null,
            isScrollable: (widget.isBorder == true) ? true : false,

            indicatorColor: (widget.isBorder == true)
                ? Colors.transparent
                : widget.indicatorColor,
            labelColor: widget.labelColor,
            unselectedLabelColor: widget.unselectedLabelColor,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              for (int i = 0; i < ll.length; i++) ...[
                Container(
                  padding: (widget.isBorder == true)
                      ? EdgeInsets.fromLTRB(
                          widget.gapBetweenTabs, 0, widget.gapBetweenTabs, 0)
                      : null,
                  decoration: (widget.isBorder == true)
                      ? BoxDecoration(
                          borderRadius: (widget.onlyTopBorderRadius != null)
                              ? BorderRadius.only(
                                  topRight: Radius.circular(
                                      widget.onlyTopBorderRadius),
                                  topLeft: Radius.circular(
                                      widget.onlyTopBorderRadius),
                                )
                              : (widget.borderRadius != null)
                                  ? BorderRadius.circular(widget.borderRadius)
                                  : null,
                          border: (i != val)
                              ? Border.all(color: Colors.black, width: 1)
                              : null,
                        )
                      : null,
                  child: Tab(
                    icon: Text(ll[i]),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
