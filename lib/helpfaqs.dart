import 'package:flutter/material.dart';

class HelpFaqsDetails extends StatelessWidget {
  const HelpFaqsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help/FAQs',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/request_background.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details for Help/FAQs',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black, // Text color on top of the image
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 20), // Add some space between title and bullets
                // List of items with bullets
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red, size: 38),
                  title: Text(
                    '+254 711 222 222',
                    style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red, size: 38),
                  title: Text(
                    '+254 711 333 333',
                    style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.red, size: 38),
                  title: Text(
                    '+254 711 254 254 ',
                    style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.red, size: 38,),
                  title: Text(
                    'info@emergencycare.co.ke',
                    style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.red, size: 38,),
                  title: Text(
                    'info@ambemergcare.co.ke',
                    style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.red, size: 38,),
                  title: Text(
                    'To Request Ambulance click on Request Ambulance on Dashboard',
                    style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.red, size: 38,),
                  title: Text(
                    'First Aid click on First Aid on Dashboard',
                    style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.red, size: 38,),
                  title: Text(
                    'To get Ambulance Location check on Track Ambulance after you request on Dashboard',
                    style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
