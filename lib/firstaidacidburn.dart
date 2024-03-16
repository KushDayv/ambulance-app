// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class FirstAidItem extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const FirstAidItem({
    required this.title, super.key,
    required this.onPressed,
  });

  @override
  _FirstAidItemState createState() => _FirstAidItemState();
}

class _FirstAidItemState extends State<FirstAidItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 20),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 30,
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          // Additional information or actions can be added here when the widget is expanded
          // For example, you can add a description, images, or further actions
          const SizedBox(height: 10),
          Text(
            'Additional information for ${widget.title}',
            style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
        const Divider(),
      ],
    );
  }
}

class AcidBurnDetails extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  const AcidBurnDetails({super.key, required this.scaffoldKey});

  @override
  State<AcidBurnDetails> createState() => _AcidBurnDetailsState();
}

class _AcidBurnDetailsState extends State<AcidBurnDetails> {
  final url = '';

  bool _hasLaunchedLink = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blueGrey, // Blue background color
            child: const Text(
              'Acid Burn Details',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blueGrey, // Blue background color
            child: const Text(
              'Instructions on how to treat an Acid Burn injury...',
              style: TextStyle(fontSize: 28, color: Colors.white, decoration: TextDecoration.none),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect( // Wrap the image with ClipRRect to avoid overflow
              borderRadius: BorderRadius.circular(10), // Apply border radius to the image
              child: Image.asset(
                'assets/firstaidacidburn.png', // Replace with your image asset path
                fit: BoxFit.fill, // Maintain aspect ratio while filling the container
              ),
            ),
          ),
          const SizedBox(height: 8), // Add spacing between image and button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Only launch the link if it hasn't been launched before
                if (!_hasLaunchedLink) {
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                    _hasLaunchedLink = true; // Mark link as launched
                  } else {
                    widget.scaffoldKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text('Failed to launch the link'),
                      ),
                    );
                  }
                }
              },
              child: const Text('More'),
            ),
          ),
        ],
      ),
    );
  }
}