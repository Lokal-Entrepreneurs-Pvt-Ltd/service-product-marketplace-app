import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import './uikIcon.dart';

class Icone extends StatelessWidget {
  const Icone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.black,
      child: Row(
        children: [
          UikIcon(
            valIcon: Icons.arrow_back,
            wid: 2,
            rad: 0,
            borderColor: Colors.black,
          ),
          UikIcon(
            valIcon: Icons.access_alarm,
            wid: 2,
            rad: 0,
            borderColor: Colors.black,
          ),
          UikIcon(
            valIcon: Icons.arrow_upward,
            wid: 2,
            rad: 0,
            borderColor: Colors.black,
          ),
          UikIcon(valIcon: Icons.access_alarm),
        ],
      ),
    );
  }
}
