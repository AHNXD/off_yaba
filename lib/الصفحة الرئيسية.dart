// Import libraries
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          // Use Stack to position elements on top of each other
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
                  // Top area - App name and search bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align elements horizontally with space in between
                    children: <Widget>[
                      // App name text
                      const Text(
                        "OFF YABA",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Search bar
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.6, // Take 60% of screen width
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        child: const Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(
                                width:
                                    10.0), // Add spacing between icon and text
                            Text(
                              "البحث", // Arabic text for "Search"
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bottom area - Offers section and buttons
                  Column(
                    // Column to stack elements vertically
                    children: <Widget>[
                      // Title text
                      const Text(
                        "المزيد                         اقوى التخفيضات", // Arabic text with special spacing
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10.0), // Add spacing

                      // See more button
                      ElevatedButton(
                        onPressed: () {}, // Arabic text for "See More"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text('المزيد'),
                      ),

                      const SizedBox(height: 20.0), // Add spacing

                      // List of restaurants (replace with your widget)
                      SizedBox(
                        height:
                            150.0, // Set a specific height for the list area
                        child: ListView(
                          // Simulate a list view for restaurants
                          scrollDirection:
                              Axis.horizontal, // Scroll horizontally
                          children: <Widget>[
                            // Individual restaurant item (repeat for multiple restaurants)
                            SizedBox(
                              width: 150.0, // Width of each restaurant item
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      'assets/restaurant.jpg'), // Replace with your restaurant image
                                  const Text(
                                    "Burger King", // Restaurant name
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width:
                                    10.0), // Add spacing between restaurant items
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
