import 'package:flutter/material.dart';
import 'UikPagination.dart';
import './pages/page1.dart';
import './pages/page2.dart';
import './pages/page3.dart';
import './pages/page4.dart';

class Mypagination extends StatelessWidget {
  // const Mypagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pagination(
        boxheight: 400,
        pages: [Page1(), Page2(), Page3(), Page4()],
        ActiveDotColor: Color(0xff212121),
        dotcolor: Color(0xffe0e0e0),
        DotHeight: 5,
        DotWidth: 5,
        DotRadius: 2.5,
        spacing: 4,
        expansionFactor: 2.2,
      ),
    );
  }
}
