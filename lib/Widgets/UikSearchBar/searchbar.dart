import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";

import '../../widgets/UikIcon/uikIcon.dart';
// import 'package:login/Widgets/UikiIcon/uikIcon.dart';

class MySearchBar extends StatefulWidget {
  final rightElement;
  final label;
  final borderColor;
  final iconColor;
  MySearchBar(
      {this.rightElement,
      this.label = "Search",
      this.borderColor,
      this.iconColor});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar>
    with SingleTickerProviderStateMixin {
  int hastype = 0;
  late AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: 343,
          height: 64,
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          // margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F5F5),
          ),
          // height: 200,
          child: Row(
            children: [
              if (hastype > 0) ...[
                Container(
                  // padding: EdgeInsets.fromLTRB(19, 23, 23, 0),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: controller,
                    color: Colors.black,
                  ),
                ),
              ],
              if (hastype == 0)
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                  child: UikIcon(
                    valIcon: Icons.search,
                    iconColor: widget.iconColor,
                  ),
                ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 2),
                  child: TextField(
                    decoration: new InputDecoration.collapsed(
                      hintText: widget.label,
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (text) {
                      setState(() {
                        hastype = text.length;
                        controller.forward();
                      });
                    },
                  ),
                ),
              ),
              if (widget.rightElement != null)
                Container(
                  child: UikIcon(valIcon: widget.rightElement),
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 2),
                )
            ],
          ),
        ),
      ),
    );
  }
}
