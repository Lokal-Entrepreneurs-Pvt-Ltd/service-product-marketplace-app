import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UikButton/UikButton.dart';

class secondCard extends StatelessWidget {
  const secondCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Container(
        // height: 258,
        child: Column(
          children: [
            //2nd container - PRICE AND DISCOUNTED PRICE
            Container(
              margin: const EdgeInsets.only(top: 10, left: 30),
              child: Row(
                children: [
                  // PRICE-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Price',
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
                  // discounted price---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 119,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Discounted Price',
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

            //3RD CONTAINER - TAX INCLUDED AND TAX EXCLUDED
            Container(
              margin: const EdgeInsets.only(top: 22, left: 30),
              child: Row(
                children: [
                  // tax included-------------
                  Container(
                    margin: const EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Tax included Price',
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
                  // tax excluded price---------------
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 21,
                          margin: const EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Tax Excluded Price',
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

            // 4th container - buttons
            Container(
              width: 624,
              margin: const EdgeInsets.only(top: 26),
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
