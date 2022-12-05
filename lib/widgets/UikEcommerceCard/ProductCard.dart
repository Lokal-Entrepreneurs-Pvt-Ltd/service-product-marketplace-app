import "package:flutter/material.dart";
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

class ProductCard extends StatelessWidget {
  final productName;
  final productPrice;

  ProductCard({
    this.productName = "Nike airmax 170",
    this.productPrice = "215",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 240,
          height: 224,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 240,
                  height: 115,
                  decoration: const BoxDecoration(
                    color: Color(
                      0xFFF5F5F5,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/Mask Group@2x.png",
                  ),
                ),

                //Text icon Text..........................
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 43,
                        ),
                        child: Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 11,
                          right: 4,
                        ),
                        child: const UikIcon(
                          valIcon: Icons.star,
                          iconColor: Colors.yellow,
                          iconSize: 23.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 11,
                        ),
                        child: Text(
                          "(4.5)",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Text..................
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Rave BD",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),

                //Text icon icon...............
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 21,
                          top: 10,
                          right: 86,
                        ),
                        child: Text(
                          productPrice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 12,
                          top: 6,
                        ),
                        child: const UikIcon(
                          valIcon: Icons.favorite,
                          borderColor: Colors.black,
                          backgroundColor: Color(0xFFEEEEEE),
                          rad: 180.0,
                          iconSize: 20.0,
                          padding: EdgeInsets.all(7),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 6,
                        ),
                        child: const UikIcon(
                          valIcon: Icons.add,
                          borderColor: Colors.black,
                          backgroundColor: Colors.yellow,
                          rad: 180.0,
                          iconSize: 20.0,
                          padding: EdgeInsets.all(7),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
