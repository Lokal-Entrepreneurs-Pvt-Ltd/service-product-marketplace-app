import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

class LocationUtils {
  static Future<bool> _handleLocationPermission() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        UiUtils.showToast('Location permissions are denied');
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
      if (permissionStatus == PermissionStatus.deniedForever) {
        UiUtils.showToast(
            "Location permissions are permanently denied, we cannot request permissions.");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text(
        //         'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
    }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // Request to enable location services
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are not enabled
        UiUtils.showToast("Location is not started. Please try again");
        return false;
      }
    }

    return true; // Location service is enabled and permission granted
  }

  static Future<geo.Position?> getCurrentPosition() async {
    geo.Position? currentPosition;
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return currentPosition;
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);
      currentPosition = position;
    } catch (e) {
      debugPrint(e.toString());
    }
    return currentPosition;
  }
}
