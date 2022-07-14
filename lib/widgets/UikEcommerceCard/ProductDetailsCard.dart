import "package:flutter/material.dart";
import 'package:login/widgets/UikiIcon/uikIcon.dart';

import '../UikButton/UikButton.dart';

class ProductDetailsCard extends StatefulWidget {
  const ProductDetailsCard({Key? key}) : super(key: key);

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  var colorOfSizeSmall = 0xFF212121;
  var colorOfSizeMedium = 0xFF212121;
  var colorOfSizeLarge = 0xFF212121;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 751,
          height: 519,
          child: Card(
            child: Container(
              child: Row(
                children: [
                  //first half part three images........................
                  Container(
                    // decoration: BoxDecoration(
                    //   // color: backgroundColor,
                    //   borderRadius: BorderRadius.circular(7),
                    //   border: Border.all(color: Colors.black, width: 1.0),
                    // ),
                    child: Column(
                      children: [
                        //for first large image
                        Container(
                          width: 265,
                          height: 294,
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 30,
                            bottom: 8,
                          ),
                          child:
                              Image.asset("assets/images/Rectangle 2943.png"),
                        ),
                        //for three smaller images
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 83,
                                height: 71,
                                margin: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Image.asset(
                                    "assets/images/Rectangle 2944.png"),
                              ),
                              Container(
                                width: 83,
                                height: 71,
                                margin: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Image.asset(
                                    "assets/images/Rectangle 2945.png"),
                              ),
                              Container(
                                width: 83,
                                height: 71,
                                margin: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Image.asset(
                                    "assets/images/Rectangle 2946.png"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //the other half part....................................
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //for heading of the product
                        Container(
                          margin: const EdgeInsets.only(
                            left: 39,
                            top: 57,
                          ),
                          child: const Text(
                            "Lamp Light",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ),

                        //for small description of the product
                        Container(
                          margin: const EdgeInsets.only(
                            left: 41,
                            top: 7,
                          ),
                          child: const Text(
                            "Build for natural motion, the flex and motion",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),

                        //for size small medium and big
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 41,
                                  top: 26,
                                ),
                                child: const Text(
                                  "Size:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF212121),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  top: 26,
                                ),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Text(
                                      "Small",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(colorOfSizeSmall),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          colorOfSizeSmall = 0xFFE57373;
                                          colorOfSizeLarge = 0xFF212121;
                                          colorOfSizeMedium = 0xFF212121;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  top: 26,
                                ),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Text(
                                      "Medium",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(colorOfSizeMedium),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          colorOfSizeMedium = 0xFFE57373;
                                          colorOfSizeSmall = 0xFF212121;
                                          colorOfSizeLarge = 0xFF212121;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  top: 26,
                                ),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Text(
                                      "Big",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(colorOfSizeLarge),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          colorOfSizeLarge = 0xFFE57373;
                                          colorOfSizeSmall = 0xFF212121;
                                          colorOfSizeMedium = 0xFF212121;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //container for price
                        Container(
                          margin: const EdgeInsets.only(
                            left: 41,
                            top: 30,
                          ),
                          child: Text(
                            "215",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(
                                0xFF212121,
                              ),
                            ),
                          ),
                        ),

                        //container for button and icon
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 136,
                                child: AppButton(
                                  text: "Add Products",
                                  trailingIcon: const UikIcon(
                                    valIcon: Icons.add,
                                  ),
                                ),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
