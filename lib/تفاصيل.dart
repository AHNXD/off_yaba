// Import libraries
import 'package:flutter/material.dart';

class Prop extends StatelessWidget {
  static const routeName = '/prop';
  const Prop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Set background color
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(// Use Stack to position elements on top of each other
                children: <Widget>[
          // Background image
          SizedBox(
            width: double.infinity, // Cover entire width
            height: double.infinity, // Cover entire height
            child: Image.asset(
              'assets/background.jpg', // Replace with your image path
              fit: BoxFit.cover, // Cover the container with the image
            ),
          ),
          // Content positioned on top of the background
          Padding(
              padding: const EdgeInsets.all(20.0), // Add padding from all sides
              child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribute content vertically with space in between
                  children: <Widget>[
                    // Top area - App name and details
                    const Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align elements horizontally with space in between
                      children: <Widget>[
                        // App name text
                        Text(
                          "KFC", // Restaurant name based on your description
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Info section with icon and text
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(
                                width:
                                    5.0), // Add spacing between icon and text
                            Text(
                              "4.7", // Replace with actual rating
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0), // Add spacing

                    // Offer section - Card with rounded corners
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.all(10.0), // Add padding inside the card
                        child: Column(
                          children: <Widget>[
                            // Offer title
                            Text(
                              "Offers", // Replace with actual title based on your image
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.0), // Add spacing

                            // Offer details - Replace with your actual offer text
                            Text(
                              "20% discount on all burgers", // Replace with actual offer details
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Spacer for vertical space
                    const Spacer(),

                    // Details section - Row with icons and text
                    const Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Distribute icons and text evenly
                        children: <Widget>[
                          // Location icon and text
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              SizedBox(
                                  width:
                                      5.0), // Add spacing between icon and text
                              Text(
                                "0.8 km", // Replace with actual distance based on your image
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // Time icon and text
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              SizedBox(
                                  width:
                                      5.0), // Add spacing between icon and text
                              Text(
                                "20 min delivery", // Replace with actual delivery time based on your image
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // Short description - Replace with actual description based on your image
                        ])
                  ]))
        ])));
  }
}
