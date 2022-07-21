import 'package:flutter/material.dart';

import './uik_text.dart';

class TDashboardCard extends StatelessWidget {

  final int sales;
  final int newOrders;

  TDashboardCard({
   required this.sales,
   required this.newOrders,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
                  UikText(size: 32, text: sales.toString(), weight: FontWeight.w500, color: Color(0xFF7986CB)),
                  SizedBox(width: 240.0,),
                  Icon(Icons.shopping_cart_sharp, color: Color(0xFF9FA8DA)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UikText(size: 18, text: 'Sales this month', weight: FontWeight.w500, color: Color(0xFF9E9E9E)),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 2.0,
                      color: Color(0xFF7986CB),
                      backgroundColor: Colors.grey,
                      value: 0.0,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  UikText(size: 12, text: 'New orders this month', weight: FontWeight.w400, color: Color(0xFF9E9E9E)),
                  SizedBox(width: 170.0),
                  UikText(size: 12, text: newOrders.toString(), weight: FontWeight.w400, color: Color(0xFF7986CB)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
