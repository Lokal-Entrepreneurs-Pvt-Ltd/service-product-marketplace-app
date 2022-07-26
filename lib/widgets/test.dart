import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikInput.dart';

class PricingCard extends StatefulWidget {
  final widthVal;
  final heightVal;
  final depthVal;
  final weightVal;
  final shippingFee;

  const PricingCard(
      {super.key,
      this.depthVal,
      this.heightVal,
      this.shippingFee,
      this.weightVal,
      this.widthVal});

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  var colorOfInfo = 0xff3A3C40;
  var colorOfPrice = 0xff3A3C40;
  var colorOfShipping = 0xff3A3C40;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 683,
      height: 415,
      padding: EdgeInsets.fromLTRB(30, 0, 25, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffBABFC5)),
      ),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Column(
          children: [
            // top-most container (add new product, infor,price,shipping)
            Container(
              height: 67,
              // color: Colors.amber,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //add new product--------------
                  Container(
                    width: 210,
                    height: 32,
                    // margin: EdgeInsets.only(left: 30),
                    child: Text(
                      'Add new product',
                      style: GoogleFonts.poppins(
                        color: Color(0xff000000),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        textStyle: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 165,
                  ),

                  //for information, price and shipping-------------------
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // container for information
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    colorOfInfo = 0xffEF5350;
                                    colorOfPrice = 0xff3A3C40;
                                    colorOfShipping = 0xff3A3C40;
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Information',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color(colorOfInfo),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // divider(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //container for price
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    colorOfPrice = 0xffEF5350;
                                    colorOfShipping = 0xff3A3C40;
                                    colorOfInfo = 0xff3A3C40;
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Price',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color(colorOfPrice),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //container for shipping
                        Container(
                          // margin: EdgeInsets.only(right: 10),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    colorOfShipping = 0xffEF5350;
                                    colorOfInfo = 0xff3A3C40;
                                    colorOfPrice = 0xff3A3C40;
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Shipping',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color(colorOfShipping),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            //2nd container - width and height
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  // WIDTH -------------
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 21,
                          margin: EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Width',
                            style: GoogleFonts.poppins(
                                color: Color(0xff212121),
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
                              EdgeInsets.only(left: 15, top: 11, bottom: 8),
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
                          margin: EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Height',
                            style: GoogleFonts.poppins(
                                color: Color(0xff212121),
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
                              EdgeInsets.only(left: 15, top: 10, bottom: 8),
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
              margin: EdgeInsets.only(top: 22),
              child: Row(
                children: [
                  // depth-------------
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 43,
                          height: 21,
                          margin: EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Depth',
                            style: GoogleFonts.poppins(
                                color: Color(0xff212121),
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
                              EdgeInsets.only(left: 15, top: 11, bottom: 8),
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
                          margin: EdgeInsets.only(bottom: 11),
                          child: Text(
                            'Weight',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.w500,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 34,
                          padding:
                              EdgeInsets.only(left: 15, top: 10, bottom: 8),
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
              margin: EdgeInsets.only(top: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 129,
                    height: 21,
                    margin: EdgeInsets.only(bottom: 11),
                    child: Text(
                      'Extra Shipping Fee',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w500,
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  Container(
                    width: 623,
                    height: 34,
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 8),
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
              margin: EdgeInsets.only(top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppButton(
                  //     textColor: Color(0xff9E9E9E),
                  //     backgroundColor: Color(0xffffffff),
                  //     borderColor: Color(0xffEEEEEE),
                  //     text: 'Cancel',
                  //     widthSize: 136,
                  //     heightSize: 38),
                  // SizedBox(
                  //   width: 11,
                  // ),
                  // AppButton(
                  //     textColor: Color(0xff212121),
                  //     backgroundColor: Color(0xffFEE440),
                  //     borderColor: Color(0xffFEE440),
                  //     text: 'Save',
                  //     widthSize: 136,
                  //     heightSize: 38)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
