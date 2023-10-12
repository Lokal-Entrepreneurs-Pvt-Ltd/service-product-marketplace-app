// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ui_sdk/props/ApiResponse.dart';
//
// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenScreenState();
// }
//
// class _LocationScreenScreenState extends State<LocationScreen>
//     with TickerProviderStateMixin {
//   late Future<ApiResponse> _agentsList;
//   late dynamic args;
//   Position? _currentPosition;
//
//   @override
//   void didChangeDependencies() {
//     args = ModalRoute.of(context)?.settings.arguments;
//     super.didChangeDependencies();
//   }
//
//   @override
//   void initState() {
//     // _agentsNotifyList = [];
//     super.initState();
//   }
//
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//
// // Now Create Method named _getCurrentLocation with async Like Below.
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBodyContainer() {
//     return FutureBuilder(
//       future: null,
//       builder: (context, AsyncSnapshot<ApiResponse> snap) {
//         if (snap.connectionState == ConnectionState.waiting) {
//           return _buildLoadingIndicator();
//         } else if (snap.hasError) {
//           return Center(
//             child: Text("Something went wrong\t ${snap.error}"),
//           );
//         }
//         dynamic data = snap.data?.data;
//         return _buildBody();
//       },
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//           color: Colors.black,
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       ),
//       title: Text(
//         "Location Input",
//         style: GoogleFonts.poppins(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('LAT: ${_currentPosition?.latitude ?? ""}'),
//           Text('LNG: ${_currentPosition?.longitude ?? ""}'),
//           const SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: _getCurrentPosition,
//             child: const Text("Get Current Location"),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingIndicator() {
//     return const Center(
//       child: CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
//       ),
//     );
//   }
// }
