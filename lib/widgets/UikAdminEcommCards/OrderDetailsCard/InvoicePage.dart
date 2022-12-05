import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAdminEcommCards/OrderDetailsCard/ProductPage.dart';

class InvoicePage extends ProductPage {
  final img;
  String productName, productDesc, productId, location, date;
  double subtotalVal, totalVal, discountVal, VATval;

  InvoicePage({
    Key? key,
    this.img = "/images/Rectangle455.png",
    this.productName = 'Nike Airmax 270',
    this.productDesc = 'Rave BD',
    this.productId = 'UX2435',
    this.location = 'Arizona,USA',
    this.date = '02-12-2021',
    this.subtotalVal = 428.00,
    this.totalVal = 450.00,
    this.discountVal = 8.00,
    this.VATval = 20.00,
  }) : super(key: key);

  List<Product> products = [
    Product(
        productName: 'Nike AirMax 270', price: 700, quantity: 10, total: 7085),
    Product(
        productName: 'Nike AirMax 270', price: 750, quantity: 6, total: 2435),
    Product(
        productName: 'Nike AirMax 270', price: 750, quantity: 6, total: 2435),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25, left: 30),
            child: const Text(
              'Invoice',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff212121)),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 24, top: 19),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffbdbdbd), width: 1.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                size: 16.5,
                Icons.edit_outlined,
                color: Color(0xff9e9e9e),
              ),
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30, top: 11, right: 15),
                child: Image.asset(img),
              ),
              Container(
                // color: Colors.amber,
                // margin: EdgeInsets.only(top: 115),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3A3C40)),
                    ),
                    Text(
                      productDesc,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff82868C)),
                    ),
                    Text(
                      productId,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff82868C)),
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff82868C)),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30, right: 32),
            child: Text(
              'Date:' + date,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff3A3C40),
              ),
            ),
          )
        ],
      ),
      Container(
        // color: Colors.black,
        margin: const EdgeInsets.only(top: 40, left: 30, bottom: 12, right: 30),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 424,
              // margin: const EdgeInsets.only(right: 477),
              child: const Text(
                'Product',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              width: 212,
              // margin: const EdgeInsets.only(right: 198),
              child: const Text(
                'Price',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              width: 212,
              // margin: const EdgeInsets.only(right: 199),
              child: const Text(
                'Quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              width: 212,
              // margin: EdgeInsets.only(right: 30),
              child: const Text(
                'Total',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff9E9E9E)),
              ),
            )
          ],
        ),
      ),
      for (var i = 0; i < products.length; i++)
        Container(
          // height: 200,
          child: Column(
            children: [
              const Divider(
                height: 1,
                color: Color(0xffBDBDBD),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: 50,
                child: Row(
                  children: [
                    Container(
                      width: 424,
                      child: Text(
                        products[i].productName,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 422),
                      width: 212,
                      child: Text(
                        '\$' + products[i].price.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 212,
                      // margin: const EdgeInsets.only(left: 222),
                      child: Text(
                        products[i].quantity.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 212,
                      // margin: const EdgeInsets.only(left: 222),
                      child: Text(
                        '\$' + products[i].total.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 31, top: 35, bottom: 35),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            'Discount',
                            style: TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            'VAT',
                            style: TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.amber,
                      margin: EdgeInsets.only(right: 31),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$' + subtotalVal.toString(),
                            style: const TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            '-\$' + discountVal.toString(),
                            style: const TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            '\$' + VATval.toString(),
                            style: const TextStyle(
                                color: Color(0xff9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 215,
                  margin: EdgeInsets.only(top: 18, right: 30),
                  child: const Divider(
                    height: 1,
                    color: Color(0xffBABFC5),
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.only(right: 30, top: 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 137,
                      ),
                      Text(
                        '\$' + totalVal.toString(),
                        style: const TextStyle(
                            color: Color(0xff212121),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
