import 'package:flutter/material.dart';

import './uik_text.dart';

class FDashboardCard extends StatelessWidget {
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
                  UikText(size: 32, text: '391531', weight: FontWeight.w500, color: Color(0xFF5C6BC0)),
                  SizedBox(width: 130,),
                  UikText(size: 32, text: '38628', weight: FontWeight.w500, color: Color(0xFF81C784)),
                  ],
              ),

              Align(
                heightFactor: 0,
                child: Row(
                children: [
                  UikText(size: 18, text: 'Total Users', weight: FontWeight.w500, color: Color(0xFF9E9E9E)),
                  SizedBox(width: 120.0),
                  UikText(size: 18, text: 'Active Users', weight: FontWeight.w500, color: Color(0xFF81C784)),
                ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 2.0,
                      color: Colors.red,
                      backgroundColor: Colors.grey,
                      value: 0.3,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  UikText(size: 12, text: 'Total Users', weight: FontWeight.w400, color: Color(0xFFE57373)),
                  SizedBox(width: 220.0),
                  UikText(size: 12, text: '9229', weight: FontWeight.w400, color: Color(0xFFBDBDBD)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
