import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikImage/uikImage.dart';

class RowCard extends StatelessWidget {
  final widthSize;
  final heightSize;
  final text;
  final imgVal;
  RowCard(
      {this.widthSize = 88,
      this.heightSize = 88,
      this.imgVal,
      this.text = "best of 2020"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: heightSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
              child: UikImage(
                valImage: imgVal, //Image.asset("assets/images/pic.png").image,
               iFit: BoxFit.fitHeight,
              ),
            ),
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                text,
                style: TextStyle(color: Colors.white,fontFamily: 'Poppins-ExtraLight'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
