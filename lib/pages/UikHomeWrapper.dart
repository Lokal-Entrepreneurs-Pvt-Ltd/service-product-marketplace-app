import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/pages/UikHome.dart';

import '../Widgets/UikSearchBar/searchbar.dart';
import '../utils/uik_color.dart';
import '../widgets/UikCell/UikCell.dart';

class UikHomeWrapper extends StatefulWidget {
  const UikHomeWrapper({super.key});

  @override
  State<UikHomeWrapper> createState() => _UikHomeWrapperState();
}

class _UikHomeWrapperState extends State<UikHomeWrapper> {
  String street = "New Delhi";
  String city = "Dehli";
  String state = "Delhi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(height: 20.0),
          // const SearchBar(),
          Expanded(child: UikHome().page),
        ],
      ),
    );
  }
}
