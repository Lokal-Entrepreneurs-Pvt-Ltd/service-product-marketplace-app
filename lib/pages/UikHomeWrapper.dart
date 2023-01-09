import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lokal/pages/UikHome.dart';

import '../Widgets/UikSearchBar/searchbar.dart';
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
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const UikLocationMap(),
                    //   ),
                    // );

                    GeoPoint? location = await showSimplePickerLocation(
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
                    }
                  },
                  child: Cell(
                    titleText: street,
                    subtitleText: "$city - $state",
                    leftChild: const Icon(Icons.location_on),
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
