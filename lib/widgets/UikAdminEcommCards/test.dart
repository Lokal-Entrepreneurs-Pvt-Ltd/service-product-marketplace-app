import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/widgets/UikAdminEcommCards/AddNewCustomer/AddNewCustomerCard.dart';
import 'package:login/widgets/UikAdminEcommCards/AddNewProduct/Addnewproduct.dart';
import 'package:login/widgets/UikAdminEcommCards/OrderDetailsCard/OrderDetailsCard.dart';
import 'package:login/widgets/UikAdminEcommCards/ActiveOrderCard.dart';
// import 'package:login/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductCard.dart';
// import 'package:login/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductPrice.dart';
import 'package:login/widgets/UikAdminEcommCards/OrderListCard.dart';
import 'package:login/widgets/UikAdminEcommCards/ProductDetailsCard.dart';
// import 'package:login/widgets/UikAdminEcommCards/AddNewProduct/UikPricingCard.dart';
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
