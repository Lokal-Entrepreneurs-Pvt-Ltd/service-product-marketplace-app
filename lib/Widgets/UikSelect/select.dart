// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MySelect extends StatefulWidget {
  final Corner;
  final Border;
  final Disable;
  final avtar;
  final Heading;
  final noIcon;
  final size;

  const MySelect(
      {this.Corner = "Recktangle",
      this.Border = false,
      this.Disable = false,
      this.avtar,
      this.Heading = false,
      this.noIcon = false,
      this.size});

  @override
  State<MySelect> createState() => _MySelectState();
}

class _MySelectState extends State<MySelect> {
  // String dropdownValue = 'One';
  var ContainerHeight = 41.0;
  var ContainerRadius = 0.0;
  var ContainerBorderColor = Colors.white;
  var ContainerBackgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    if (widget.size == "Small") ContainerHeight = 31.0;
    if (widget.size == "Large") ContainerHeight = 51.0;
    if (widget.Border == true) ContainerBorderColor = Color(0xFF9E9E9E);
    if (widget.Corner == "Recktangle") ContainerRadius = 8.0;
    if (widget.Corner == "Rounded") ContainerRadius = 30.0;
    if (widget.Disable == true) ContainerBackgroundColor = Color(0xFFE5E5E5);

    return Scaffold(
      // Outer Container 1 with Label
      body: AbsorbPointer(
        absorbing: widget.Disable,
        child: Container(
          height: 200,
          child: Column(
            children: [
              if (widget.Heading)
                Container(
                  width: 200,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text(
                        "LABEL",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: 17,
              ),
              // Select Box Container
              Container(
                width: 200,
                height: ContainerHeight,
                // color: Color(0xFF9E9E9E),
                decoration: BoxDecoration(
                  border: Border.all(color: ContainerBorderColor),
                  color: ContainerBackgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(ContainerRadius)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 11),
                    if (widget.noIcon == false)
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
                            border:
                                Border.all(color: ContainerBackgroundColor)),
                      ),
                    if (widget.noIcon == false) SizedBox(width: 11),
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
                          border: Border.all(color: ContainerBackgroundColor)),
                    ),
                    Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          child: Icon(
                            Icons.expand_more_outlined,
                            color: Color(0xFF9E9E9E),
                          ),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: ContainerBackgroundColor)),
                        ),
                      ),
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
      ),
    );
  }
}
