import "package:flutter/material.dart";

class Chips extends StatelessWidget {
  final text;
  final iconVal;
  final backgroundColor;
  final textColor;
  final iconColor;
  final avatar;

  Chips({
    required this.text,
    this.iconVal,
    this.iconColor,
    this.avatar,
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
            avatar: (avatar != null)
                ? CircleAvatar(
                    child: Icon(Icons.account_circle),
                  )
                : null,
            label: Text(text),
            elevation: 5,
            labelStyle: TextStyle(color: textColor, fontSize: 20),
            onDeleted: (iconVal != null) ? () {} : null,
            deleteIcon: (iconVal != null)
                ? Icon(
                    iconVal,
                    color: (iconColor != null) ? iconColor : Colors.white,
                  )
                : null,
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
            padding: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
