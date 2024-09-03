import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(30.316496, 78.032188);
  static const LatLng _pApplePark = LatLng(30.316496, 78.032188);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: {
          Marker(
              markerId: MarkerId("_currentlocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglePlex),
          Marker(
              markerId: MarkerId("sourcelocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pApplePark),
        },
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
  }
}
