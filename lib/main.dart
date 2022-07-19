import 'package:flutter/material.dart';

import './fcard.dart';
import './scard.dart';
import './tcard.dart';
import './focard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FDashboardCard()//SDashboardCard()//TDashboardCard()//FoDashboardCard(),
      ),
    );
  }
}
