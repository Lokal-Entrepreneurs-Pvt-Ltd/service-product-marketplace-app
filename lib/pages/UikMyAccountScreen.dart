import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccount extends StatelessWidget {
  final List<Widget> ll;

  MyAccount({required this.ll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: 375,
            height: 114,
            child: Stack(
              children: [
                Positioned(
                  top: 56,
                  left: 16,
                  child: SizedBox(
                    width: 343,
                    height: 42,
                    child: Text(
                      "my account",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 32),
                    ),
                  ),
                ),
                const Positioned(
                  top: 18.28,
                  left: 337.28,
                  child: SizedBox(
                    width: 19.44,
                    height: 19.44,
                    child: Icon(Icons.settings),
                  ),
                )
              ],
            ),
          ),
          for (int i = 0; i < ll.length; i++) ...[
            ll[i],
          ]
        ],
      ),
    );
  }
}
