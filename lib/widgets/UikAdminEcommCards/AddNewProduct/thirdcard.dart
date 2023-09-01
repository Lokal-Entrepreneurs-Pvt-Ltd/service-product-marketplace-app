import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UikButton/UikButton.dart';

class thirdCard extends StatelessWidget {
  const thirdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Container(
        // height: 350,
        child: Column(
          children: [
            //2nd container - width and height
            Container(
              margin: const EdgeInsets.only(top: 14, left: 30),
              child: Row(
                children: [
                  // WIDTH -------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Width',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 34,
                          padding:
                              const EdgeInsets.only(left: 15, top: 11, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // height---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Height',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 34,
                          padding:
                              const EdgeInsets.only(left: 15, top: 10, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //3RD CONTAINER - depth and weight
            Container(
              margin: const EdgeInsets.only(top: 22, left: 30),
              child: Row(
                children: [
                  // depth-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 43,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Depth',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 34,
                          padding:
                              const EdgeInsets.only(left: 15, top: 11, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // weight---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 51,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Weight',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff212121),
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 34,
                          padding:
                              const EdgeInsets.only(left: 15, top: 10, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 129,
                    height: 21,
                    margin: const EdgeInsets.only(bottom: 11),
                    child: Text(
                      'Extra Shipping Fee',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff212121),
                          fontWeight: FontWeight.w500,
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  Container(
                    width: 623,
                    height: 34,
                    padding: const EdgeInsets.only(left: 15, top: 10, bottom: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xffEEEEEE),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 5th container - buttons
            Container(
              width: 624,
              margin: const EdgeInsets.only(top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UikButton(
                      textColor: const Color(0xff9E9E9E),
                      backgroundColor: const Color(0xffffffff),
                      borderColor: const Color(0xffEEEEEE),
                      text: 'Cancel',
                      widthSize: 136,
                      heightSize: 38),
                  const SizedBox(
                    width: 11,
                  ),
                  UikButton(
                      textColor: const Color(0xff212121),
                      backgroundColor: const Color(0xffFEE440),
                      borderColor: const Color(0xffFEE440),
                      text: 'Save',
                      widthSize: 136,
                      heightSize: 38)
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
