import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:location/location.dart' as loc;
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

  static Future<loc.LocationData?> getCurrentPosition() async {
    final location = loc.Location();

    // Check if location services are enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    // Check for permissions
    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return null;
    }

    try {
      // Get current location
      final currentPosition = await location.getLocation();
      return currentPosition;
    } catch (e) {
      debugPrint("Location error: $e");
      return null;
    }
  }



}
