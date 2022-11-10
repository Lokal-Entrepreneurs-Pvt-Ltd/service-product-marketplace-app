import "package:flutter/material.dart";
import 'package:login/widgets/UikiIcon/uikIcon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../UikAvatar/uikAvatar.dart';
import '../UikButton/UikButton.dart';

class ProductDetailsCard extends StatefulWidget {
  final productName;
  final productPrice;

  ProductDetailsCard({
    this.productName = "Lamp Light",
    this.productPrice = "215",
  });

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
          height: 550,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //for heading of the product
                        Container(
                          margin: const EdgeInsets.only(
                            left: 39,
                            top: 57,
                          ),
                          child: Text(
                            widget.productName,
                            style: const TextStyle(
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
                            widget.productPrice,
                            style: const TextStyle(
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
                                margin: const EdgeInsets.only(
                                  left: 45,
                                  top: 13.5,
                                ),
                                width: 136,
                                child: UikButton(
                                  text: "Add Products",
                                  stuck: true,
                                  rightElement: const UikIcon(
                                    valIcon: Icons.add,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 14,
                                  top: 13.5,
                                ),
                                child: const UikIcon(
                                  valIcon: Icons.favorite,
                                  borderColor: Colors.black,
                                  backgroundColor: Color(0xFFEEEEEE),
                                  rad: 180.0,
                                  iconSize: 30.0,
                                  padding: EdgeInsets.all(10),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //description and icon ...................
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 41,
                                  top: 28.5,
                                  right: 279.6,
                                ),
                                child: const Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFF212121,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 31.67,
                                ),
                                child: UikIcon(
                                  valIcon: Icons.arrow_drop_down,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //divider.....................................
                        Container(
                          width: 369,
                          margin: const EdgeInsets.only(
                            left: 41,
                            top: 8,
                          ),
                          child: const Divider(
                            thickness: 1,
                            color: Color(
                              0xFFBDBDBD,
                            ),
                          ),
                        ),

                        //Reviews and icons.............................
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 41,
                                  top: 18,
                                  right: 11,
                                ),
                                child: const Text(
                                  "Reviews",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFF212121,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 18,
                                  right: 264.66,
                                ),
                                child: const Text(
                                  "(12)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFF9E9E9E,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 18,
                                ),
                                child: UikIcon(
                                  valIcon: Icons.arrow_drop_down,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Avatar ...................
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 14,
                                  left: 41,
                                ),
                                child: const UikAvatar(
                                  shape: UikAvatarShape.circle,
                                  size: UikSize.SMALL,
                                  backgroundImage: NetworkImage(
                                      "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 19,
                                  left: 8,
                                ),
                                child: const Text(
                                  "Lavesh Garg",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFF212121,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 27,
                                  left: 160,
                                ),
                                child: RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 18,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Description
                        Container(
                          margin: const EdgeInsets.only(
                            top: 14,
                            left: 41,
                            right: 26,
                          ),
                          child: const Text(
                            "Although the pan is good but it is not non-sticky which makes washing of this pan a headache",
                            //  softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),

                        Container(
                          width: 369,
                          margin: const EdgeInsets.only(
                            left: 41,
                            top: 8,
                          ),
                          child: const Divider(
                            thickness: 1,
                            color: Color(
                              0xFFBDBDBD,
                            ),
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
