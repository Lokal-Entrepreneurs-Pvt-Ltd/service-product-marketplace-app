import "package:flutter/material.dart";

class Chips extends StatelessWidget {
  final text;
  final backgroundColor;
  final textColor;
  final rightElement;
  final leftElement;

  const Chips({super.key, 
    required this.text,
    this.rightElement,
    this.leftElement,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          //alignment: Alignment.topCenter,
          //margin: EdgeInsets.only(top: 20),
          child: Chip(
            avatar: leftElement,
            label: Text(text),
            elevation: 5,
            labelStyle: TextStyle(color: textColor, fontSize: 20),
            onDeleted: (rightElement != null) ? () {} : null,
            deleteIcon: const Icon(Icons.close),
            backgroundColor:
                (backgroundColor != null) ? backgroundColor : Colors.white,
            //shape: StadiumBorder(side: BorderSide(color: Colors.black)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
