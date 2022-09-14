import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/widgets/UikImage/uikImage.dart';

class ColumnCard extends StatelessWidget {
  final widthSize;
  final heightSize;
  final iWidth;
  final imgVal;
  final text;
  const ColumnCard(
      {this.widthSize = 343,
      this.heightSize = 100,
      this.iWidth = 82,
      this.imgVal,
      this.text = "ISP"});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffF5F5F5), borderRadius: BorderRadius.circular(8)),
      width: widthSize,
      height: heightSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 0, 52),
            //color: Colors.amber,
            width: 229,
            height: 32,
            child: Text(
              text,
              style: TextStyle(fontSize: 24,fontFamily: 'Poppins',fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: iWidth,
            height: heightSize,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),topRight: Radius.circular(8),),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: UikImage(
                  valImage: imgVal, //Image.asset("assets/images/pic.png").image,
                  iFit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
