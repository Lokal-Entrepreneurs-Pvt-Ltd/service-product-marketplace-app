import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './fcard.dart';
import './scard.dart';
import './tcard.dart';
import './focard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final int activeUsers = 38628;
  final int totalUsers = 391531;
  final int tickets = 0;
  final int closed = 0;
  final int responsesAwaited = 0;
  final int sales = 950;
  final int newOrders = 822;
  final double revenue = 262180.00;
  final PercentProperty revenueChange = PercentProperty('67', 100);
  final DateTime revenueMonth = DateTime(2022, 07, 21);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FDashboardCard(activeUsers: activeUsers, totalUsers: totalUsers,)
        //SDashboardCard(revenue: revenue, revenueChange: revenueChange, revenueMonth: revenueMonth,)
         //TDashboardCard(newOrders: sales, sales: newOrders,)
        //FoDashboardCard(closed: closed, responsesAwaited: responsesAwaited, tickets: tickets),
      ),
    );
  }
}
