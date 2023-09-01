import "package:flutter/material.dart";
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

import '../UikButton/UikButton.dart';

class PaymentSuccessCard extends StatelessWidget {
  const PaymentSuccessCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1121,
          height: 428,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 101,
                    bottom: 17,
                  ),
                  child: const UikIcon(
                    valIcon: Icons.check,
                    rad: 180.0,
                    backgroundColor: Colors.yellow,
                    iconSize: 72.0,
                    iconColor: Colors.white,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Success",
                    style: TextStyle(
                      color: Color(0xFF223263),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 38,
                  ),
                  child: const Text(
                    "thank you for shopping using Lokal",
                    style: TextStyle(
                      color: Color(0xFF223263),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 271,
                  height: 38,
                  child: UikButton(
                    text: "Back to order",
                    //textColor: const Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
