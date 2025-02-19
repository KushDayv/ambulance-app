import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyHospitalDetails extends StatefulWidget {
  const NearbyHospitalDetails({super.key});

  @override
  _NearbyHospitalDetailsState createState() => _NearbyHospitalDetailsState();
}

class _NearbyHospitalDetailsState extends State<NearbyHospitalDetails> {
  final Completer<GoogleMapController> googleMapCompleterController =
  Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositionOfUser;
  Set<Marker> markers = {}; // Set of markers

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(-#.##############, ##.#############),
    zoom: 16.4746,
  );

  @override
  void initState() {
    super.initState();
    addMarkerToInitialPosition();
  }

  addMarkerToInitialPosition() {
    setState(() {
      markers.add(
        Marker(
          markerId: const MarkerId('initialPositionMarker'),
          position: initialPosition.target,
          infoWindow: const InfoWindow(title: 'Initial Position'),
        ),
      );
    });
  }

  getCurrentLiveLocationOfUser() async {
    Position positionOfUser =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfUser = positionOfUser;

    LatLng positionOfUserInLatLng = LatLng(currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);

    // Create a marker for the camera position
    setState(() {
      markers.add(
        Marker(
          markerId: const MarkerId('cameraPositionMarker'),
          position: positionOfUserInLatLng,
          infoWindow: const InfoWindow(title: 'Camera Position'),
        ),
      );
    });

    CameraPosition cameraPosition =
    CameraPosition(target: positionOfUserInLatLng, zoom: 15);
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: initialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(controllerGoogleMap);
              getCurrentLiveLocationOfUser();
            },
            markers: markers,
          ),
        ],
      ),
    );
  }
}
