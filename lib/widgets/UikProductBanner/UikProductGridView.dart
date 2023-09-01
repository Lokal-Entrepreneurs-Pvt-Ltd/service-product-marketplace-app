import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProductCard extends StatelessWidget {
  final productImg;
  final productName;
  final productPrice;
  final ratingValue;
  final reviewText;

  const MyProductCard({
    super.key,
    this.productImg,
    this.productName,
    this.productPrice,
    this.ratingValue,
    this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            margin: const EdgeInsets.all(0.0),
            child: Container(
              // color: Colors.amber,
              // constraints: BoxConstraints(maxWidth: double.infinity),
              width: MediaQuery.of(context).size.width * 0.5,
              // width: 155,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                          // color: Colors.brown,
                          image: DecorationImage(
                        image: productImg,
                        fit: BoxFit.fill,
                      )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.blue,
                          constraints: const BoxConstraints(
                              maxHeight: double.infinity,
                              minHeight: 0.0,
                              maxWidth: double.infinity,
                              minWidth: 0.0),
                          child: Text(
                            productName,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          // color: Colors.blueGrey,
                          constraints: const BoxConstraints(
                              maxHeight: double.infinity,
                              minHeight: 0.0,
                              maxWidth: double.infinity,
                              minWidth: 0.0),
                          child: Text(
                            productPrice,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12.5),
                          // color: Colors.brown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.black,
                                // width: 9.17,
                                // height: 8.72,
                                child: const Icon(
                                  size: 10,
                                  Icons.star,
                                  color: Color(0xffFFC120),
                                ),
                              ),
                              const SizedBox(
                                width: 3.91,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 0.92),
                                child: Text(
                                  ratingValue,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      // textStyle: Theme.of(context).textTheme.bodyMedium,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 0.92),
                                child: Text(
                                  reviewText,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                // color: 
                                // Colors.amber,
                                // width: 18,
                                height: 22,
                                child: const Icon(
                                  size: 18,
                                  color: Color(0xff7f7f7f),
                                  Icons.more_vert,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
            )),
      ],
    );
  }
}
