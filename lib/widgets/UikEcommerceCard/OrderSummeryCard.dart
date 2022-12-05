import "package:flutter/material.dart";
import 'package:lokal/widgets/UikButton/UikButton.dart';

class OrderSummeryCard extends StatelessWidget {
  final subTotal;
  final discount;
  final shippingCost;
  OrderSummeryCard({
    this.subTotal = "dummy",
    this.discount = "dummy",
    this.shippingCost = "dummy",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 446,
          height: 485,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    left: 30,
                    bottom: 27,
                    right: 271,
                  ),
                  child: const Text(
                    "Order Summery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    bottom: 13,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 21,
                        margin: const EdgeInsets.only(
                          right: 295,
                        ),
                        child: const Text(
                          "SubTotal",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          subTotal,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    bottom: 13,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 21,
                        margin: const EdgeInsets.only(
                          right: 295,
                        ),
                        child: const Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          discount,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 97,
                        height: 21,
                        margin: const EdgeInsets.only(
                          right: 262,
                        ),
                        child: Text(
                          shippingCost,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "\$50",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 23,
                  ),
                  child: const Divider(
                    color: Color(
                      0xFFBDBDBD,
                    ),
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    bottom: 27,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 27,
                        margin: const EdgeInsets.only(
                          right: 295,
                        ),
                        child: const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "\$285",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFE57373),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 386,
                  height: 38,
                  margin: const EdgeInsets.only(
                    left: 30,
                    bottom: 42.8,
                  ),
                  child: UikButton(
                    text: "Proceed to payment",
                    // textColor: const Color(0xFF212121),
                  ),
                ),
                Container(
                  width: 189.98,
                  height: 113.12,
                  margin: const EdgeInsets.only(
                    left: 113.8,
                  ),
                  child: Image.asset('assets/images/Group.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
