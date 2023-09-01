
import 'package:flutter/material.dart';

class Product {
  String productName;
  int price, quantity, total;

  Product({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.total,
  });
}

List<Product> products = [
  Product(
      productName: 'Nike AirMax 270', price: 700, quantity: 10, total: 7085),
  Product(productName: 'Nike AirMax 270', price: 750, quantity: 6, total: 2435),
  Product(productName: 'Nike AirMax 270', price: 750, quantity: 6, total: 2435),
];

class ProductPage extends StatelessWidget {
  // final orderId;

  const ProductPage({
    super.key,
    // this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Container(
        // height: 600,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 29, left: 30),
                  child: const Text(
                    'Products',
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
                    border:
                        Border.all(color: const Color(0xffbdbdbd), width: 1.0),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      size: 16.5,
                      Icons.edit_outlined,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                )
              ],
            ),
            Container(
              // color: Colors.black,
              margin: const EdgeInsets.only(
                  top: 20, left: 30, bottom: 12, right: 30),
              child: const Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 424,
                    // margin: const EdgeInsets.only(right: 477),
                    child: Text(
                      'Product',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9E9E9E)),
                    ),
                  ),
                  SizedBox(
                    width: 212,
                    // margin: const EdgeInsets.only(right: 198),
                    child: Text(
                      'Price',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9E9E9E)),
                    ),
                  ),
                  SizedBox(
                    width: 212,
                    // margin: const EdgeInsets.only(right: 199),
                    child: Text(
                      'Quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9E9E9E)),
                    ),
                  ),
                  SizedBox(
                    width: 212,
                    // margin: EdgeInsets.only(right: 30),
                    child: Text(
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
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 424,
                            child: Text(
                              products[i].productName,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            // margin: const EdgeInsets.only(left: 422),
                            width: 212,
                            child: Text(
                              '\$${products[i].price}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 212,
                            // margin: const EdgeInsets.only(left: 222),
                            child: Text(
                              products[i].quantity.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 212,
                            // margin: const EdgeInsets.only(left: 222),
                            child: Text(
                              '\$${products[i].total}',
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
              )
          ],
        ),
      ),
    ]);
  }
}
