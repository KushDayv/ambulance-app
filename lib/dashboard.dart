// import 'package:flutter/cupertino.dart';
// import 'dart:async';
import 'package:ambulance_app/RequestAmbulance.dart';
import 'package:ambulance_app/settings.dart';
import 'package:flutter/material.dart';
import 'nearbyhospital.dart';
import 'vieworderhistory.dart';
import 'firstaid.dart';
import 'trackambulance.dart';
import 'helpfaqs.dart';
import 'profile.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatelessWidget {

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  const DashboardPage({required this.scaffoldKey, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(showMessage: (message) {
                  // Handle showMessage if needed
                })),
              );
            },
            icon: const Icon(Icons.account_circle, size: 35, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()), // Navigate to your custom settings page
              );
            },
            icon: const Icon(Icons.settings, size: 35, color: Colors.black),
          ),

        ],
      ),
      body: Stack( // Use a Stack widget for layering
        children: [
          // Background image
          Image.asset(
            'assets/dashboard.jpg', // Replace with your dashboard background image
            fit: BoxFit.cover,
            height: double.infinity, // Ensures image covers the entire screen
            width: double.infinity,
          ),
          //
          GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.only(top: 10.0), // Added padding to the GridView
            children: [
              DashboardItem(
                title: 'Request Ambulance',
                imagePath: 'assets/request_ambulance.jpg', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RequestAmbulanceDetails()),
                  );
                },
              ),
              DashboardItem(
                title: 'Nearby Hospital',
                imagePath: 'assets/hospital.png', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NearbyHospitalDetails()),
                  );
                },
              ),
              DashboardItem(
                title: 'Track Ambulance',
                imagePath: 'assets/track.png', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrackAmbulanceDetails()),
                  );
                },
              ),
              DashboardItem(
                title: 'First Aid',
                imagePath: 'assets/first_aid.png', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstAidDetails(scaffoldKey: scaffoldKey)),
                  );
                },
              ),
              DashboardItem(
                title: 'View Order History',
                imagePath: 'assets/history.png', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewOrderHistoryDetails()),
                  );
                },
              ),
              DashboardItem(
                title: 'Help/FAQs',
                imagePath: 'assets/help.jpg', // Adding the path to your image
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpFaqsDetails()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class DashboardItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  const DashboardItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100, // Adjust the height of the image as needed
            width: 200, // Adjust the width of the image as needed
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Adjust the color of the title text as needed
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onPressed,
            // onPressed: () {
            //   // Handle button press
            // },
            child: const Text(
              'View',
              style: TextStyle(fontSize: 22,color: Colors.blue), // Adjust the color of the button text as needed
            ),
          ),
        ],
      ),
    );
  }
}
