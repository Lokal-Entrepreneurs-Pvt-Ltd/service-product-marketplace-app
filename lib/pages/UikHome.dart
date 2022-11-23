import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login/StandardScreenClient.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';

import '../constants.dart';

class UikHome extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add("OPEN_WEB");
    actionList.add("OPEN_HALA");
    return actionList;
  }

  @override
  Future<StandardScreenResponse> getData() {
    // _printCurrentLocation();
    _determinePosition();

    return fetchAlbum();
  }

  // void _printCurrentLocation() async {
  //   Position getCurrentPosition = await _determinePosition();

  //   print(getCurrentPosition.latitude);
  //   print(getCurrentPosition.longitude);
  // }

  // Future<Position> _determinePosition() async {
  void _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    print(currentPosition.latitude);
    print(currentPosition.longitude);

    // return await Geolocator.getCurrentPosition();
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
  final dio = Dio();

  dio.options.headers["ngrok-skip-browser-warning"] = "value";

  // final client =
  //     StandardScreenClient(dio, baseUrl: "https://demo1773855.mockable.io/");
  final client =
      StandardScreenClient(dio, baseUrl: baseUrl);

  ApiResponse response = await client.getMainPageOne();

  return StandardScreenResponse.fromJson(response.data);
}
