import 'package:flutter/material.dart';

class orderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFEEB70),
        // backgroundColor: Colors.red,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.person_outline_sharp,
                  size: 30,
                ),
                SizedBox(
                  height: 32,
                  width: 343,
                  child: Center(
                    child: Text(
                      'your order is placed',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: 343,
                  child: Center(
                    child: Text(
                      'thanks for your order, we hope you\nenjoyed shopping with us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF9E9E9E),
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 16,
              right: 0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 343,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Color(0xFF212121), width: 2.0),
                  ),
                  child: const Center(
                      child: Text(
                    "Go to my orders",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
