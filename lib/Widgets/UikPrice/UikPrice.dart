import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/pages/UikBottomNavigationBar.dart';

class Price extends StatelessWidget {
  const Price({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        children: [
          const Text(
            "₹",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const Text(
            "5000",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          const Text(
            "/year",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          SizedBox(
            height: 41,
            width: 101,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UikBottomNavigationBar(),
                  ),
                );
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.fromWidth(100)),
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#FEE440"))),
              child: Text(
                "Pay Now",
                style: TextStyle(
                  color: HexColor("#212121"),
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
