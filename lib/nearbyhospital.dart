import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class NearbyHospitalDetails extends StatefulWidget {
  const NearbyHospitalDetails({super.key});

  @override
  _NearbyHospitalDetailsState createState() => _NearbyHospitalDetailsState();
}

class _NearbyHospitalDetailsState extends State<NearbyHospitalDetails> {
  late GoogleMapController mapController;
  late Position _currentPosition;
  late List<Map<String, dynamic>> _hospitalData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  Future<void> _initPage() async {
    await _getCurrentLocation();
    await _getNearbyHospitals();
    setState(() {
      _isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _getNearbyHospitals() async {
    const apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';
    const baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

    final response = await http.get(Uri.parse(
        '$baseUrl?location=${_currentPosition.latitude},${_currentPosition.longitude}&radius=5000&type=hospital&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      setState(() {
        _hospitalData = results.map((result) {
          return {
            'name': result['name'],
            'distance': _calculateDistance(result['geometry']['location']['lat'], result['geometry']['location']['lng']),
            'position': LatLng(result['geometry']['location']['lat'], result['geometry']['location']['lng']),
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load nearby hospitals');
    }
  }

  double _calculateDistance(double lat, double lng) {
    final double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      lat,
      lng,
    );
    return distanceInMeters / 1000; // Convert meters to kilometers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nearby Hospitals',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300, // Set a fixed height for the map
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                ),
                zoom: 14.0,
              ),
              markers: _createMarkers(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _hospitalData.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> hospital = _hospitalData[index];
                return ListTile(
                  title: Text(hospital['name']),
                  subtitle: Text('${hospital['distance']} km away'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _openInMaps(hospital['position']);
                    },
                    child: const Text('Go'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return _hospitalData.map((hospital) {
      return Marker(
        markerId: MarkerId(hospital['name']),
        position: hospital['position'],
        infoWindow: InfoWindow(title: hospital['name']),
      );
    }).toSet();
  }

  void _openInMaps(LatLng position) {
    // You can use a package like url_launcher to open Google Maps with directions
    // Example usage: url_launcher: ^7.3.0
    // For simplicity, we'll just show a toast message here.
    Fluttertoast.showToast(
      msg: 'Open Google Maps with directions to ${position.latitude},${position.longitude}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
