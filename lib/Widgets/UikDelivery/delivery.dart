

import 'package:flutter/material.dart';



class Delivery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: const Text("delivery addess",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )),
                        );
  }
}