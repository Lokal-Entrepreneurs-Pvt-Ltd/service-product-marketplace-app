import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:login/widgets/UikiIcon/uikIcon.dart';

import 'help.dart';

class Lavesh extends StatefulWidget {
  final list;
  final bullet;
  final width;
  final height;
  Lavesh({
    required this.list,
    this.bullet,
    this.width = 358,
    this.height = 46,
  });
  @override
  State<Lavesh> createState() => _LaveshState();
}

class _LaveshState extends State<Lavesh> {
  var index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.white,
        width: widget.width,
        // decoration: BoxDecoration(border: Border.all(width: 3)),
        child: ListView(
          children: <Widget>[
            for (int i = 0; i < widget.list.length; i++)
              MouseRegion(
                onHover: (PointerHoverEvent event) {
                  //  print(event.position);
                  setState(() {
                    index = i;
                  });
                },
                onExit: (PointerExitEvent event) {
                  setState(() {
                    index = -1;
                  });
                },
                child: Container(
                  height: widget.height,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 3),
                  // ),
                  child: ListTile(
                    leading: (widget.list[i]["icon"] != null)
                        ? UikIcon(
                            valIcon: widget.list[i]["icon"],
                            iconColor:
                                (i == index) ? Colors.blue : Colors.black,
                          )
                        : (widget.bullet != null)
                            ? Container(
                                height: 12.0,
                                width: 12.0,
                                decoration: new BoxDecoration(
                                  color:
                                      (i == index) ? Colors.blue : Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                    title: Text(
                      widget.list[i]["text"],
                      style: TextStyle(fontSize: 15),
                    ),
                    textColor: (i == index) ? Colors.blue : Colors.black,
                    onTap: () {},
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
