// import 'dart:async';
import 'package:flutter/material.dart';

class RequestAmbulanceDetails extends StatelessWidget {
  const RequestAmbulanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Ambulance',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/request_background.jpg', // Replace with your image path
              fit: BoxFit.cover,
              height: double.infinity, // Ensures image covers the entire screen
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.transparent, // Set the background color to transparent
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 70, bottom: 120), // Adjust top and bottom padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Details for Request Ambulance',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 19), // Increase font size
                    ),
                    // Add controller to get the value automatically
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(fontSize: 20), // Increase font size
                    ),
                    items: ['Male', 'Female', 'Other']
                        .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      // Handle gender selection
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20), // Increase font size
                    ),
                    // Add controller to get the value automatically
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      labelStyle: TextStyle(fontSize: 19), // Increase font size
                    ),
                    // Add controller to get the value automatically
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 20), // Increase font size
                    ),
                    // Add controller to get the value automatically
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Emergency Type',
                      labelStyle: TextStyle(fontSize: 19), // Increase font size
                    ),
                    items: [
                      'Fire Burn',
                      'Cut',
                      'Road Accident',
                      'Fracture',
                      'Collapsing',
                      'Food Poisoning',
                      'Snake Bites',
                      'Heart Attack',
                      'Acid Burn'
                    ]
                        .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      // Handle emergency type selection
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement logic to send request
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent, // Set the background color to green
                      ),
                      child: const Text(
                        'Send Request',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}