import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewCustomer/AddNewCustomerCard.dart';
import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/Addnewproduct.dart';
import 'package:lokal/widgets/UikAdminEcommCards/OrderDetailsCard/OrderDetailsCard.dart';
import 'package:lokal/widgets/UikAdminEcommCards/ActiveOrderCard.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductCard.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductPrice.dart';
import 'package:lokal/widgets/UikAdminEcommCards/OrderListCard.dart';
import 'package:lokal/widgets/UikAdminEcommCards/ProductDetailsCard.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikPricingCard.dart';
import 'ProductCard.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
            // ProductCard(),
            // ProductDetails()
            // Addnewproduct()
            // OrderListCard()
            orderDetails(),
        // ActiveOrder(),
        // AddNewCustomer(),
      ),
    );
  }
}
