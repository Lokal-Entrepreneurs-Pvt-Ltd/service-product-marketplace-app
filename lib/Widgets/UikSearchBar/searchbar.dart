import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  // width height hint text border? border color, bg color
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 23, 14, 2),
      width: MediaQuery.of(context).size.width,
      height: 48.0,
      color: Color(0xfff5f5f5),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey,
      //     width: 2,
      //   ),
      // ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 9, 0),
            child: IconButton(
              icon: Icon(Icons.search),
              color: Colors.grey,
              onPressed: () {},
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 2),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: "Search",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
