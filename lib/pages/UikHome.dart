import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:ui_sdk/props/StandardScreenResponse.dart';
import 'package:http/http.dart' as http;

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
    _determinePosition();

    return fetchAlbum();
  }

  @override
  getFunction() {
    // TODO: implement getFunction
    // throw UnimplementedError();
    return of();
  }

  void of() {}
  
  @override
  getReference() {
    // TODO: implement getReference
    // throw UnimplementedError();
    return UikCatalogScreen();
  }

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
  }

  @override
  getFunction() {
    // TODO: implement getFunction
    throw UnimplementedError();
  }

  @override
  getReference() {
    // TODO: implement getReference
    throw UnimplementedError();
  }
}

Future<StandardScreenResponse> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('http://demo6521867.mockable.io/newHomeScreen'),
    headers: {
      "ngrok-skip-browser-warning": "value",
       },
  );

  // StandardScreenResponse
  if (response.statusCode == 200) {
    return StandardScreenResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }

}
