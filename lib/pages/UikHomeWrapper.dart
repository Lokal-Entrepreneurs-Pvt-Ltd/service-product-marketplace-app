import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:lokal/pages/UikHome.dart';

import '../Widgets/UikSearchBar/searchbar.dart';
import '../widgets/UikCell/UikCell.dart';

class UikHomeWrapper extends StatelessWidget {
  const UikHomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 16.0),
                Cell(
                  titleText: "Sector 14",
                  subtitleText: "Gurgaon - Haryana",
                  leftChild: Icon(Icons.location_on),
                ),
                SearchBar(),
              ],
            ),
          ),
          Expanded(child: UikHome().page),
        ],
      ),
    );
  }
}
