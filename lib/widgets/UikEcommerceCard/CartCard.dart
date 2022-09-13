import "package:flutter/material.dart";
import 'package:login/widgets/UikAvatar/uikAvatar.dart';

class CartCard extends StatelessWidget {
  final productName;
  final productPrice;

  CartCard({
    this.productName = "lavesh",
    this.productPrice = "215",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 653,
          height: 147,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 25,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFF5F5F5),
                    radius: 45,
                    child: Image.asset("assets/images/blue 1.png"),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 38,
                        ),
                        child: Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
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
                        child: const Text(
                          "In stock",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9E9E9E),
                          ),
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
