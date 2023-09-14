import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAdminEcommCards/OrderDetailsCard/OrderDetailsCard.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductCard.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikAddNewProductPrice.dart';
// import 'package:lokal/widgets/UikAdminEcommCards/AddNewProduct/UikPricingCard.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
