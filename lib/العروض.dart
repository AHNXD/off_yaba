// Import libraries
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  static const routeName = '/offers';
  const Offers({super.key});

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

                  // Content area - Restaurant list with images and text
                  Expanded(
                    // Use Expanded widget for scrollable content
                    child: ListView.builder(
                        itemCount:
                            4, // Replace with the number of restaurant items
                        itemBuilder: (context, index) {
                          return restaurantItem(context, index);
                        }),
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

// Reusable restaurant item widget (replace with your data)
Widget restaurantItem(BuildContext context, int index) {
  return Container(
      margin: const EdgeInsets.only(bottom: 10.0), // Add space between items
      child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to top of image
          children: <Widget>[
            // Restaurant image
            Container(
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(width: 10.0), // Add spacing between image and text
            // Restaurant details
            const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: <Widget>[
                  Text(
                    "اسم المطعم", // Arabic text for "Restaurant Name" (replace with actual name)
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "المأكولات المقدمة", // Arabic text for "Cuisine" (replace with actual cuisine)
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.amber, size: 16)
                  ])
                ])
          ]));
}
