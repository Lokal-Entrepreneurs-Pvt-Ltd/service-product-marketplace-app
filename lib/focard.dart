import 'package:flutter/material.dart';

import './uik_text.dart';

class FoDashboardCard extends StatelessWidget {

  final int tickets;
  final int closed;
  final int responsesAwaited;

  FoDashboardCard({
   required this.tickets,
    required this.closed,
    required this.responsesAwaited,
});

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
                  UikText(size: 32, text: tickets.toString(), weight: FontWeight.w500, color: Color(0xFFE57373)),
                  SizedBox(width: 290,),
                  UikText(size: 32, text: closed.toString(), weight: FontWeight.w500, color: Color(0xFF81C784)),
                ],
              ),

              Align(
                heightFactor: 0,
                child: Row(
                  children: [
                    UikText(size: 18, text: 'Tickets', weight: FontWeight.w500, color: Color(0xFF9E9E9E)),
                    SizedBox(width: 210.0),
                    UikText(size: 18, text: 'Closed', weight: FontWeight.w500, color: Color(0xFF81C784)),
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
                      value: 1.0,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  UikText(size: 12, text: 'Response Awaited', weight: FontWeight.w400, color: Color(0xFFE57373)),
                  SizedBox(width: 200.0),
                  UikText(size: 12, text: responsesAwaited.toString(), weight: FontWeight.w400, color: Color(0xFFBDBDBD)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
