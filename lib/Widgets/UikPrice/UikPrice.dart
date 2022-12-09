import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';

class Price extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        children: [
          Text(
            "₹",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          Text(
            "5000",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          Text(
            "/year",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 60,
          ),
          Container(
            height: 41,
            width: 101,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UikBottomNavigationBar(),
                  ),
                );
              },
              child: Text(
                "Pay Now",
                style: TextStyle(
                  color: HexColor("#212121"),
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size.fromWidth(100)),
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#FEE440"))),
            ),
          )
        ],
      ),
    );
  }
}
