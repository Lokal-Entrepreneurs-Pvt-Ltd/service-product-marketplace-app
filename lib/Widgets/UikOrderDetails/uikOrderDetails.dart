import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/UikImage/uikImage.dart';


class OrderDetails extends StatelessWidget {
  final listOfImages;
  final marginTop;
  final leftTitle;
  final rightTitle;
  final leftSubtitle;
  final rightSubtitle;
  final leftSubtitleColor;

  OrderDetails({
    this.leftSubtitleColor = Colors.green,
    this.leftSubtitle,
    @required this.rightTitle,
    this.rightSubtitle,
    @required this.leftTitle,
    this.marginTop = 24.0,
    @required this.listOfImages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: marginTop,
        ),
        child: Column(
          children: [
            //................Two Text.....................

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //width: 270,
                  height: 24.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    // top: 24,
                    // right: 8,
                  ),
                  child: Text(
                    leftTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(
                        0xFF212121,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 8,
                // ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  margin: const EdgeInsets.only(
                    right: 40.0,
                    //   top: 24,
                  ),
                  child: Text(
                    rightTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        0xFF212121,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //................Two Text(second).....................

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //width: 270,
                  height: 24.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    top: 2.0,
                    // right: 8,
                  ),
                  child: Text(
                    (leftSubtitle != null) ? leftSubtitle : "",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: leftSubtitleColor,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 8,
                // ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  margin: const EdgeInsets.only(
                    right: 40.0,
                    top: 2.0,
                  ),
                  child: Text(
                    (rightSubtitle != null) ? rightSubtitle : "",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(
                        0xFF9E9E9E,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //..........Two Images................................
            Row(
              children: [
                for (int i = 0; i < listOfImages.length; i++) ...[
                  Container(
                    margin: EdgeInsets.only(
                      left: (i == 0) ? 16.0 : 0.0,
                      top: 16.0,
                      right: 12.0,
                    ),
                    child: UikImage(
                      valImage: Image.asset(listOfImages[i]).image,
                      iHeight: 73.0,
                      iWidth: 60.0,
                    ),
                  ),
                ]
              ],
            ),
          ],
        ));
  }
}
