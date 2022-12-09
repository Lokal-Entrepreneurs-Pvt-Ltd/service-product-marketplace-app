import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';
import '../UikIcon/uikIcon.dart';

class ProductDetails extends StatelessWidget {
  String productName;
  String productCategory;
  String description;
  int price;
  int size;
  int rating;
  String ratingVal;
  int stock;
  String skuVal;
  final productImage;
  List<String>? tags;

  ProductDetails({
    super.key,
    this.productName = 'Nike Air Max 270',
    this.productCategory = 'Rave BD',
    this.description = "Built for natural motion, the flex and motion",
    this.price = 450,
    this.size = 7,
    this.rating = 4,
    this.ratingVal = '4(10)',
    this.stock = 45,
    this.skuVal = 'UY2345',
    this.productImage = "/images/blue.png",
    this.tags = const ['Apple', 'Nike', 'Sneakers'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      decoration: BoxDecoration(border: Border.all(color: Color(0xffBABFC5))),
      width: 1121,
      // height: 261,
      child: ListView(shrinkWrap: true, children: [
        Card(
          margin: EdgeInsets.all(0),
          elevation: 10,
          shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //first row
              Container(
                // color: Colors.deepPurple,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: 147,
                      margin: const EdgeInsets.only(left: 30, top: 30),
                      child: Text(
                        productName,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    // SizedBox(width: 870),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(top: 28, right: 33),
                      child: UikIcon(
                        iconColor: Color(0xff212121),
                        valIcon: Icons.edit_outlined,
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xffFEE440),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    )
                  ],
                ),
              ),

              // 2nd row
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    //c-1
                    Container(
                      margin: EdgeInsets.only(
                        left: 30,
                      ),
                      width: 80,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xffF5F5F5),
                        // color: Colors.amber,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Image.asset(productImage),
                    ),

                    //c-2
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      // color: Colors.amber,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.pink,
                            margin: EdgeInsets.only(left: 16),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    productName,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    productCategory,
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff82868C),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Spacer(),

                          Container(
                            margin: EdgeInsets.only(left: 110),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Description:',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: 142,
                                  child: Text(
                                    description,
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff82868C),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Spacer(),

                          Container(
                            margin: EdgeInsets.only(left: 96),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Price',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '\$' + price.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff82868C),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 140),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Size',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: 25,
                                  height: 19,
                                  padding: EdgeInsets.fromLTRB(9, 2, 9, 2),
                                  decoration: BoxDecoration(
                                      color: Color(0xff9E9E9E),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Text(
                                    size.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffffffff)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 92),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Rating',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.only(left: 63),
                                        // width: 96,
                                        // color: Colors.blue,
                                        height: 18,
                                        child: Row(children: <Widget>[
                                          RatingBar.builder(
                                            initialRating: rating.toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 18,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        constraints: const BoxConstraints(
                                            maxWidth: double.infinity,
                                            minWidth: 0.0),
                                        height: 16,
                                        child: Text(
                                          ratingVal,
                                          style: GoogleFonts.poppins(
                                              color: const Color(0xff9E9E9E),
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 3rd row
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 30),
                child: Row(
                  children: [
                    //stock container
                    Container(
                      margin: EdgeInsets.only(left: 353),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Stock',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              stock.toString(),
                              style: GoogleFonts.poppins(
                                  color: Color(0xff82868C),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),

                    //sku container
                    Container(
                      margin: EdgeInsets.only(left: 199),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Sku:',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              skuVal,
                              style: GoogleFonts.poppins(
                                  color: Color(0xff82868C),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),

                    //tags container
                    Container(
                      margin: EdgeInsets.only(left: 125),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Tags',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            // height: 25,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (var i = 0; i < tags!.length; i++)
                                  Container(
                                    margin: EdgeInsets.only(right: 8, top: 4),
                                    width: 68,
                                    height: 23,
                                    padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
                                    decoration: BoxDecoration(
                                        color: Color(0xff9E9E9E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      tags![i].toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffffffff)),
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
