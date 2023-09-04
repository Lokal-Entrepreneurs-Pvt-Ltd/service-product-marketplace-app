import 'package:flutter/material.dart';
class Benifits extends StatelessWidget {
  String benifit ;
  Benifits(@required this.benifit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.check,
            color:Color.fromRGBO(33,33,33,1),
            size: 20,),
          const SizedBox(width: 10,),
          Text(benifit,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),)
        ],
      ),
    );
  }
}