import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(30.3165, 78.0322);
  static const LatLng _pApplePark = LatLng(26.1832, 76.9683);
  LatLng? _currentP;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  final int _selectedIndex = 0; // Set default index to 0 for "Home"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xFF6962AD),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xFF6962AD),
            color: const Color(0xFF000000),
            activeColor: const Color(0xFF000000),
            tabBackgroundColor: const Color(0xFF83C0C1),
            gap: 45,
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex, // Set active index to 0
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'HOME',
              ),
              GButton(
                icon: Icons.watch_later,
                text: 'Manual',
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
              ),
              GButton(
                icon: Icons.arrow_back_ios_new_rounded,
                text: 'Log Out',
              ),
            ],
            onTabChange: (index) {
              if (index == 0) {
                // Navigate to 'home' route
                Navigator.pushNamed(context, 'map');
              } else if (index == 1) {
                // Navigate to 'checkin' route
                Navigator.pushNamed(context, 'checkin');
              } else if (index == 2) {
                // Navigate to 'history' route
                Navigator.pushNamed(context, 'history');
              } else if (index == 3) {
                // Navigate to 'login' route (Log Out)
                Navigator.pushNamed(context, 'login');
              }
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7, // Take 7/8 of the screen for the map
            child: _currentP == null
                ? const Center(
                    child:
                        CircularProgressIndicator(), // Use a loading indicator
                  )
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                    initialCameraPosition: const CameraPosition(
                      target: _pGooglePlex,
                      zoom: 13,
                    ),
                    markers: {
                      if (_currentP != null)
                        Marker(
                          markerId: const MarkerId("_currentLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _currentP!,
                        ),
                      const Marker(
                          markerId: MarkerId("_sourceLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _pGooglePlex),
                      const Marker(
                          markerId: MarkerId("_destionationLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _pApplePark),
                    },
                    polylines: Set<Polyline>.of(polylines.values),
                    myLocationEnabled: true, // Show user's current location
                    myLocationButtonEnabled: true,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}
