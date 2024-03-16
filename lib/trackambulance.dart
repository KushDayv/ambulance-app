import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TrackAmbulanceDetails extends StatefulWidget {
  const TrackAmbulanceDetails({super.key});

  @override
  _TrackAmbulanceDetailsState createState() => _TrackAmbulanceDetailsState();
}

class _TrackAmbulanceDetailsState extends State<TrackAmbulanceDetails> {
  Position? _currentPosition;
  double _distanceInMeters = 0;
  double _timeInMinutes = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _calculateDistanceAndTime();
    });
  }

  void _calculateDistanceAndTime() {
    if (_currentPosition != null) {
      // Calculate distance and time to ambulance location
      // For demonstration purposes, let's assume the ambulance is at a fixed location
      const ambulanceLocation = LatLng(37.42, -122.08); // Sample ambulance position
      _distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          ambulanceLocation.latitude,
          ambulanceLocation.longitude);
      _timeInMinutes = _distanceInMeters / 50 / 60; // Convert meters to minutes, assuming ambulance speed of 50 m/s
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Ambulance',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPosition != null)
              Text(
                'Distance to Ambulance: ${_distanceInMeters.toStringAsFixed(2)} meters',
              ),
            if (_currentPosition != null)
              Text(
                'Time left for Ambulance: ${_timeInMinutes.toStringAsFixed(0)} minutes',
              ),
          ],
        ),
      ),
    );
  }
}
