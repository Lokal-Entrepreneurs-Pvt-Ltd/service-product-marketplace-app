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
          SizedBox(
            height: 161,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),

                //Code for Membership Banner
                //
                //
                // Container(
                //     color: Color(0xFF3F51B5),
                //     width: MediaQuery.of(context).size.width,
                //     child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Text(
                //             "Save Upto 15% with local App membership",
                //             style: GoogleFonts.poppins(color: Colors.white),
                //           ),
                //           Icon(
                //             Icons.arrow_forward_ios,
                //             color: Colors.white,
                //           )
                //         ],
                //       ),
                //     )),
                //
                //
                GestureDetector(
                  onTap: () async {
                    /* GeoPoint? location = await showSimplePickerLocation(
                      context: context,
                      isDismissible: true,
                      title: "Location Picker",
                      textConfirmPicker: "Select Location",
                      initCurrentUserPosition: false,
                      initZoom: 10,
                      initPosition: GeoPoint(
                        latitude: 28.7041,
                        longitude: 77.1025,
                      ),
                      radius: 8.0,
                    );

                    if (location != null) {
                      print(
                          "Latitude: ${location.latitude} | Longitude: ${location.longitude}");

                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              location.latitude, location.longitude);

                      print(
                          "Area: ${placemarks[0].street} | City: ${placemarks[0].locality} | State: ${placemarks[0].administrativeArea}");

                      setState(() {
                        street = placemarks[0].street!;
                        city = placemarks[0].locality!;
                        state = placemarks[0].administrativeArea!;
                      });
                    } */
                  },
                  child: Cell(
                    titleText: street,
                    subtitleText: "$city - $state",
                    leftChild: const Icon(
                      Icons.location_on,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                const SearchBar(),
              ],
            ),
          ),
          Expanded(child: UikHome().page),
        ],
      ),
    );
  }
}
