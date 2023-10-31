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
      {super.key, this.Corner = "Recktangle",
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
    if (widget.Border == true) ContainerBorderColor = const Color(0xFF9E9E9E);
    if (widget.Corner == "Recktangle") ContainerRadius = 8.0;
    if (widget.Corner == "Rounded") ContainerRadius = 30.0;
    if (widget.Disable == true) ContainerBackgroundColor = const Color(0xFFE5E5E5);

    return Scaffold(
      // Outer Container 1 with Label
      body: AbsorbPointer(
        absorbing: widget.Disable,
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              if (widget.Heading)
                SizedBox(
                  width: 200,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: const Text(
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
              const SizedBox(
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
                    const SizedBox(width: 11),
                    if (widget.noIcon == false)
                      Container(
                        child: widget.avtar ?? Container(
                                height: 13.0,
                                width: 13.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9E9E9E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ContainerBackgroundColor)),
                      ),
                    if (widget.noIcon == false) const SizedBox(width: 11),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ContainerBackgroundColor)),
                      child: const SizedBox(
                        width: 41,
                        height: 16,
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: ContainerBackgroundColor)),
                          child: const Icon(
                            Icons.expand_more_outlined,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
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
