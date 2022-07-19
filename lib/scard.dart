import 'package:flutter/material.dart';

import './uik_text.dart';

class SDashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  UikText(size: 32, text: '262,180.00', weight: FontWeight.w500, color: Color(0xFF7986CB)),
                  SizedBox(width: 140.0,),
                  Icon(Icons.currency_rupee_sharp, color: Color(0xFFC5CAE9)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UikText(size: 18, text: 'Revenue[July, 2022]', weight: FontWeight.w500, color: Color(0xFF9E9E9E)),
                ],
              ),
                Container(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 2.0,
                      color: Colors.red,
                      backgroundColor: Colors.grey,
                      value: 0.0,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  UikText(size: 12, text: 'Change from June, 2022', weight: FontWeight.w400, color: Color(0xFF9E9E9E)),
                  SizedBox(width: 150.0),
                  UikText(size: 12, text: '-67%', weight: FontWeight.w400, color: Color(0xFFE57373)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
