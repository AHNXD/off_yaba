// Import libraries
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  static const routeName = '/search';
  const Search({super.key});

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
                        "الأقسام", // Arabic for "Categories"
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

                  // Button section - Category buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Space buttons horizontally
                    children: <Widget>[
                      // Burger button
                      ElevatedButton(
                        onPressed: () {}, // Arabic for "Burger"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text('برغر'),
                      ),
                      const SizedBox(
                          width: 10.0), // Add spacing between buttons
                      // Pizza button
                      ElevatedButton(
                        onPressed: () {}, // Arabic for "Pizza"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text('بيتزا'),
                      ),
                      const SizedBox(
                          width: 10.0), // Add spacing between buttons
                      // Sushi button
                      ElevatedButton(
                        onPressed: () {}, // Arabic for "Sushi"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text('سوشي'),
                      ),
                    ],
                  ),

                  // Spacer for vertical space
                  const Spacer(),

                  // Bottom area - Discount text
                  const Text(
                    "اقوى التخفيضات", // Arabic for "Strongest Discounts"
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10.0), // Add spacing

                  // "See More" button
                  ElevatedButton(
                    onPressed: () {}, // Arabic for "See More"
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text('عرض المزيد'),
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
