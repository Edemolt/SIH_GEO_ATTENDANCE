import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart';
import 'dart:async';

class MyMapPage extends StatefulWidget {
  final int index;

  const MyMapPage(this.index, {super.key});

  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  LatLng _initialPosition = const LatLng(20.5937, 78.9629); // Default: India

  String _darkMapStyle = '';

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final hasPermission = await _location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await _location.requestPermission();
    }

    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      await _location.requestService();
    }

    final currentLocation = await _location.getLocation();

    setState(() {
      _initialPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });

    // Move camera to user's current location
    _mapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, 15));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(_darkMapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: const Color(0xFF8967B3),
      ),
      bottomNavigationBar: GNav(
        tabBackgroundColor: const Color(0xFF8967b3),
        activeColor: const Color(0xFFE6D9A2),
        backgroundColor: const Color(0xFF8967b3),
        gap: 15,
        selectedIndex: 0,
        onTabChange: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, 'details');
          } else if (index == 2) {
            Navigator.pushNamed(context, 'leave');
          } else if (index == 3) {
            Navigator.pushNamed(context, 'login');
          }
        },
        tabs: const [
          GButton(icon: Icons.map, text: 'Map'),
          GButton(icon: Icons.person, text: 'Employees'),
          GButton(icon: Icons.messenger_outlined, text: 'Requests'),
          GButton(icon: Icons.logout_rounded, text: 'Log Out'),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 10,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}
