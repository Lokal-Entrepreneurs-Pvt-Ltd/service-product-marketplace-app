import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
//import 'package:lokal/routes.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  // width height hint text border? border color, bg color
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(MyRoutes.searchScreen);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UikSearchCatalog().page,
          ),
        );
      },
      child: Container(
        // margin: const EdgeInsets.fromLTRB(14, 23, 14, 2),
        margin: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
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
              // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey,
                onPressed: () {},
              ),
            ),
            Flexible(
              child: Container(
                // margin: const EdgeInsets.fromLTRB(0, 0, 5, 2),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration.collapsed(
                    hintText: "Search",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
