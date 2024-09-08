import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _location1 = LatLng(30.316496, 78.032188);
  static const LatLng _location2 = LatLng(30.3283021, 78.0586985);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: const CameraPosition(
          target: _location1,
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("location1"),
            position: _location1,
            infoWindow: const InfoWindow(title: "Location 1"),
          ),
          Marker(
            markerId: const MarkerId("location2"),
            position: _location2,
            infoWindow: const InfoWindow(title: "Location 2"),
          ),
        },
      ),
    );
  }
}
