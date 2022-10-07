import 'package:flutter/material.dart';
class Benifits extends StatelessWidget {
  String benifit ;
  Benifits(@required this.benifit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.check,
            color:Color.fromRGBO(33,33,33,1),
            size: 20,),
          SizedBox(width: 10,),
          Text(benifit,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),)
        ],
      ),
    );
  }
}