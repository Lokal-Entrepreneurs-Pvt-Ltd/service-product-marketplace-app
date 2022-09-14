import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikIcon/uikIcon.dart';

class MembershipCard extends StatelessWidget {
  final text;
  final desText;
  final price;
  final duration;
  final List<String> perks;
  MembershipCard({
    this.text = "Lokal Membership",
    this.desText = "Block Level",
    this.price = 5000,
    this.duration = "year",
    required this.perks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 337,
          height: 395,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFFFC107),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 337,
                height: 192.38,
                decoration: const BoxDecoration(
                  color: Color(
                    0xFFFFC107,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                //color: Color(0xFFFFC107),
                padding: EdgeInsets.fromLTRB(27.0, 24.0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      desText,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Row(
                      children: [
                        const Text(
                          "₹ ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          price.toString(),
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "/" + duration,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        UikButton(
                          type: "primary",
                          backgroundColor: Color(0xFF5C6BC0),
                          text: "See Details",
                          heightSize: 34,
                          widthSize: 111,
                          textColor: Color(0xFFFFFFFF),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 337,
                    height: 150,
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(25.07, 31, 0, 0),
                    child: ListView(
                      children: [
                        for (int i = 0; i < 3; i++) ...[
                          Row(
                            children: [
                              UikIcon(
                                valIcon: Icons.check,
                              ),
                              SizedBox(
                                width: 16.07,
                              ),
                              Text(perks[i]),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 55),
                    child: UikButton(
                      text: "View All >",
                      widthSize: 75,
                      heightSize: 24,
                      textColor: Color(0xff5C6BC0),
                      backgroundColor: Color(0xffFFFFFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
