import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      body: Column(
        children: [
          Expanded(child: Image.asset('assests/images/map_ki_photo.png')
              //GoogleMap(
              //onMapCreated: (GoogleMapController controller) {
              //_mapController.complete(controller);
              //},
              //initialCameraPosition: const CameraPosition(
              //target: _location1,
              // zoom: 13,
              //),
              //markers: {
              //Marker(
              //markerId: const MarkerId("_location1"),
              //position: _location1,
              //infoWindow: const InfoWindow(title: "Location 1"),
              //),
              // Marker(
              // markerId: const MarkerId("_location2"),
              // position: _location2,
              // infoWindow: const InfoWindow(title: "Location 2"),
              // ),
              //},
              //),
              ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, 'checkin');
              },
              color: Colors.green,
              child: const Text('CHECK IN TIME',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
