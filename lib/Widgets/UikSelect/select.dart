// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MySelect extends StatefulWidget {
  final ContainerColor;
  final ContainerRadius;
  final ContainerHeight;
  final ContainerBackgroundColor;
  final avtar;
  final Heading;
  final noIcon;

  const MySelect(
      {this.ContainerColor = Colors.white,
      this.ContainerRadius = 8,
      this.ContainerHeight = 46,
      this.ContainerBackgroundColor = const Color(0xFFE5E5E5),
      this.avtar,
      this.Heading = false,
      this.noIcon = true});

  @override
  State<MySelect> createState() => _MySelectState();
}

class _MySelectState extends State<MySelect> {
  // String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        child: Column(
          children: [
            if (widget.Heading)
              Container(
                width: 200,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // width: 37,
                    // height: 16,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "LABLE",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: 17,
            ),
            Container(
              width: 200,
              height: widget.ContainerHeight,
              // color: Color(0xFF9E9E9E),
              decoration: BoxDecoration(
                border: Border.all(color: widget.ContainerColor),
                color: widget.ContainerBackgroundColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.ContainerRadius)),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 11),
                  if (widget.noIcon)
                    Container(
                      child: widget.avtar == null
                          ? Container(
                              height: 13.0,
                              width: 13.0,
                              decoration: new BoxDecoration(
                                color: Color(0xFF9E9E9E),
                                shape: BoxShape.circle,
                              ),
                            )
                          : widget.avtar,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.ContainerBackgroundColor)),
                    ),
                  if (widget.noIcon) SizedBox(width: 11),
                  Container(
                    child: Container(
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      width: 41,
                      height: 16,
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: widget.ContainerBackgroundColor)),
                  ),
                  Spacer(),
                  Container(
                    child: Icon(
                      Icons.expand_more_outlined,
                      color: Color(0xFF9E9E9E),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: widget.ContainerBackgroundColor)),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
