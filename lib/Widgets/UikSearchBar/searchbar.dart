import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:login/Widgets/UikiIcon/uikIcon.dart';

class MySearchBar extends StatefulWidget {
  final rightElement;
  final label;
  MySearchBar({this.rightElement, this.label});

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
      home: Scaffold(
        body: Container(
          width: 700,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 237, 233, 233),
          ),
          // height: 200,
          child: Row(
            children: [
              if (hastype > 0)
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: controller,
                    color: Colors.black,
                  ),
                ),
              if (hastype == 0)
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.search,
                  ),
                ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(5),
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
                Container(child: UikIcon(valIcon: widget.rightElement))
            ],
          ),
        ),
      ),
    );
  }
}
